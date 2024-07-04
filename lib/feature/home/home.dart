// ignore_for_file: unused_label
import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:tima_app/DataBase/dataHub/secureStorageService.dart';
import 'package:tima_app/DataBase/keys/keys.dart';
import 'package:tima_app/core/GWidgets/btnText.dart';
import 'package:tima_app/core/constants/apiUrlConst.dart';
import 'package:tima_app/core/constants/colorConst.dart';
import 'package:tima_app/core/constants/textconst.dart';
import 'package:tima_app/router/routes/routerConst.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with WidgetsBindingObserver {
  final SecureStorageService _secureStorageService = SecureStorageService();
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  int currentSlider = 0;
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    callHomeBannerFromApi();
    super.initState();
  }

  bool isLoading = true;

  loadData() {
    Future.delayed(
      const Duration(seconds: 2),
    );
  }

  int _current = 0; // Current index of the carousel
  final CarouselController _controller = CarouselController();
  String title = '';

  String titlemessage = "Tima";
  bool isImageLoading = true;
  List<String> imgList = [];
  String? userEmail;
  String? userName;
  // var logoMessage;
  List imageSliders = ['assets/banner.jpg', 'assets/banner1.jpg'];

  // * load banner images from api

  Future<void> callHomeBannerFromApi() async {
    String? userId =
        await _secureStorageService.getUserID(key: StorageKeys.userIDKey);
    String? companyId = await _secureStorageService.getUserCompanyID(
        key: StorageKeys.companyIdKey);
    String username =
        await _secureStorageService.getUserName(key: StorageKeys.NameKey) ??
            'Guest';
    String useremail =
        await _secureStorageService.getUserEmailID(key: StorageKeys.emailKey) ??
            'not EmailID Found';

    isImageLoading = true;
    final client = http.Client();
    try {
      final response = await client.post(Uri.parse(get_slider_url), body: {
        'company_id': companyId,
        'user_id': userId
      }).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        Map<String, dynamic> bannerDataDecoded = jsonDecode(response.body);
        var userLoginSuccessStatusCode = bannerDataDecoded['user_login_status'];
        if (userLoginSuccessStatusCode == 1) {
          setState(() {
            _secureStorageService.saveUserLoginToken(
                key: 'loggedIn', value: false);
            // GoRouter.of(context).goNamed(routerConst.homePage);
            title = bannerDataDecoded['logo_message'];
            _secureStorageService.saveTimaLogo(
                key: StorageKeys.timaLogoKey, value: bannerDataDecoded['logo']);

            log("userLogin_title : $title ");
            // imageSliders.addAll(bannerDataDecoded['data']);
            userName = username;
            userEmail = useremail;

            imgList = List.from(bannerDataDecoded['data']);
          });
        }
      }

      log("userLogin_title : ${title.toString()}");

      log("imageSliders:--> $imageSliders ");

      isImageLoading = false;
    } catch (error) {
      log(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            "Tima",
            style: GoogleFonts.poppins(
                fontSize: 22.w, color: greyColor, fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.notifications_active,
                  color: greyColor,
                ))
          ],
        ),
        body: Column(
          children: [
            SizedBox(
              height: 10.h,
            ),
            Container(
                alignment: Alignment.center,
                height: 180,
                width: double.infinity,
                margin: const EdgeInsets.only(
                  left: 12,
                  right: 12,
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: secondryGreyColor.withOpacity(.5)),
                child: ImageSlider()),
            SizedBox(
              height: 60.h,
            ),
            SizedBox(
              height: 50.h,
            ),
            txtHelper()
                .heading1Text(title.toString().toString(), 25, blueColor),
          ],
        ),
        drawer: TimaAppDrawer,
      ),
    );
  }

  ImageSlider() {
    return Stack(
      children: [
        CarouselSlider(
          items: imageSliders
              .map(
                (images) => Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      images,
                      fit: BoxFit.cover,
                      width: 1000,
                    ),
                  ),
                ),
              )
              .toList(),
          carouselController: _controller,
          options: CarouselOptions(
            height: 280.0,
            enlargeCenterPage: true,
            autoPlay: true,
            // aspectRatio: 16 / 9,
            autoPlayCurve: Curves.fastOutSlowIn,
            enableInfiniteScroll: true,
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            viewportFraction: 0.8,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
          ),
        ),
        Positioned.fill(
          top: 150,
          left: 155,
          child: Row(
            children: List.generate(
                imageSliders.length,
                (index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3),
                      child: AnimatedContainer(
                          duration: const Duration(microseconds: 300),
                          // padding: const EdgeInsets.symmetric(horizontal: 3),
                          width: _current == index ? 16 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: _current == index ? blueColor : Colors.white,
                          )),
                    )),
          ),
        )
      ],
    );
  }

  Widget get TimaAppDrawer => Drawer(
        child: ListView(
          children: [
            SizedBox(
              // padding: const EdgeInsets.only(left: 20),
              height: 200,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/timalogo.jpeg',
                          height: 100,
                          width: 100,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      userName.toString(),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(userEmail.toString()),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  const Divider(
                    height: 2,
                  )
                ],
              ),
            ),
            ListTile(
              onTap: () => context.pushNamed(routerConst.forgotPage),
              leading: const Icon(Icons.password),
              title: const Text(
                "Forgot Password",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
              ),
            ),
            ListTile(
              onTap: () => context.pushNamed(routerConst.register),
              leading: const Icon(Icons.person),
              title: const Text(
                "Registration",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
              ),
            ),
            ListTile(
              onTap: () => GoRouter.of(context)
                  .pushNamed(routerConst.homeUpdateLocation),
              leading: const Icon(Icons.location_on),
              title: const Text(
                "Home Location",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
              ),
            ),
            ListTile(
              onTap: () => context.pushNamed(routerConst.createInquiryPage),
              leading: const Icon(Icons.calendar_today_rounded),
              title: const Text(
                "Create Inquiry",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
              ),
            ),
            ListTile(
              onTap: () {
                GoRouter.of(context).pushNamed(routerConst.recivedInquiry);
              },
              leading: const Icon(Icons.calendar_today_rounded),
              title: const Text(
                "Recive Inquiry",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
              ),
            ),
            ListTile(
              onTap: () {
                GoRouter.of(context)
                    .pushNamed(routerConst.generateInquiry, extra: '0');
              },
              leading: const Icon(Icons.calendar_today_rounded),
              title: const Text(
                "Generated Inquiry",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text(
                "LogOut",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
              ),
              onTap: () {
                showAdaptiveDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog.adaptive(
                        title: lebelText(
                            labelText: 'LogOut', size: 17, color: blueColor),
                        content: lebelText(
                            labelText: 'Do you want to logout to TimaApp',
                            size: 15,
                            color: Colors.black),
                        actions: [
                          // * logout action done button
                          ElevatedButton(
                              onPressed: () {
                                secureStorage.write(
                                    key: StorageKeys.loginKey,
                                    value: false.toString());
                                // SystemNavigator.pop();
                                GoRouter.of(context)
                                    .goNamed(routerConst.loginScreen);

                                ModalRoute.withName(routerConst.loginScreen);
                              },
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  backgroundColor: Colors.red),
                              child: Text(
                                'Yes',
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              )),

                          // * logout action cencel button
                          ElevatedButton(
                              onPressed: () {
                                GoRouter.of(context).pop();
                              },
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  backgroundColor: Colors.green),
                              child: Text(
                                'No',
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ))
                        ],
                      );
                    });
              },
            ),
            const SizedBox(
              height: 100,
            )
          ],
        ),
      );
}
