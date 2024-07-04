import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tima_app/ApiService/postApiBaseHelper.dart';
import 'package:tima_app/core/models/enquirydetailmodel.dart';
import 'package:tima_app/core/models/enquirydetailviewmodel.dart';
import 'package:tima_app/core/models/enquiryviewdetailmodel.dart';
import 'package:tima_app/core/models/generatedinquirymodel.dart';

class InquiryProvider with ChangeNotifier {
  GetEnquiryDetailModel enquirydetail = GetEnquiryDetailModel();
  var enquiryvisitetail = GetEnquiryViewDetailModel();
  GeneratedInquiryModel generatedInquiryModel = GeneratedInquiryModel();
  var inquirydetail = GetEnquiryDetailViewModel();
  bool enquiryvisitdetailload = false;
  bool rejectenquiryload = false;
  bool enquirydetailload = false;
  bool generateenquiryload = false;
  bool getenquirydetailload = false;
  List enquirytype = [];
  String startDateController = "";
  String endDateController = "";
  String startgeneratedDateController = "";
  String endgeneratedDateController = "";

  Future<void> getenquiryapi(String url, dynamic body) async {
    enquirydetailload = true;
    notifyListeners();

    var result = await ApiBaseHelper().postAPICall(Uri.parse(url), body);

    if (result.statusCode == 200) {
      var responsedata = jsonDecode(result.body);
      log("client getenquiry_detail body " + body.toString());
      log("client getenquiry_detail response " + result.body.toString());
      var data = GetEnquiryDetailModel.fromJson(responsedata);
      enquirydetail = data;
      // log("client getenquiry_detail response " +
      //     enquirydetail.data!.length.toString());
      Fluttertoast.showToast(msg: responsedata['message']);
    }

    enquirydetailload = false;
    notifyListeners();
  }

  Future<void> rejectenquiryapi(String url, dynamic body) async {
    rejectenquiryload = true;
    notifyListeners();

    var result = await ApiBaseHelper().postAPICall(Uri.parse(url), body);

    if (result.statusCode == 200) {
      var responsedata = jsonDecode(result.body);
      log("client getenquiry_detail body: $body");
      log("client getenquiry_detail response: ${result.body} ");
      Fluttertoast.showToast(msg: responsedata['message']);
    }

    rejectenquiryload = false;
    notifyListeners();
  }

  Future<void> getVisitDetailapi(String url, dynamic body) async {
    enquiryvisitdetailload = true;
    notifyListeners();

    var result = await ApiBaseHelper().postAPICall(Uri.parse(url), body);

    if (result.statusCode == 200) {
      var responsedata = jsonDecode(result.body);
      log("client getenquiry_detail body :$body ");
      log("client getenquiry_detail response: $result.body");
      var data = GetEnquiryViewDetailModel.fromJson(responsedata);
      enquiryvisitetail = data;
      log("client getenquiryView_detail response: ${enquiryvisitetail.data!.length} ");
      Fluttertoast.showToast(msg: responsedata['message']);
    }

    enquiryvisitdetailload = false;
    notifyListeners();
  }

  Future<void> getEnquiryDetailapi(String url, dynamic body) async {
    getenquirydetailload = true;
    notifyListeners();

    var result = await ApiBaseHelper().postAPICall(Uri.parse(url), body);

    if (result.statusCode == 200) {
      var responsedata = jsonDecode(result.body);
      var data = GetEnquiryDetailViewModel.fromJson(responsedata);
      inquirydetail = data;
    }

    getenquirydetailload = false;
    notifyListeners();
  }

  Future<void> getgenerateEnquiryapi(String url, dynamic body) async {
    generateenquiryload = true;
    notifyListeners();

    var result = await ApiBaseHelper().postAPICall(Uri.parse(url), body);

    if (result.statusCode == 200) {
      var responsedata = jsonDecode(result.body);
      log("client getgenerateEnquiryapi body: $body ");
      log("client getgenerateEnquiryapi response: ${result.body}");
      var data = GeneratedInquiryModel.fromJson(responsedata);
      generatedInquiryModel = data;
      // log("client getgenerateEnquiryapi response length " +
      //     generatedInquiryModel.data!.length.toString());
      Fluttertoast.showToast(msg: responsedata['message']);
    }

    generateenquiryload = false;
    notifyListeners();
  }
}
