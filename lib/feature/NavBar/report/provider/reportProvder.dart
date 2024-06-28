import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tima_app/ApiService/postApiBaseHelper.dart';
import 'package:tima_app/core/models/attendancemodel.dart';
import 'package:tima_app/core/models/enquiryviewdetailmodel.dart';
import 'package:tima_app/core/models/nextvisitmodel.dart';

class ReportProvider extends ChangeNotifier {
  NextVisitModel nextVisit = NextVisitModel();
  GetEnquiryViewDetailModel enquiryVisitDetail = GetEnquiryViewDetailModel();
  AttendanceModel attendanceData = AttendanceModel();
  var nextVisitLoad = false;
  var enquiryVisitDetailLoad = false;
  var attendanceDataLoad = false;
  List enquiryType = [];
  var startDateController = "";
  var endDateController = "";

  void getNextVisitApi(String url, dynamic body) async {
    nextVisitLoad = true;
    notifyListeners();

    var response = await ApiBaseHelper().postAPICall(Uri.parse(url), body);

    if (response.statusCode == 200) {
      Map<String, dynamic> decodedResponse = jsonDecode(response.body);
      notifyListeners();
      log("client NextVisitModel body -->body");
      log("client NextVisitModel response -->${response.body}");
      nextVisit = NextVisitModel.fromJson(decodedResponse);
      nextVisitLoad = false;
      notifyListeners();
      // Fluttertoast.showToast(msg: responseData['message']);
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
      enquiryVisitDetail = GetEnquiryViewDetailModel.fromJson(responseData);
      log("client getenquiryView_detail response -->${enquiryVisitDetail.data!.length} ");
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
      attendanceData = AttendanceModel.fromJson(responseData);
      attendanceDataLoad = false;
      notifyListeners();
    }
    attendanceDataLoad = false;
    notifyListeners();
  }
}
