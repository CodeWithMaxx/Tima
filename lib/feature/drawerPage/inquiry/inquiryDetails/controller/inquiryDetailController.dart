import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tima_app/ApiService/postApiBaseHelper.dart';
import 'package:tima_app/DataBase/dataHub/secureStorageService.dart';
import 'package:tima_app/DataBase/keys/keys.dart';
import 'package:tima_app/core/constants/apiUrlConst.dart';
import 'package:tima_app/core/models/enquirydetailmodel.dart';
import 'package:tima_app/feature/drawerPage/inquiry/inquiryDetails/screen/inquiryDetail.dart';
import 'package:tima_app/providers/inquireyProvider/inquiry_provider.dart';

abstract class InquiryDetailController extends State<InquiryDeatil> {
  InquiryProvider inquiryProvider = InquiryProvider();
  final SecureStorageService secureStorageService = SecureStorageService();
  List enquirydetailList = [];
  bool enquirydetailload = false;
  List<Datum> getEnqList = [];
  var carres;
  List cardatalist = [];
  int selectedIndex = 2;
  List imageSliders = ['assets/banner.jpg', 'assets/banner1.jpg'];
  // List<EnquiryData> inquiryDetaiViewlList = [];
  // var enquiryVisitDetailLoad = false;

  Future<void> getEnqueryDetailsApi() async {
    enquirydetailload = true;
    setState(() {});
    String? userID =
        await secureStorageService.getUserID(key: StorageKeys.userIDKey);
    var url = show_enquiry_report_app_url;

    var body = jsonEncode({
      'user_id': userID.toString(),
      'from_date': widget.inquiryDetailParams.fromdate,
      'to_date': widget.inquiryDetailParams.todate,
      'branch_id': widget.inquiryDetailParams.branchid,
      "inq_type": widget.inquiryDetailParams.type
    });
    var result = await ApiBaseHelper().postAPICall(Uri.parse(url), body);

    if (result.statusCode == 200) {
      var responsedata = jsonDecode(result.body);
      log("client getenquiry_detail body =>$body");
      log("client getenquiry_detail response =>${result.body}");
      GetEnquiryDetailModel getEnquiryDetailModel =
          GetEnquiryDetailModel.fromJson(responsedata);

      getEnqList = getEnquiryDetailModel.data;
      setState(() {});

      // Fluttertoast.showToast(msg: responsedata['message']);
    }

    enquirydetailload = false;
    setState(() {});
  }

  // Future<void> getInquiryDataFromApi() async {
  //   String? userID =
  //       await _secureStorageService.getUserID(key: StorageKeys.userIDKey);

  //   var body = ({
  //     'user_id': userID.toString(),
  //     'from_date': widget.inquiryDetailParams.fromdate,
  //     'to_date': widget.inquiryDetailParams.todate,
  //     'branch_id': widget.inquiryDetailParams.branchid,
  //     "inq_type": widget.inquiryDetailParams.type,
  //     'inq_id': widget.inquiryDetailParams.typeid
  //   });
  //   var url = show_enquiry_report_app_url;
  //   inquiryProvider.getEnquiryDetailapi(url, body);
  // }
}
