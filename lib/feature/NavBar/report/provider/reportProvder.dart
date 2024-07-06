import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:tima_app/ApiService/postApiBaseHelper.dart';
import 'package:tima_app/DataBase/dataHub/secureStorageService.dart';
import 'package:tima_app/core/models/nextVisitDataModel.dart';
import 'package:tima_app/core/models/nextvisitmodel.dart';

class ReportProvider extends ChangeNotifier {
  final client = http.Client();
  var startDateController = "";
  var endDateController = "";
  final SecureStorageService secureStorageService = SecureStorageService();
  // GetEnquiryViewDetailModel enquiryVisitDetail = GetEnquiryViewDetailModel();

  // * inquiryvisit

  List inquiryVisitDetailList = [];
  String inquiryVisitMessage = '';
  // * attendence tab

  List<dynamic> attendanceDataList = [];
  var attendanceDataLoad = false;
  String attendanceMessage = '';

  var enquiryVisitDetailLoad = false;
  List enquiryType = [];

  // * next visit
  String nextVisitMessage = '';
  List nextVisitDataList = [];
  var nextVisitLoad = false;
  NextVisitModel nextVisitModel = NextVisitModel();

  List<VisitData> nextVisitDataModelList = [];

  void getNextVisitApi(String url, dynamic body) async {
    nextVisitLoad = true;
    notifyListeners();

    var response = await ApiBaseHelper().postAPICall(Uri.parse(url), body);

    if (response.statusCode == 200) {
      var decodedResponse = jsonDecode(response.body);
      notifyListeners();
      log("client NextVisitModel body -->body");
      log("client NextVisitModel response -->${response.body}");
      // String message = decodedResponse['message'];
      nextVisitMessage =
          decodedResponse['message']?.toString() ?? 'No message available';
      notifyListeners();
      nextVisitDataList.add(decodedResponse['data']);
      notifyListeners();

      nextVisitDataModelList = (decodedResponse['data'] as List)
          .map((i) => VisitData.fromJson(i))
          .toList();

      nextVisitLoad = false;
      notifyListeners();
      Fluttertoast.showToast(msg: decodedResponse['message']);
    }
    nextVisitLoad = false;
    notifyListeners();
  }

  void getEnquiryDetailApi(String url, dynamic body) async {
    log("client getenquiry_detail body --$url");
    log("client getenquiry_detail body -->$body ");
    enquiryVisitDetailLoad = true;
    notifyListeners();

    var response = await ApiBaseHelper().postAPICall(Uri.parse(url), body);
    log("client getenquiry_detail response --> ${response.body}");
    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      // enquiryVisitDetail = GetEnquiryViewDetailModel.fromJson(responseData);
      inquiryVisitDetailList.add(responseData['data']);
      inquiryVisitMessage = responseData['message'];
      notifyListeners();

      log("client getenquiryView_detail response -->${nextVisitDataList.length} ");
      enquiryVisitDetailLoad = false;
      notifyListeners();
      // Fluttertoast.showToast(msg: responseData['message']);
    }
    enquiryVisitDetailLoad = false;
    notifyListeners();
  }

  void getAttendance(String url, dynamic body) async {
    attendanceDataLoad = true;
    notifyListeners();
    log("client attendancedata body $body");
    var response = await ApiBaseHelper().postAPICall(Uri.parse(url), body);
    log("client attendancedata response $response.body");
    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      // attendanceData = AttendanceModel.fromJson(responseData);
      attendanceMessage = responseData['message'];
      attendanceDataList.add(responseData['data']);
      attendanceDataLoad = false;
      notifyListeners();
    }
    attendanceDataLoad = false;
    notifyListeners();
  }
}
