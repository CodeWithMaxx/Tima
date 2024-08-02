import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:tima_app/ApiService/postApiBaseHelper.dart';
import 'package:tima_app/DataBase/dataHub/secureStorageService.dart';
import 'package:tima_app/DataBase/keys/keys.dart';
import 'package:tima_app/core/GWidgets/btnText.dart';
import 'package:tima_app/core/GWidgets/textfieldsStyle.dart';
import 'package:tima_app/core/constants/apiUrlConst.dart';
import 'package:tima_app/core/constants/colorConst.dart';
import 'package:tima_app/core/models/enquirydetailmodel.dart';
import 'package:tima_app/feature/drawerPage/inquiry/reciveInquiry/screen/reciveInquiry.dart';
import 'package:tima_app/providers/inquireyProvider/inquiry_provider.dart';
import 'package:tima_app/router/routes/routerConst.dart';

abstract class RecivedInquiryController extends State<ReciveInquiry> {
  SecureStorageService secureStorageService = SecureStorageService();
  final InquiryProvider inquiryProvider = InquiryProvider();
  String startDateController = "";
  String endDateController = "";
  List enquirydetailList = [];
  bool enquirydetailload = false;
  var reject_msg_controller = TextEditingController();
  DateTime selectedDate = DateTime.now();
  DateTime selectedEndDate = DateTime.now();
  List<Datum> getEnqList = [];
  bool pageloder = true;
  @override
  void initState() {
    startDateController = DateFormat('yyyy-MM-dd').format(selectedDate);

    endDateController = DateFormat('yyyy-MM-dd').format(selectedEndDate);

    getBranchesCall();
    getEnqueryApi();

    super.initState();
  }

  var branchesID;
  var branchesName;
  bool rejectenquiryload = false;
  List branches = [];

  Future<void> getBranchesCall() async {
    String? companyID = await secureStorageService.getUserCompanyID(
        key: StorageKeys.companyIdKey);
    var url = getbranchestype_url;
    var body = ({'company_id': companyID, 'branch_id': '0'});

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

  GlobalKey<FormState> creatformkey = GlobalKey<FormState>();

  final rejectMessageController = TextEditingController();
  // DateTime selectedDate = DateTime.now();
  // DateTime selectedEndDate = DateTime.now();
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
        startDateController = DateFormat('yyyy-MM-dd').format(selectedDate);

        if (endDateController != "") {}
        getEnqueryApi();
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
        getEnqueryApi();
      });
    }
  }

  showRejectDialogBoxWidget(inquiryID) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return Stack(
              children: [
                AlertDialog(
                  insetPadding: EdgeInsets.only(left: 10, right: 10),
                  contentPadding: EdgeInsets.zero,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  title: const Text("Want to reject Inquiry?"),
                  content: Container(
                    padding:
                        const EdgeInsets.only(top: 10, left: 20, right: 20),
                    child: FormField<String>(
                      key: creatformkey,
                      builder: (FormFieldState<String> state) {
                        return Padding(
                          padding:
                              const EdgeInsets.only(top: 5, left: 5, right: 5),
                          child: Container(
                            child: TextFormField(
                              // readOnly: true,
                              maxLines: 5,
                              controller: reject_msg_controller,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter reason';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                labelText: "Reason",
                                border: boarder,
                                focusedBorder: focusboarder,
                                errorBorder: errorboarder,
                                labelStyle: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              onChanged: (text) {
                                setState(() {});
                              },
                              // maxLength: 10,
                              keyboardType: TextInputType.text,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontWeight: FontWeight.normal),
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
                        setState(() {});
                        if (reject_msg_controller.text.isEmpty) {
                          Fluttertoast.showToast(msg: "Please Enter Reason");
                        } else {
                          String? userID = await secureStorageService.getUserID(
                              key: StorageKeys.userIDKey);
                          var body = ({
                            'user_id': userID.toString(),
                            'enq_id': inquiryID.toString(),
                            'reason': reject_msg_controller.text
                          });
                          var url = reject_enquiry_app_url;
                          await rejectEnqueyApi(url, body);
                          await getEnqueryApi();

                          Navigator.of(context).pop();
                        }
                      },
                    ),
                    TextButton(
                        onPressed: () async {
                          Navigator.pop(context);
                        },
                        child: lebelText(
                            labelText: 'Back', size: 17, color: blueColor)),
                  ],
                ),
                Positioned(
                  top: 9,
                  right: 9,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: colorConst.primarycolor),
                        color: colorConst.colorWhite,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: const Icon(Icons.close,
                          color: colorConst.primarycolor),
                    ),
                  ),
                )
              ],
            );
          });
        });
  }

  Future<void> rejectEnqueyApi(String url, dynamic body) async {
    rejectenquiryload = true;

    var result = await ApiBaseHelper().postAPICall(Uri.parse(url), body);

    if (result.statusCode == 200) {
      var responsedata = jsonDecode(result.body);
      log("client getenquiry_detail body: $body");
      log("client getenquiry_detail response: ${result.body}");
      Fluttertoast.showToast(msg: responsedata['message']);
    }

    rejectenquiryload = false;
  }

  Future<void> getEnqueryApi() async {
    enquirydetailload = true;
    String? userID =
        await secureStorageService.getUserID(key: StorageKeys.userIDKey);
    var url = show_enquiry_report_app_url;

    var body = {
      'user_id': userID.toString(),
      'from_date': startDateController.toString(),
      'to_date': endDateController.toString(),
      "inq_type": "received",
      'inq_id': '0',
      'branch_id': branchesID.toString()
    };
    var result = await ApiBaseHelper().postAPICall(Uri.parse(url), body);

    if (result.statusCode == 200) {
      var responsedata = jsonDecode(result.body);
      log("client getenquiry_detail body =>$body");
      log("client getenquiry_detail response =>${result.body}");
      enquirydetailList.add(responsedata['data']);
      GetEnquiryDetailModel getEnquiryDetailModel =
          GetEnquiryDetailModel.fromJson(responsedata);

      getEnqList = getEnquiryDetailModel.data;

      Fluttertoast.showToast(msg: responsedata['message']);
      setState(() {});
    }

    enquirydetailload = false;
  }

  addItemDialogBox() async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return PopScope(
            canPop: false, // Disable back button press
            onPopInvoked: (didPop) {
              return;
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
                                value: branchesID,
                                isDense: true,
                                onChanged: (newValue) {
                                  setState(() {
                                    branchesID = newValue;
                                  });
                                  log(branchesID);
                                },
                                items: branches.map((value) {
                                  return DropdownMenuItem(
                                    value: value['branch_id'],
                                    child:
                                        Text(value['branch_name'].toString()),
                                    onTap: () {
                                      setState(() {
                                        branchesID = value['branch_id'];
                                        branchesName = value['branch_name'];
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
                        onPressed: () async {
                          // Perform some action
                          if (branchesID == null) {
                            Fluttertoast.showToast(
                                msg: "Please Select Branch Name");
                          } else {
                            await getEnqueryApi();

                            GoRouter.of(context).pop();
                          }
                          // Navigator.of(context).pop();
                        },
                        child: const Text('OK'),
                      ),
                      TextButton(
                        onPressed: () {
                          GoRouter.of(context).goNamed(routerConst.homeNavBar);
                        },
                        child: const Text('Back'),
                      )
                    ],
                  ),
                ],
              );
            }),
          );
        });
  }
}
