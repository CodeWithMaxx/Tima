// ignore_for_file: unused_field, unused_local_variable

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:tima_app/DataBase/dataHub/secureStorageService.dart';
import 'package:tima_app/DataBase/keys/keys.dart';
import 'package:tima_app/core/GWidgets/toast.dart';
import 'package:tima_app/core/constants/apiUrlConst.dart';
import 'package:tima_app/feature/Auth/forgotPassword/screen/forgotPassword.dart';
import 'package:tima_app/router/routes/routerConst.dart';

abstract class ForgotPasswordController extends State<ForgotPasswordScreen> {
  SecureStorageService _secureStorageService = SecureStorageService();
  dynamic isLoggedIn;

  final newPassController = TextEditingController();
  final rePassController = TextEditingController();

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
}
