import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tima_app/ApiService/postApiBaseHelper.dart';
import 'package:tima_app/DataBase/dataHub/secureStorageService.dart';
import 'package:tima_app/DataBase/keys/keys.dart';
import 'package:tima_app/core/constants/apiUrlConst.dart';
import 'package:tima_app/feature/NavBar/attendence/screen/markAttendenc.dart';

abstract class AttendenceBuilder extends State<Markattendance> {
  SecureStorageService secureStorageService = SecureStorageService();
  var branchesid;
  List branches = [];

  var client_controller = TextEditingController();
  var vendor_controller = TextEditingController();

  @override
  void initState() {
    getbranchescall();
    getClients();
    getplaces();
    getVendors();
    setState(() {});
    super.initState();
  }

  String? selectedClientid;
  String? selectedVendorid;
  String? selectedAttendancePlacesid;

  List ClientList = [];
  List VendorList = [];
  List AttendancePlaces = [];
  getbranchescall() async {
    var dataTime_Date = DateFormat("yyyy-MM-dd").format(DateTime.now());
    var dateTime_Time = DateFormat.Hms().format(DateTime.now());
    log("datetime Date : $dataTime_Date ");
    log("dateTime_Time :$dateTime_Time ");

    // String? companyId =
    //     await secureStorageService().getcompanyId(key: StorageKeys.companyIdKey);
    String? companyId = await secureStorageService.getUserCompanyID(
        key: StorageKeys.companyIdKey);
    var url = getbranchestype_url;
    var body = ({'company_id': companyId, 'branch_id': '0'});

    var result = await ApiBaseHelper().postAPICall(Uri.parse(url), body);
    if (result.statusCode == 200) {
      var responsedata = jsonDecode(result.body);
      setState(() {
        branches.addAll(responsedata['data']);
      });
    }
  }

  getClients() async {
    var url = get_client_data_url;
    String? userId =
        await secureStorageService.getUserID(key: StorageKeys.userIDKey);
    String? companyId = await secureStorageService.getUserCompanyID(
        key: StorageKeys.companyIdKey);
    var body = ({
      'id': '0',
      "company_id": companyId,
      "user_id": userId,
    });
    ClientList.clear();
    var result = await ApiBaseHelper().postAPICall(Uri.parse(url), body);
    if (result.statusCode == 200) {
      var responsedata = jsonDecode(result.body);
      setState(() {
        ClientList.addAll(responsedata['data']);
      });
    }
  }

  getplaces() async {
    var url = get_attendance_places_url;
    var body = jsonEncode({'id': '0'});
    AttendancePlaces.clear();
    var result =
        await ApiBaseHelper().postAPICall(Uri.parse(url), body.toString());
    if (result.statusCode == 200) {
      var responsedata = jsonDecode(result.body);
      responsedata['data'].forEach((k, v) {
        log('$k: $v');
        setState(() {
          AttendancePlaces.addAll([
            {"id": "$k", "name": "$v"},
          ]);
        });
      });
    }
  }

  Future<void> getVendors() async {
    String? userId =
        await secureStorageService.getUserID(key: StorageKeys.userIDKey);
    String? companyId = await secureStorageService.getUserCompanyID(
        key: StorageKeys.companyIdKey);

    var url = get_vendor_data_url;
    var body = ({
      'id': '0',
      "company_id": companyId,
      "user_id": userId,
    });
    VendorList.clear();
    var result = await ApiBaseHelper().postAPICall(Uri.parse(url), body);
    if (result.statusCode == 200) {
      var responsedata = jsonDecode(result.body);
      setState(() {
        VendorList.addAll(responsedata['data']);
        log("VendorList : $VendorList");
      });
    }
  }
}
