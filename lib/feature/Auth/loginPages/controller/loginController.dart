import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:tima_app/DataBase/dataHub/secureStorageService.dart';
import 'package:tima_app/DataBase/keys/keys.dart';
import 'package:tima_app/DataBase/model/dbmodel.dart';
import 'package:tima_app/core/GWidgets/toast.dart';
import 'package:tima_app/core/constants/apiUrlConst.dart';
import 'package:tima_app/feature/Auth/loginPages/screen/loginPage.dart';
import 'package:tima_app/router/routes/routerConst.dart';

abstract class LoginController extends State<PhoneEmailLogin> {
  final SecureStorageService _secureStorageService = SecureStorageService();
  DBModel? dbModel;
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  GlobalKey<FormState> changePassKey = GlobalKey<FormState>();
  bool newpasswordVisible = true;
  bool rePasswordVisible = true;
  bool isloading = false;
  bool errorcurrentpass = true,
      errornewpassword = true,
      errorconfirmpassword = true;

  // ! Login Mathod
  Future<void> appLogInAuthentication() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    final client = http.Client();

    // *send response to api
    try {
      final loginResponse = await client.post(
        Uri.parse(login_url.toString()),
        body: <String, dynamic>{
          'mobile': mobileController.text,
          'email': emailController.text,
          'password': passController.text,
          'device_id': androidInfo.id.toString()
        },
      ).timeout(const Duration(seconds: 10));

      final Map<String, dynamic> loginResponseDecoded =
          jsonDecode(loginResponse.body);
      var mobileSuccessCode = loginResponseDecoded['status'];
      log("login--> ${loginResponseDecoded.toString()}");

      if (loginResponse.statusCode == 200) {
        if (mobileSuccessCode == 1) {
          setState(() {
            log('Login--> ${loginResponseDecoded['data']['user_id']}');

            _secureStorageService.saveUserName(
                key: StorageKeys.NameKey,
                value: loginResponseDecoded['data']['name']);

            // *save user_id on local database
            _secureStorageService.saveUserId(
                key: StorageKeys.userIDKey,
                value: loginResponseDecoded['data']['user_id']);

            // * testing

            log(loginResponseDecoded['data']['user_id']);

            // *save user_email on local database

            _secureStorageService.saveUserEmail(
                key: StorageKeys.emailKey,
                value: loginResponseDecoded['data']['email']);

            // *save user_mobile on local database
            _secureStorageService.saveUserMobile(
                key: StorageKeys.mobileKey,
                value: loginResponseDecoded['data']['mobile']);

            // *save user_category on local database

            _secureStorageService.saveCategory(
                key: StorageKeys.userCategory,
                value: loginResponseDecoded['data']['category']);

            // *save user_category_name on local database

            _secureStorageService.saveCategoryName(
                key: StorageKeys.categoryNameKey,
                value: loginResponseDecoded['data']['category_name']);

            // *save user_company on local database

            _secureStorageService.saveUserComanyId(
                key: StorageKeys.companyIdKey,
                value: loginResponseDecoded['data']['company']);

            // *save user_branch on local database

            _secureStorageService.saveUserBranchId(
                key: StorageKeys.branchKey,
                value: loginResponseDecoded['data']['branch']);

            // *save user_loginInfo on local database
            _secureStorageService.saveUserLoginToken(
                key: StorageKeys.loginKey, value: true);

            /* store api response data in secure_storage local database and 
            access with the keyname like 'userid' or other */
            // *if login success when navigate on navigationbar which is provide homescreen
            GoRouter.of(context).goNamed(routerConst.homeNavBar);

            log("login--> ${loginResponseDecoded.toString()}");
          });

          toastMsg(loginResponseDecoded['message'].toString(), false);
        } else {
          toastMsg(loginResponseDecoded['message'].toString(), true);
        }
      } else if (loginResponse.statusCode == 401) {
        Fluttertoast.showToast(msg: 'This page is not working');
        GoRouter.of(context).pushNamed(routerConst.error401);
      }
      return;
    } on TimeoutException catch (e) {
      toastMsg('Request timeout, please try again', true);
      log('TimeoutException: $e');
    } on SocketException catch (e) {
      toastMsg('No internet connection, please try again', true);
      log('SocketException: $e');
    } catch (e) {
      toastMsg('An error occurred, please try again', true);
      log('Exception: $e');
    } finally {
      client.close();
    }
  }

  // !dispose controllers value/data

  @override
  void dispose() {
    mobileController.dispose();
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }
}