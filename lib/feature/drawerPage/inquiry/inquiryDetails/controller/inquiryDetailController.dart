import 'package:flutter/material.dart';
import 'package:tima_app/DataBase/dataHub/secureStorageService.dart';
import 'package:tima_app/DataBase/keys/keys.dart';
import 'package:tima_app/core/constants/apiUrlConst.dart';
import 'package:tima_app/feature/drawerPage/inquiry/inquiryDetails/screen/inquiryDetail.dart';
import 'package:tima_app/providers/inquireyProvider/inquiry_provider.dart';

abstract class InquiryDetailController extends State<InquiryDeatil> {
  InquiryProvider inquiryProvider = InquiryProvider();
  SecureStorageService secureStorageService = SecureStorageService();
  var carres;
  List cardatalist = [];
  int selectedIndex = 2;
  List imageSliders = ['assets/banner.jpg', 'assets/banner1.jpg'];

  Future<void> getInquiryDataFromApi() async {
    String? userID =
        await secureStorageService.getUserID(key: StorageKeys.userIDKey);
    var body = ({
      'user_id': userID.toString(),
      'from_date': widget.inquiryDetailParams.fromdate,
      'to_date': widget.inquiryDetailParams.todate,
      'branch_id': widget.inquiryDetailParams.branchid,
      "inq_type": widget.inquiryDetailParams.type,
      'inq_id': widget.inquiryDetailParams.typeid
    });
    var url = show_enquiry_report_app_url;
    inquiryProvider.getEnquiryDetailapi(url, body);
  }
}
