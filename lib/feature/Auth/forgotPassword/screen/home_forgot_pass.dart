// ignore_for_file: prefer_final_fields, unused_field

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:tima_app/DataBase/dataHub/secureStorageService.dart';
import 'package:tima_app/DataBase/keys/keys.dart';
import 'package:tima_app/core/GWidgets/toast.dart';
import 'package:tima_app/core/constants/apiUrlConst.dart';
import 'package:tima_app/core/constants/colorConst.dart';
import 'package:tima_app/core/constants/textconst.dart';
import 'package:tima_app/router/routes/routerConst.dart';

class HomeForgotPass extends StatefulWidget {
  const HomeForgotPass({super.key});

  @override
  State<HomeForgotPass> createState() => _HomeForgotPassState();
}

class _HomeForgotPassState extends State<HomeForgotPass> {
  GlobalKey<FormState> changePassKey = GlobalKey<FormState>();
  bool _newpasswordVisible = true;
  bool _confirmpasswordVisible = true;
  bool isloading = false;
  bool errorcurrentpass = true,
      errornewpassword = true,
      errorconfirmpassword = true;

  SecureStorageService _secureStorageService = SecureStorageService();
  dynamic isLoggedIn;

  final newPassController = TextEditingController();
  final rePassController = TextEditingController();

  // userAppLoginStatus() async {
  //   isLoggedIn =
  //       await _secureStorageService.getUserData(key: StorageKeys.loginKey);
  //   if (isLoggedIn != null) {

  //   } else {
  //     GoRouter.of(context).goNamed(routerConst.loginScreen);
  //   }
  // }

  Future<void> resetUserPassword() async {
    String? userId =
        await _secureStorageService.getUserID(key: StorageKeys.userIDKey);
    log(userId.toString());
    log('Your UserID--> ${userId.toString()}');
    if (userId == null || userId.isEmpty) {
      toastMsg('User ID not found', true);
      return;
    }

    try {
      var headers = {
        'Cookie': 'ci_session=ahecngevpdiev2q1grrvt2lvgd7nvhrb',
        'Content-Type': 'application/json',
      };

      var request = http.MultipartRequest('POST', Uri.parse(cp_url));
      request.fields.addAll({
        'user_id': userId.toString(),
        'password': newPassController.text,
        're_password': rePassController.text
      });
      request.headers.addAll(headers);

      http.StreamedResponse streamResponse = await request.send();
      http.Response cpResponse = await http.Response.fromStream(streamResponse);

      // * Decode the response from the server
      var cpDecodedResponse = jsonDecode(cpResponse.body);

      // * Status code for success
      var resetPassSuccessCode = cpDecodedResponse['status'];
      log("cp--> ${cpDecodedResponse.toString()}");

      if (cpResponse.statusCode == 200) {
        if (resetPassSuccessCode == 1) {
          log('Reset Password Success: ${cpDecodedResponse.toString()}');
          toastMsg(cpDecodedResponse['message'].toString(), false);
          GoRouter.of(context).goNamed(routerConst.navBar);
        } else {
          toastMsg(cpDecodedResponse['message'].toString(), true);
        }
      } else if (cpResponse.statusCode == 401) {
        toastMsg('Unauthorized access', false);
      } else {
        toastMsg('Something went wrong', true);
      }
    } on TimeoutException catch (e) {
      toastMsg('Request timeout, please try again', true);
      log('TimeoutException: $e');
    } on SocketException catch (e) {
      toastMsg('No internet connection, please try again', true);
      log('SocketException: $e');
    } catch (e) {
      toastMsg('An error occurred, please try again', true);
      log('Exception: $e');
    }
  }

  @override
  void dispose() {
    newPassController.dispose();
    rePassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: isloading
            ? const Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator.adaptive(),
              )
            : Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 60,
                    child: Container(
                      height: 120,
                      width: 100,
                      color: blueColor,
                    ),
                  ),
                  Container(
                    height: 100,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        borderRadius:
                            BorderRadius.only(bottomRight: Radius.circular(70)),
                        color: blueColor),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 100),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 20),
                      alignment: Alignment.center,
                      height: double.infinity,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        borderRadius:
                            BorderRadius.only(topLeft: Radius.circular(70)),
                        color: Colors.white,
                      ),
                      child: SingleChildScrollView(
                        child: Form(
                          key: changePassKey,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  txtHelper().heading1Text(
                                      'Forgot Password', 22, blueColor),
                                ],
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                padding: const EdgeInsets.only(top: 5),
                                height: 56,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: tfColor),
                                child: TextFormField(
                                  controller: newPassController,
                                  // validator:
                                  //     form_validation.validatenewpassword,
                                  obscureText: _newpasswordVisible,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "New Password",
                                      prefixIcon: const Icon(Icons.password),
                                      suffixIcon: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              _newpasswordVisible =
                                                  !_newpasswordVisible;
                                            });
                                          },
                                          icon: Icon(
                                            _newpasswordVisible
                                                ? Icons.visibility_off
                                                : Icons.visibility,
                                          ))),
                                  onChanged: (text) {
                                    setState(() {
                                      if (text.isEmpty) {
                                        errornewpassword = true;
                                      }
                                    });
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                padding: const EdgeInsets.only(top: 5),
                                height: 56,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: tfColor),
                                child: TextFormField(
                                  controller: rePassController,
                                  obscureText: _confirmpasswordVisible,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Confirm Password",
                                      prefixIcon: const Icon(Icons.password),
                                      suffixIcon: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              _confirmpasswordVisible =
                                                  !_confirmpasswordVisible;
                                            });
                                          },
                                          icon: Icon(
                                            _confirmpasswordVisible
                                                ? Icons.visibility_off
                                                : Icons.visibility,
                                          ))),
                                  onChanged: (text) {
                                    setState(() {
                                      if (text.isNotEmpty) {
                                        errornewpassword = true;
                                      }
                                    });
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (changePassKey.currentState!.validate()) {
                                    resetUserPassword();
                                  }
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  height: 50,
                                  width: 160,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: blueColor),
                                  child: const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Confirm',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17,
                                            color: Colors.white),
                                      ),
                                      Icon(
                                        Icons.arrow_forward,
                                        color: Colors.white,
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          color: blueColor,
                        ),
                        onPressed: () {
                          GoRouter.of(context).goNamed(routerConst.homeNavBar);
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: 140,
                    child: txtHelper().heading1Text('Tima', 27, Colors.white),
                  )
                ],
              ),
      ),
    );
  }
}
