import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tima_app/ApiService/postApiBaseHelper.dart';
import 'package:tima_app/DataBase/dataHub/secureStorageService.dart';
import 'package:tima_app/DataBase/keys/keys.dart';
import 'package:tima_app/core/constants/apiUrlConst.dart';
import 'package:tima_app/core/models/attendancemodel.dart';
import 'package:tima_app/core/models/enquiryviewdetailmodel.dart';
import 'package:tima_app/core/models/nextvisitmodel.dart';
import 'package:tima_app/feature/NavBar/report/models/nextvisitperams.dart';

class ReportProvider extends ChangeNotifier {
  final client = http.Client();
  GetEnquiryViewDetailModel enquiryVisitDetail = GetEnquiryViewDetailModel();
  final SecureStorageService _secureStorageService = SecureStorageService();
  AttendanceModel attendanceData = AttendanceModel();
  var nextVisitLoad = false;
  var enquiryVisitDetailLoad = false;
  var attendanceDataLoad = false;
  List enquiryType = [];
  var startDateController = "";
  var endDateController = "";
  List<NextVisitModel> nextVisitData = [];

  fatchNextVisitData(NextVisitParams nextVisiParams) async {
    nextVisitLoad = true;
    notifyListeners();
    String? userid =
        await _secureStorageService.getUserID(key: StorageKeys.userIDKey);
    var url = Uri.parse(show_next_visit_app_url);

    final Response = await client.post(url, body: {
      'user_id': userid.toString(),
      'from_date': nextVisiParams.startDate,
      'to_date': nextVisiParams.endDate
    });

    log(Response.body);

    var decodedResponse = jsonDecode(Response.body);
    notifyListeners();

    if (Response.statusCode == 200) {
      NextVisitModel nextVisitModel = NextVisitModel.fromJson(decodedResponse);
      nextVisitData.addAll(nextVisitModel as List<NextVisitModel>);
      nextVisitLoad = false;
      notifyListeners();
    }
  }

  // void getNextVisitApi(String url, dynamic body) async {
  //   nextVisitLoad = true;
  //   notifyListeners();

  //   var response = await ApiBaseHelper().postAPICall(Uri.parse(url), body);

  //   if (response.statusCode == 200) {
  //     var decodedResponse = jsonDecode(response.body);
  //     notifyListeners();
  //     log("client NextVisitModel body -->body");
  //     log("client NextVisitModel response -->${response.body}");
  //     NextVisitModel.fromJson(decodedResponse);
  //     nextVisitLoad = false;
  //     notifyListeners();
  //     // Fluttertoast.showToast(msg: responseData['message']);
  //   }
  //   nextVisitLoad = false;
  //   notifyListeners();
  // }

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
