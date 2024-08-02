import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tima_app/ApiService/postApiBaseHelper.dart';
import 'package:tima_app/DataBase/dataHub/secureStorageService.dart';
import 'package:tima_app/DataBase/keys/keys.dart';
import 'package:tima_app/core/constants/apiUrlConst.dart';
import 'package:tima_app/router/routes/routerConst.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with WidgetsBindingObserver {
  final SecureStorageService _secureStorageService = SecureStorageService();
  dynamic isLoggedIn;
  late var userID;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    injectUserIDs();
    checkLoginStatus();
    // userAppLoginStatus();
  }

  Future<void> sendUserAppStatusToServer(var appStatus) async {
    String? userId =
        await _secureStorageService.getUserData(key: StorageKeys.userIDKey);
    setState(() {
      userID = userId;
    });

    final url = Uri.parse(set_user_app_status_url);
    var body = jsonEncode({
      "user_id": userID,
      "app_status": appStatus,
    });

    await ApiBaseHelper().postAPICall(url, body);
  }

  Future<void> didChangeAppLifeCycleState(AppLifecycleState state) async {
    var appStatus = "";
    if (state == AppLifecycleState.detached) {
      appStatus = 'logout';
      log("Detached Home your app here Dashboard");
      sendUserAppStatusToServer(appStatus);
    }
    if (state == AppLifecycleState.resumed) {
      appStatus = 'active';
      log("Resume Home your app here Dashboard");
      sendUserAppStatusToServer(appStatus);
    }
  }

  void openUserGmail() {
    const intent = AndroidIntent(
      action: 'android.intent.action.SEND',
      arguments: {'android.intent.extra.SUBJECT': 'I am the subject'},
      arrayArguments: {
        'android.intent.extra.EMAIL': ['eidac@me.com', 'overbom@mac.com'],
        'android.intent.extra.CC': ['john@app.com', 'user@app.com'],
        'android.intent.extra.BCC': ['liam@me.abc', 'abel@me.com'],
      },
      package: 'com.google.android.gm',
      type: 'message/rfc822',
    );
    intent.launch();
  }

  Future<void> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool(StorageKeys.loginKey) ?? false;

    Timer(const Duration(seconds: 3), () {
      if (isLoggedIn) {
        GoRouter.of(context).goNamed(routerConst.homeNavBar);
      } else {
        GoRouter.of(context).goNamed(routerConst.loginScreen);
      }
    });
  }

  // userAppLoginStatus() async {
  //   isLoggedIn =
  //       await _secureStorageService.getUserData(key: StorageKeys.loginKey);
  //   if (isLoggedIn != null) {
  //     setState(() {
  //       isLoggedIn = true;
  //     });
  //   } else {
  //     setState(() {
  //       isLoggedIn = false;
  //     });
  //   }

  //   Timer(
  //       const Duration(seconds: 2),
  //       () => isLoggedIn
  //           ? GoRouter.of(context).goNamed(routerConst.homeNavBar)
  //           : GoRouter.of(context).goNamed(routerConst.loginScreen));
  // }

  injectUserIDs() async {
    setState(() {
      _secureStorageService.getUserID(key: StorageKeys.userIDKey);
      _secureStorageService.getUserName(key: StorageKeys.NameKey);
      _secureStorageService.getUserMobile(key: StorageKeys.mobileKey);
      _secureStorageService.getUserEmailID(key: StorageKeys.emailKey);
      _secureStorageService.getUserBranchID(key: StorageKeys.branchKey);
      _secureStorageService.getUserCompanyID(key: StorageKeys.companyIdKey);
      _secureStorageService.getUserCategory(key: StorageKeys.userCategory);
      _secureStorageService.getCategoryName(key: StorageKeys.categoryNameKey);
      _secureStorageService.getUserLogInToken(key: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/timalogo.jpeg',
              height: 250,
              width: double.infinity,
            ),
          ],
        ),
      ),
    );
  }
}
