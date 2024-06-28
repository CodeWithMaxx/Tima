// ignore_for_file: prefer_typing_uninitialized_variables

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
import 'package:tima_app/feature/drawerPage/inquiry/generateInquiry/screen/generateInquiry.dart';
import 'package:tima_app/providers/inquireyProvider/inquiry_provider.dart';
import 'package:tima_app/router/routes/routerConst.dart';

abstract class GenerateInquiryController extends State<GenerateInquiryScreen> {
  InquiryProvider inquiryProvider = InquiryProvider();
  SecureStorageService secureStorageService = SecureStorageService();

  DateTime selectedDate = DateTime.now();
  DateTime selectedEndDate = DateTime.now();
  bool pageloder = true;
  var branchesid;
  var branchesname;
  List branches = [];
  getBranchesCallFromApi() async {
    String? companyId = await secureStorageService.getUserCompanyID(
        key: StorageKeys.companyIdKey);
    var url = getbranchestype_url;
    var body = ({'company_id': companyId, 'branch_id': '0'});

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
        log("branches : $branches");
        addItemDialogBox();
      });
    }
  }

  @override
  void initState() {
    inquiryProvider.startgeneratedDateController =
        DateFormat('yyyy-MM-dd').format(selectedDate).toString();
    inquiryProvider.endgeneratedDateController =
        DateFormat('yyyy-MM-dd').format(selectedEndDate).toString();

    getBranchesCallFromApi();
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
        // var date = DateFormat.yMd().format(selectedDate);
        inquiryProvider.startgeneratedDateController =
            DateFormat('yyyy-MM-dd').format(selectedDate);
        if (inquiryProvider.endgeneratedDateController != "") {
          getenquirydataapi();
        }
      });
    }
  }

  Future<void> selectEndDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      initialDatePickerMode: DatePickerMode.day,
    );
    if (picked != null) {
      setState(() {
        selectedEndDate = picked;
        inquiryProvider.endgeneratedDateController =
            DateFormat('yyyy-MM-dd').format(selectedEndDate);
        getenquirydataapi();
      });
    }
  }

  Future<void> getenquirydataapi() async {
    String? userID =
        await secureStorageService.getUserID(key: StorageKeys.userIDKey);
    var body = ({
      'user_id': userID,
      'from_date': inquiryProvider.startgeneratedDateController.toString(),
      'to_date': inquiryProvider.endgeneratedDateController.toString(),
      "inq_type": "generated",
      "inq_id": widget.indexListNo.toString(),
      'branch_id': branchesid
    });
    var url = show_enquiry_report_app_url;
    inquiryProvider.getgenerateEnquiryapi(url, body);
    pageloder = false;
    setState(() {});
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
                    insetPadding: EdgeInsets.only(left: 10, right: 10),
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
                                hint: Text("Select Branch"),
                                value: branchesid,
                                isDense: true,
                                onChanged: (newValue) {
                                  setState(() {
                                    branchesid = newValue;
                                  });
                                  print(branchesid);
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
                        child: Text('OK'),
                        onPressed: () async {
                          // Perform some action
                          if (branchesid == null) {
                            Fluttertoast.showToast(
                                msg: "Please Select Branch Name");
                          } else {
                            await getenquirydataapi();

                            Navigator.of(context).pop();
                          }
                          // Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: Text('Back'),
                        onPressed: () {
                          GoRouter.of(context).goNamed(routerConst.homeNavBar);
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
