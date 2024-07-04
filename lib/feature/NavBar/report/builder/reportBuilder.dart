// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:tima_app/DataBase/dataHub/secureStorageService.dart';
import 'package:tima_app/DataBase/keys/keys.dart';
import 'package:tima_app/core/constants/apiUrlConst.dart';
import 'package:tima_app/core/models/nextvisitmodel.dart';
import 'package:tima_app/feature/NavBar/report/models/nextvisitperams.dart';
import 'package:tima_app/feature/NavBar/report/provider/reportProvder.dart';
import 'package:tima_app/feature/NavBar/report/screen/reportList.dart';

abstract class ReportScreenBuilder extends State<Reportlist> {
  final SecureStorageService _secureStorageService = SecureStorageService();

  final client = http.Client();
  NextVisitModel nextVisitModel = NextVisitModel();
  dynamic startDateController;
  dynamic endDateController;

  final ReportProvider controller = ReportProvider();

  DateTime selectedDate = DateTime.now();
  DateTime selectedEndDate = DateTime.now();
  var nextVisitMessage;
  @override
  void initState() {
    // TODO: implement initState
    startDateController = DateFormat('yyyy-MM-dd').format(selectedDate);
    endDateController = DateFormat('yyyy-MM-dd').format(selectedEndDate);
    ();
    getvisitdataapi();
    getattendanceapi();
    super.initState();
  }

  Future<void> selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      initialDatePickerMode: DatePickerMode.day,
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
        var date = DateFormat.yMd().format(selectedDate);
        controller.startDateController =
            DateFormat('yyyy-MM-dd').format(selectedDate);
        if (controller.endDateController != "") {
          getnextvisitapi();
          getvisitdataapi();
          getattendanceapi();
        }
      });
    }
  }

  Future<void> selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      initialDatePickerMode: DatePickerMode.day,
    );
    if (picked != null) {
      setState(() {
        selectedEndDate = picked;
        controller.endDateController =
            DateFormat('yyyy-MM-dd').format(selectedEndDate);
        getnextvisitapi();
        getvisitdataapi();
        getattendanceapi();
      });
    }
  }

  Future<void> getnextvisitapi() async {
    controller.fatchNextVisitData(NextVisitParams(
        startDate: startDateController, endDate: endDateController));
  }

  Future<void> getvisitdataapi() async {
    var userid =
        await _secureStorageService.getUserID(key: StorageKeys.userIDKey);
    var body = ({
      'user_id': userid.toString(),
      'id': "0",
      'from_date': controller.startDateController,
      'to_date': controller.endDateController
    });

    var url = get_visit_data_url;
    controller.getEnquiryDetailApi(url, body);
  }

  Future<void> getattendanceapi() async {
    var userid =
        await _secureStorageService.getUserID(key: StorageKeys.userIDKey);
    var body = ({
      'user_id': userid.toString(),
      'from_date': controller.startDateController,
      'to_date': controller.endDateController
    });

    var url = show_attendance_app_url;
    controller.getAttendance(url, body);
  }
}
