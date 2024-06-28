// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names, prefer_final_fields

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:tima_app/DataBase/dataHub/secureStorageService.dart';
import 'package:tima_app/DataBase/keys/keys.dart';
import 'package:tima_app/core/GWidgets/toast.dart';
import 'package:tima_app/core/constants/apiUrlConst.dart';
import 'package:tima_app/feature/Auth/register/register.dart';

abstract class RegisterController extends State<RegisterScreen> {
  final SecureStorageService _secureStorageService = SecureStorageService();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileController = TextEditingController();
  final dobController = TextEditingController();
  final pinController = TextEditingController();
  final webController = TextEditingController();
  var locationController = TextEditingController();
  var addressController = TextEditingController();
  var serviceJson;
  bool isEmail = true;
  var currentSelectedValue, city, State, time, timespend, investment;
  List arrayList1 = [];
  List arrayListmobile = [];
  List arrayListmail = [];
  var deviceTypes = ["Male", "Female", "Other"];
  var selectcity = ["Ahmedabad", "Gandhinagar", "Naroda"];
  var selectstate = ["Gujarat", "Tamilnadu", "Goa"];
  var selecttime = [
    "Immediatley",
    "Within 3 months",
    "Within 3-6 months",
    "Within 6-12 months"
  ];
  var selecttimespend = [
    "40 Hours/week",
    "30 - 40 Hours/week",
    "20 - 30 Hours/week"
  ];
  var selectinvet = ["0 - 1 lacs", "1 - 3 lacs", "3 - 5 lacs", "5 - 10 lacs"];
  bool errororgname = true,
      erroremail = true,
      errormobile = true,
      erroelocation = true,
      errordob = true,
      erroaddress = true,
      erroradd = true;
  var designationlistres;
  var stateres;
  List leavetype3 = [];
  List data = [];
  String? yy;
  String? designationid;
  List statelist = [];
  List ststedata = [];
  String? yyy;
  String? stateid;

  List<TextEditingController>? _controllers;
  List proba = [];
  List AllLanguageServices = [];
  List AllLanguageServicesData = [];
  List AllServices = [];
  List AllServicesData = [];
  List States = [];
  List City = [];
  var selcectState;
  var selectedstateId = "";
  var selectCity;
  var selectCityID;
  List<TextEditingController> startController = [];
  List<TextEditingController> endController = [];
  List<TextEditingController> emailcontrollers = [];
  List<TextFormField> fields1 = [];
  List<TextFormField> fields2 = [];
  List<TextFormField> fields3 = [];
  List<TimeOfDay> timefields1 = [];
  List<TimeOfDay> timefields2 = [];
  List<TextField> fields = [];

  Future<void> clientVendorRegistration() async {
    var body = jsonEncode({
      "org_name": nameController.text,
      "address": addressController.text,
      "city": selectCityID,
      "pin": pinController.text,
      "state": selectedstateId,
      "contact_no": "8852911910",
      "mobile": mobileController.text,
      "web": webController.text,
      "email": emailController.text,
      "location": "26.280096,73.017801",
      "products": AllLanguageServices,
      "services": AllServices,
      "contact_person": arrayList1,
      "contact_mobile": arrayListmobile,
      "contact_email": arrayListmail
    });
    log("login--> $body");
    final registerationResponse =
        await http.post(Uri.parse(client_reg_url), body: body);
    var registerationResponseDecoded = jsonDecode(registerationResponse.body);

    log("clientVendorRegistration--> $registerationResponseDecoded");

    if (registerationResponse.statusCode == 200) {
      if (registerationResponseDecoded['status'].toString() == "1") {
        setState(() {
          log("clientVendorRegistrationb--> $registerationResponseDecoded");
          // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>
          //     HomeScreen()), (route) => false);
        });

        Fluttertoast.showToast(
            msg: registerationResponseDecoded['message'].toString());
      } else {
        Fluttertoast.showToast(
            msg: registerationResponseDecoded['message'].toString());
      }
    } else if (registerationResponse.statusCode == 401) {
      return;
    } else {
      Fluttertoast.showToast(
          msg: registerationResponseDecoded['message'].toString());
      return;
    }
  }

  Future<void> getCityFromApi(stateid) async {
    // auth_token = prefs.getString("user_token");
    String? userid =
        await _secureStorageService.getUserID(key: StorageKeys.userIDKey);
    try {
      final city_resonse = await http.post(Uri.parse(city_url), body: {
        "state_id": stateid,
        "user_id": userid,
      }).timeout(const Duration(seconds: 10));

      var cityResponse = jsonDecode(city_resonse.body);

      if (city_resonse.statusCode == 200) {
        if (cityResponse['status'].toString() == "1") {
          City.clear();
          setState(() {
            City.addAll(cityResponse['data']);
          });
        } else {
          toastMsg(cityResponse['message'].toString(), true);
        }
      } else if (city_resonse.statusCode == 401) {
        Fluttertoast.showToast(msg: cityResponse['data'].toString());

        return;
      } else {
        return;
      }
    } on TimeoutException catch (_) {
      // make it explicit that a SocketException will be thrown if the network connection fails
      rethrow;
    } on SocketException catch (_) {
      // make it explicit that a SocketException will be thrown if the network connection fails
      rethrow;
    }
  }

