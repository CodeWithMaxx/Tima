import 'dart:convert';
import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';
import 'package:http/http.dart' as http;
import 'package:tima_app/DataBase/dataHub/secureStorageService.dart';
import 'package:tima_app/DataBase/keys/keys.dart';
import 'package:tima_app/core/constants/apiUrlConst.dart';
import 'package:tima_app/core/constants/colorConst.dart';
import 'package:tima_app/feature/LogOut/logout.dart';
import 'package:tima_app/feature/home/screen/home.dart';
import 'package:tima_app/router/routes/routerConst.dart';

abstract class HomeBuilder extends State<Home> {
  final SecureStorageService secureStorageService = SecureStorageService();
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  final storageHub = const FlutterSecureStorage();

  String? userEmail;
  String? userName;
  String? timaHomeLogo;
  List<ScreenHiddenDrawer> pages = [];
  int currentSlider = 0;

  usreInit() async {
    userName = await storageHub.read(key: StorageKeys.NameKey);
    userEmail = await storageHub.read(key: StorageKeys.emailKey);
    timaHomeLogo = await storageHub.read(key: StorageKeys.timaLogoKey);
    setState(() {});
  }

  bool isLoading = true;

  // loadData() {
  //   Future.delayed(
  //     const Duration(seconds: 2),
  //   );
  // }

  int current = 0; // Current index of the carousel
  final CarouselController controller = CarouselController();
  String title = '';

  String titlemessage = "Tima";
  bool isImageLoading = true;
  List<String> imgList = [];
  // var logoMessage;
  List imageSliders = ['assets/banner.jpg', 'assets/banner1.jpg'];

  // * load banner images from api

  Future<void> callHomeBannerFromApi() async {
    String? userId =
        await secureStorageService.getUserID(key: StorageKeys.userIDKey);
    String? companyId = await secureStorageService.getUserCompanyID(
        key: StorageKeys.companyIdKey);
    String username =
        await secureStorageService.getUserName(key: StorageKeys.NameKey) ??
            'Guest';
    String useremail =
        await secureStorageService.getUserEmailID(key: StorageKeys.emailKey) ??
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
            secureStorageService.saveUserLoginToken(
                key: 'loggedIn', value: false);
            // GoRouter.of(context).goNamed(routerConst.homePage);
            title = bannerDataDecoded['logo_message'];
            storageHub.write(
                key: StorageKeys.timaLogoKey,
                value: bannerDataDecoded['logo_message']);
            secureStorageService.saveTimaLogo(
                key: StorageKeys.timaLogoKey, value: bannerDataDecoded['logo']);

            log("userLogin_title : $title ");
            // imageSliders.addAll(bannerDataDecoded['data']);
            // userName = username;
            // userEmail = useremail;

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

  Widget get HiddenDrawerView => HiddenDrawerMenu(
        backgroundColorMenu: Colors.deepPurpleAccent,
        screens: pages,
      );

  Widget get TimaAppDrawer => Drawer(
        child: ListView(
          children: [
            SizedBox(
              // padding: const EdgeInsets.only(left: 20),
              height: 250,
              width: MediaQuery.of(context).size.width,
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
                  Container(
                    padding: EdgeInsets.only(left: 15.w),
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      userName.toString(),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.only(left: 15.w),
                      width: MediaQuery.of(context).size.width,
                      child: Text(userEmail.toString())),
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
              onTap: () => context.pushNamed(routerConst.homeForgotPass),
              leading: const Icon(Icons.password),
              title: const Text(
                "Forgot Password",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
              ),
            ),
            ListTile(
              onTap: () => context.pushNamed(routerConst.register, extra: '0'),
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
                GoRouter.of(context)
                    .pushNamed(routerConst.recivedInquiry, extra: '0');
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
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return CustomDialog();
                  },
                );
              },
            ),
            const SizedBox(
              height: 100,
            )
          ],
        ),
      );

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
          carouselController: controller,
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
                current = index;
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
                          width: current == index ? 16 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: current == index ? blueColor : Colors.white,
                          )),
                    )),
          ),
        )
      ],
    );
  }

  // * show logout dailoge feature box
}
