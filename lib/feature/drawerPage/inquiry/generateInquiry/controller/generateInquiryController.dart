import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:tima_app/ApiService/postApiBaseHelper.dart';
import 'package:tima_app/DataBase/dataHub/secureStorageService.dart';
import 'package:tima_app/DataBase/keys/keys.dart';
import 'package:tima_app/core/constants/apiUrlConst.dart';
import 'package:tima_app/core/models/generatedinquirymodel.dart';
import 'package:tima_app/feature/drawerPage/inquiry/generateInquiry/provider/generateInqProvider.dart';
import 'package:tima_app/feature/drawerPage/inquiry/generateInquiry/screen/generateInquiry.dart';
import 'package:tima_app/providers/inquireyProvider/inquiry_provider.dart';
import 'package:tima_app/router/routes/routerConst.dart';

abstract class GenerateInquiryBuilder extends State<Generateinquiry> {
  bool generateenquiryload = false;

  String startDateController = "";
  String endDateController = "";
  String startgeneratedDateController = "";
  String endgeneratedDateController = "";
  List<EnquiryData> enquiryList = [];
  InquiryProvider inquiryProvider = InquiryProvider();
  SecureStorageService secureStorageService = SecureStorageService();
  final EnquiryProvider enquiryProvider = EnquiryProvider();
  DateTime selectedDate = DateTime.now();
  DateTime selectedEndDate = DateTime.now();
  bool pageloder = true;
  var branchesid;
  var branchesname;
  List branches = [];

  Future<void> getGenerateEnquiryApi() async {
    String? userid =
        await secureStorageService.getUserID(key: StorageKeys.userIDKey);
    String? branchID =
        await secureStorageService.getUserBranchID(key: StorageKeys.branchKey);
    // var body = jsonEncode();
    var url = show_enquiry_report_app_url;
    var body = {
      'user_id': userid.toString(),
      'from_date': startgeneratedDateController.toString(),
      'to_date': endgeneratedDateController.toString(),
      "inq_type": "generated",
      "inq_id": '0',
      'branch_id': branchID.toString()
    };
    // pageloder = false;

    generateenquiryload = true;

    try {
      var result = await ApiBaseHelper().postAPICall(Uri.parse(url), body);

      if (result.statusCode == 200) {
        var responseData = jsonDecode(result.body);
        print("client getGenerateEnquiryApi body: $body");
        print("client getGenerateEnquiryApi response: ${result.body}");

        GenerateEnquiryModel generatedInqModel =
            GenerateEnquiryModel.fromJson(responseData);
        Fluttertoast.showToast(msg: responseData['message']);
        generateenquiryload = false;

        enquiryList = generatedInqModel.data; // Store the list of EnquiryData
        setState(() {});
      } else {
        _handleError(result.statusCode, result.body);
      }
    } catch (e) {
      print("Error in getGenerateEnquiryApi: $e");
      Fluttertoast.showToast(msg: "An error occurred. Please try again.");
    }
  }

  void _handleError(int statusCode, String responseBody) {
    print(
        "Error in getGenerateEnquiryApi - Status Code: $statusCode, Response: $responseBody");
    Fluttertoast.showToast(
        msg: "Failed to load data. Status Code: $statusCode");
  }

  getbranchescall() async {
    String? companyid = await secureStorageService.getUserCompanyID(
        key: StorageKeys.companyIdKey);
    var url = getbranchestype_url;
    var body = ({'company_id': companyid, 'branch_id': '0'});

    var result = await ApiBaseHelper().postAPICall(Uri.parse(url), body);
    if (result.statusCode == 200) {
      var responsedata = jsonDecode(result.body);
      branches.clear();
      setState(() {
        var data = [
          {
            "branch_id": "0",
            "branch_name": "All",
            "city_name": "Jodhpur",
            "state_name": "Rajasthan"
          },
        ];
        branches.addAll(data);
        branches.addAll(responsedata['data']);
        print("branches : " + branches.toString());
        addItemDialogBox();
      });
    }
  }

  @override
  void initState() {
    startgeneratedDateController =
        DateFormat('yyyy-MM-dd').format(selectedDate);
    endgeneratedDateController =
        DateFormat('yyyy-MM-dd').format(selectedEndDate);
    getbranchescall();
    getGenerateEnquiryApi();
    super.initState();
  }

  Future<void> selectStartDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      initialDatePickerMode: DatePickerMode.day,
    ) as DateTime;

    if (picked != '') {
      setState(() {
        selectedDate = picked;
        var date = DateFormat.yMd().format(selectedDate);
        startgeneratedDateController =
            DateFormat('yyyy-MM-dd').format(selectedDate);
        if (endgeneratedDateController.isNotEmpty) {
          getGenerateEnquiryApi();
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
        endgeneratedDateController =
            DateFormat('yyyy-MM-dd').format(selectedEndDate);
        getGenerateEnquiryApi();
      });
    }
  }

  addItemDialogBox() async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return WillPopScope(
            onWillPop: () async {
              // Disable back button press
              return Future.value(false);
            },
            child: StatefulBuilder(builder: (context, setState) {
              return Stack(
                children: [
                  AlertDialog(
                    insetPadding: const EdgeInsets.only(left: 10, right: 10),
                    contentPadding: EdgeInsets.zero,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    content: Container(
                      padding:
                          const EdgeInsets.only(top: 10, left: 20, right: 20),
                      child: FormField<String>(
                        builder: (FormFieldState<String> state) {
                          return InputDecorator(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0))),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                hint: const Text("Select Branch"),
                                value: branchesid,
                                isDense: true,
                                onChanged: (newValue) {
                                  setState(() {
                                    branchesid = newValue;
                                  });
                                  log(branchesid);
                                },
                                items: branches.map((value) {
                                  return DropdownMenuItem(
                                    value: value['branch_id'],
                                    child:
                                        Text(value['branch_name'].toString()),
                                    onTap: () {
                                      setState(() {
                                        branchesid = value['branch_id'];
                                        branchesname = value['branch_name'];
                                      });
                                    },
                                  );
                                }).toList(),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    actions: [
                      TextButton(
                        child: const Text('OK'),
                        onPressed: () async {
                          // Perform some action
                          if (branchesid == null) {
                            Fluttertoast.showToast(
                                msg: "Please Select Branch Name");
                          } else {
                            await getGenerateEnquiryApi();

                            Navigator.of(context).pop();
                          }
                          // Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: const Text('Back'),
                        onPressed: () {
                          GoRouter.of(context)
                              .pushNamed(routerConst.homeNavBar);
                        },
                      ),
                    ],
                  ),
                ],
              );
            }),
          );
        });
  }
}
