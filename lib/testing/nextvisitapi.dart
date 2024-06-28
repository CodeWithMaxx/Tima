import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:tima_app/DataBase/dataHub/secureStorageService.dart';
import 'package:tima_app/DataBase/keys/keys.dart';
import 'package:tima_app/core/constants/apiUrlConst.dart';
import 'package:tima_app/core/models/nextvisitmodel.dart';

class NextVisitApiTesting extends StatefulWidget {
  const NextVisitApiTesting({super.key});

  @override
  State<NextVisitApiTesting> createState() => _NextVisitApiTestingState();
}

class _NextVisitApiTestingState extends State<NextVisitApiTesting> {
  SecureStorageService _secureStorageService = SecureStorageService();
  late String startDateController;
  late String endDateController;
  DateTime selectedDate = DateTime.now();
  DateTime selectedEndDate = DateTime.now();

  @override
  void initState() {
    startDateController = DateFormat('yyyy-MM-dd').format(selectedDate);
    endDateController = DateFormat('yyyy-MM-dd').format(selectedEndDate);

    super.initState();
  }

  Future<void> selectStartDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
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
        startDateController = DateFormat('yyyy-MM-dd').format(selectedDate);
        if (endDateController != "") {}
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
        endDateController = DateFormat('yyyy-MM-dd').format(selectedEndDate);
      });
    }
  }

  Future<NextVisitModel> nextVisit() async {
    final client = http.Client();
    String? userid =
        await _secureStorageService.getUserID(key: StorageKeys.userIDKey);
    var url = Uri.parse(show_next_visit_app_url);
    var response = await client.post(url, body: {
      'user_id': userid.toString(),
      'from_date': startDateController.toString(),
      'to_date': endDateController.toString()
    });
    var decodedResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      NextVisitModel.fromJson(decodedResponse);
    }
    return NextVisitModel.fromJson(decodedResponse);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: nextVisit(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                  child: ListView.builder(itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text(snapshot.requireData.data?[index].client)],
                );
              }));
            }
            return Text(snapshot.data!.message);
          }),
    );
  }
}
