import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tima_app/ApiService/postApiBaseHelper.dart';
import 'package:tima_app/DataBase/dataHub/secureStorageService.dart';
import 'package:tima_app/DataBase/keys/keys.dart';
import 'package:tima_app/core/GWidgets/btnText.dart';
import 'package:tima_app/core/constants/apiUrlConst.dart';
import 'package:tima_app/core/constants/colorConst.dart';
import 'package:tima_app/providers/LocationProvider/location_provider.dart';
import 'package:tima_app/router/routes/routerConst.dart';

class HomeMapLocation extends StatefulWidget {
  const HomeMapLocation({super.key});

  @override
  State<HomeMapLocation> createState() => _HomeMapLocationState();
}

class _HomeMapLocationState extends State<HomeMapLocation> {
  final LocationProvider _locationProvider = LocationProvider();
  final SecureStorageService _secureStorageService = SecureStorageService();
  @override
  void initState() {
    _locationProvider.updateMap();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<LocationProvider>(builder: (_, ref, __) {
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: Padding(
              padding: const EdgeInsets.only(left: 15, top: 10, bottom: 3),
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back_outlined,
                  color: colorConst.primarycolor,
                ),
                padding: const EdgeInsets.all(0),
                onPressed: () {
                  GoRouter.of(context).goNamed(routerConst.homeNavBar);
                },
              ),
            ),
            title: const Center(
              child: Text(
                'Home Location',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: 'Metropilis',
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            width: size.width,
            child: Center(
                child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: 65,
                    width: 65,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: tfColor),
                    child: const Icon(Icons.location_on,
                        color: colorConst.primarycolor, size: 45),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  const Text(
                    'User Location',
                    style: TextStyle(
                      color: Colors.black54,
                      letterSpacing: 0.5,
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    ref.lat.value.toString(),
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 25,
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Text(
                    ref.lng.value.toString(),
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 25,
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Text(
                    ref.address.value,
                    style: const TextStyle(
                        color: colorConst.primarycolor,
                        fontSize: 18,
                        letterSpacing: 1.8),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            backgroundColor: blueColor),
                        onPressed: () async {
                          dynamic isUpdateLoc = await _secureStorageService
                                  .getUpdateLocation(key: true) ??
                              false;
                          if (isUpdateLoc != true) {
                            ref.updateMap();
                            var userID = _secureStorageService.getUserID(
                                key: StorageKeys.userIDKey);
                            var url = Uri.parse(updatehome_location_url);
                            var body = ({
                              'user_id': userID,
                              'location': '${ref.lat.value},${ref.lng.value}'
                            });
                            var response =
                                await ApiBaseHelper().postAPICall(url, body);

                            if (response.statusCode == 200) {
                              var responsedata = jsonDecode(response.body);
                              log("client registration : $body");
                              log("client registration : ${response.body}");
                              Fluttertoast.showToast(
                                  msg: responsedata['message']);
                              _secureStorageService.saveUpdateLocation(
                                  key: StorageKeys.updateLocKey, value: true);
                            } else {
                              Fluttertoast.showToast(
                                  msg: "Your Location Already Up to Date");
                            }
                          }
                        },
                        icon: const Icon(
                          Icons.refresh_outlined,
                          color: Colors.white,
                          size: 25,
                        ),
                        label: lebelText(
                            labelText: 'Update Home Location',
                            size: 17,
                            color: Colors.white),
                      ))
                ],
              ),
            )),
          ),
        ),
      );
    });
  }
}
