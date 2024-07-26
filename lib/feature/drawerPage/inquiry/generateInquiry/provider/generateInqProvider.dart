import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tima_app/ApiService/postApiBaseHelper.dart';
import 'package:tima_app/DataBase/dataHub/secureStorageService.dart';
import 'package:tima_app/DataBase/keys/keys.dart';
import 'package:tima_app/core/constants/apiUrlConst.dart';
import 'package:tima_app/core/models/generatedinquirymodel.dart';

class EnquiryProvider extends ChangeNotifier {
  bool generateenquiryload = false;
  List<EnquiryData> enquiryList = [];
  final SecureStorageService secureStorageService = SecureStorageService();

  Future<void> getGenerateEnquiryApi(String url, dynamic body) async {
    generateenquiryload = true;
    notifyListeners();
    String? userid =
        await secureStorageService.getUserID(key: StorageKeys.userIDKey);
    String? branchID =
        await secureStorageService.getUserBranchID(key: StorageKeys.branchKey);
    // var body = jsonEncode();
    var url = show_enquiry_report_app_url;

    try {
      var result = await ApiBaseHelper().postAPICall(Uri.parse(url), body);

      if (result.statusCode == 200) {
        var responseData = jsonDecode(result.body);
        print("client getGenerateEnquiryApi body: $body");
        print("client getGenerateEnquiryApi response: ${result.body}");

        GenerateEnquiryModel generatedInqModel =
            GenerateEnquiryModel.fromJson(responseData);
        Fluttertoast.showToast(msg: generatedInqModel.message);
        generateenquiryload = false;

        enquiryList = generatedInqModel.data; // Store the list of EnquiryData
        notifyListeners();
      } else {
        _handleError(result.statusCode, result.body);
      }
    } catch (e) {
      print("Error in getGenerateEnquiryApi: $e");
      Fluttertoast.showToast(msg: "An error occurred. Please try again.");
    } finally {
      notifyListeners();
    }
  }

  void _handleError(int statusCode, String responseBody) {
    print("Error: $statusCode, $responseBody");
    Fluttertoast.showToast(msg: "Error: $statusCode");
  }
}