  Future<void> getStateFromApi() async {
    String? userid =
        await _secureStorageService.getUserID(key: StorageKeys.userIDKey);
    try {
      final state_resonse = await http.post(Uri.parse(state_url), body: {
        "user_id": userid,
      }).timeout(const Duration(seconds: 10));
      // toastMsg(header_value.toString(),false);
      // toastMsg(state_resonse.body.toString(),false);
      var stateResponse = jsonDecode(state_resonse.body);

      if (state_resonse.statusCode == 200) {
        if (stateResponse['status'].toString() == "1") {
          setState(() {
            States.addAll(stateResponse['data']);
          });
        }
      } else if (state_resonse.statusCode == 401) {
        // var profilestatus =profileResponse['data']['message'];
        Fluttertoast.showToast(msg: stateResponse['data'].toString());

        return;
      } else {
        return;
      }
    } on TimeoutException catch (_) {
      getStateFromApi();
      // make it explicit that a SocketException will be thrown if the network connection fails
      rethrow;
    } on SocketException catch (_) {
      // make it explicit that a SocketException will be thrown if the network connection fails
      rethrow;
    }
  }

  Future<void> getProdcutServicesFromApi() async {
    String? usercompanyid = await _secureStorageService.getUserCompanyID(
        key: StorageKeys.companyIdKey);
    try {
      log("response---${product_service_url.toString()}");
      var headers = {
        'Cookie': 'ci_session=ahecngevpdiev2q1grrvt2lvgd7nvhrb',
        'Content-Type': 'application/json',
      };
      var request =
          http.MultipartRequest('POST', Uri.parse(product_service_url));
      request.fields.addAll({
        'type': 'product',
        'company_id': '$usercompanyid',
      });
      request.headers.addAll(headers);
      http.StreamedResponse responsed = await request.send();
      var pduct_service_resonse = await http.Response.fromStream(responsed);
      log("hhhresponse---${pduct_service_resonse.body.toString()}");
      // toastMsg(pduct_service_resonse.body.toString(),false);
      var serviceResponse = jsonDecode(pduct_service_resonse.body);

      if (pduct_service_resonse.statusCode == 200) {
        if (serviceResponse['status'].toString() == "1") {
          setState(() {
            AllLanguageServicesData.addAll(serviceResponse['data']);
          });
        }
      } else if (pduct_service_resonse.statusCode == 401) {
        // var profilestatus =profileResponse['data']['message'];
        Fluttertoast.showToast(msg: serviceResponse['data'].toString());

        return;
      } else {
        return;
      }
    } on TimeoutException catch (_) {
      getStateFromApi();
      // make it explicit that a SocketException will be thrown if the network connection fails
      rethrow;
    } on SocketException catch (_) {
      // make it explicit that a SocketException will be thrown if the network connection fails
      rethrow;
    }
  }

  Future<void> getServices() async {
    String? usercompanyid = await _secureStorageService.getUserCompanyID(
        key: StorageKeys.companyIdKey);
    try {
      log("usercompanyid---${usercompanyid.toString()}");
      log("response---${product_service_url.toString()}");
      var headers = {
        'Cookie': 'ci_session=ahecngevpdiev2q1grrvt2lvgd7nvhrb',
        'Content-Type': 'application/json',
      };
      var request =
          http.MultipartRequest('POST', Uri.parse(product_service_url));
      request.fields
          .addAll({'type': 'service', 'company_id': usercompanyid.toString()});
      request.headers.addAll(headers);
      http.StreamedResponse responsed = await request.send();
      var pduct_service_resonse = await http.Response.fromStream(responsed);
      log("hresponse---${pduct_service_resonse.body.toString()}");
      // toastMsg(pduct_service_resonse.body.toString(),false);
      var serviceResponse = jsonDecode(pduct_service_resonse.body);

      if (pduct_service_resonse.statusCode == 200) {
        if (serviceResponse['status'].toString() == "1") {
          setState(() {
            AllServicesData.addAll(serviceResponse['data']);
          });
        }
      } else if (pduct_service_resonse.statusCode == 401) {
        // var profilestatus =profileResponse['data']['message'];
        Fluttertoast.showToast(msg: serviceResponse['data'].toString());

        return;
      } else {
        return;
      }
    } on TimeoutException catch (_) {
      getStateFromApi();
      // make it explicit that a SocketException will be thrown if the network connection fails
      rethrow;
    } on SocketException catch (_) {
      // make it explicit that a SocketException will be thrown if the network connection fails
      rethrow;
    }
  }

  void helper() {
    IconButton(
      icon: const Icon(Icons.add_circle_outline),
      onPressed: () {
        setState(() {
          _controllers!.add(TextEditingController());
        });
        setState(() {
          proba.add(Row(
            children: [
              const Icon(Icons.radio_button_unchecked),
              Expanded(
                child: TextFormField(
                  controller: _controllers![_controllers!.length - 1],
                  decoration: const InputDecoration(hintText: "Add text..."),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  setState(() {
                    _controllers!.removeAt(_controllers!.length - 1);
                    proba.removeAt(proba.length - 1);
                  });
                },
              )
            ],
          ));
        });
      },
    );
  }
}
