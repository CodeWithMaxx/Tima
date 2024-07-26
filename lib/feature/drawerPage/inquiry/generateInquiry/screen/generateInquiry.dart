// ignore_for_file: must_be_immutable

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tima_app/ApiService/postApiBaseHelper.dart';
import 'package:tima_app/DataBase/dataHub/secureStorageService.dart';
import 'package:tima_app/DataBase/keys/keys.dart';
import 'package:tima_app/core/constants/apiUrlConst.dart';
import 'package:tima_app/core/constants/colorConst.dart';
import 'package:tima_app/feature/drawerPage/inquiry/generateInquiry/provider/generateInqProvider.dart';
import 'package:tima_app/providers/inquireyProvider/inquiry_provider.dart';
import 'package:tima_app/router/routeParams/inquiryDetailParams.dart';
import 'package:tima_app/router/routeParams/nextVisitParams.dart';
import 'package:tima_app/router/routes/routerConst.dart';

class Generateinquiry extends StatefulWidget {
  var indexlistno;
  Generateinquiry({super.key, this.indexlistno});

  @override
  State<Generateinquiry> createState() => _GenerateinquiryState();
}

class _GenerateinquiryState extends State<Generateinquiry> {
  InquiryProvider inquiryProvider = InquiryProvider();
  SecureStorageService secureStorageService = SecureStorageService();
  final EnquiryProvider enquiryProvider = EnquiryProvider();
  DateTime selectedDate = DateTime.now();
  DateTime selectedEndDate = DateTime.now();
  bool pageloder = true;
  var branchesid;
  var branchesname;
  List branches = [];
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
    inquiryProvider.startgeneratedDateController =
        DateFormat('yyyy-MM-dd').format(selectedDate);
    inquiryProvider.endgeneratedDateController =
        DateFormat('yyyy-MM-dd').format(selectedEndDate);
    getbranchescall();
    getenquirydataapi();
    super.initState();
  }

  Future<void> _selectStartDate(BuildContext context) async {
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
        inquiryProvider.startgeneratedDateController =
            DateFormat('yyyy-MM-dd').format(selectedDate);
        if (inquiryProvider.endgeneratedDateController.isNotEmpty) {
          getenquirydataapi();
        }
      });
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
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
        inquiryProvider.endgeneratedDateController =
            DateFormat('yyyy-MM-dd').format(selectedEndDate);
        getenquirydataapi();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 15, top: 10, bottom: 3),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(100),
              ),
            ),
            child: IconButton(
              icon: Icon(
                Icons.arrow_back_outlined,
                color: Colors.black,
              ),
              padding: const EdgeInsets.all(0),
              onPressed: () {
                GoRouter.of(context).pushNamed(routerConst.homeNavBar);
              },
            ),
          ),
        ),
        centerTitle: true,
        title: const Text(
          'Generated Enquiry list',
          style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontFamily: 'Comfortaa',
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                getbranchescall();
              },
              child: Container(
                // height: 50,
                width: size.width,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: colorConst.colorWhite,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      "Selected Branch : ",
                      style: TextStyle(
                        color: colorConst.colorIconBlue,
                        fontSize: 12.0,
                        fontFamily: 'Open Sans',
                        letterSpacing: 0.9,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "$branchesname",
                      style: const TextStyle(
                        color: colorConst.buttonColor,
                        fontSize: 14.0,
                        fontFamily: 'Open Sans',
                        letterSpacing: 0.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 25.h,
            ),
            const Text('Start Date'),
            SizedBox(
              height: 10.h,
            ),
            GestureDetector(
              onTap: () {
                _selectStartDate(context);
              },
              child: Container(
                height: 55,
                width: size.width,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: tfColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  DateFormat('yyyy-MM-dd').format(selectedDate).toString(),
                  style: const TextStyle(
                    color: colorConst.colorIconBlue,
                    fontSize: 14.0,
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 25.h,
            ),
            const Text('End Date'),
            SizedBox(
              height: 10.h,
            ),
            GestureDetector(
              onTap: () {
                _selectEndDate(context);
              },
              child: Container(
                height: 55,
                width: size.width,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: tfColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  DateFormat('yyyy-MM-dd').format(selectedEndDate).toString(),
                  style: const TextStyle(
                    color: colorConst.colorIconBlue,
                    fontSize: 14.0,
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            enquiryProvider.generateenquiryload == true
                ? const Center(
                    child: CircularProgressIndicator.adaptive(),
                  )
                : Consumer<EnquiryProvider>(
                    builder: (context, provider, child) {
                    return Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          itemCount: provider.enquiryList.length,
                          itemBuilder: (context, index) {
                            var generateRespList = provider.enquiryList[index];
                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Stack(
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Text(
                                              "Generated On : ${generateRespList.dateTime}",
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Text(
                                              "Generated By : ${generateRespList.userName},${generateRespList.userBranch}",
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Text(
                                              "Enquery Type : ${generateRespList.enqTypeName}",
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Text(
                                              "Enquiry For : ${generateRespList.personName},${generateRespList.branchName}",
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Text(
                                              "Product/Service : ${generateRespList.productServiceType} (${generateRespList.productServiceName})",
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Text(
                                              "Client: ${generateRespList.client} ",
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Text(
                                              "Contact Person : ${generateRespList.personName} ",
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Text(
                                              "Contact No.: ${generateRespList.contactNo} ",
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Flex(
                                              direction: Axis.horizontal,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                generateRespList.opStatus ==
                                                        "closed"
                                                    ? GestureDetector(
                                                        onTap: () {
                                                          GoRouter.of(context).pushNamed(
                                                              routerConst
                                                                  .visitDetailScreen,
                                                              extra: VisitDetailScreenParams(
                                                                  indexlistno:
                                                                      generateRespList
                                                                          .id,
                                                                  name: generateRespList
                                                                      .personName));
                                                        },
                                                        child: Container(
                                                          height: 40,
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.4,
                                                          alignment:
                                                              Alignment.center,
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          color: colorConst
                                                              .orangeColour,
                                                          child: const Text(
                                                            "View Detail",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                letterSpacing:
                                                                    0.8),
                                                          ),
                                                        ))
                                                    : Container()
                                              ]),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                      right: 15,
                                      top: 10,
                                      child: GestureDetector(
                                          onTap: () async {
                                            GoRouter.of(context).pushNamed(
                                                routerConst.inquiryDetailScreen,
                                                extra: InquiryDetailParams(
                                                    type: "generated",
                                                    typeid: generateRespList.id,
                                                    branchid: branchesid,
                                                    fromdate: inquiryProvider
                                                        .startgeneratedDateController,
                                                    todate: inquiryProvider
                                                        .endgeneratedDateController));
                                          },
                                          child:
                                              const Icon(Icons.remove_red_eye)))
                                ],
                              ),
                            );
                          }),
                    );
                  }),
          ],
        ),
      ),
    );
  }

  Future<dynamic> deleyed() {
    return Future.delayed(const Duration(seconds: 2));
  }

  Future<void> getenquirydataapi() async {
    String? userid =
        await secureStorageService.getUserID(key: StorageKeys.userIDKey);
    String? branchID =
        await secureStorageService.getUserBranchID(key: StorageKeys.branchKey);
    // var body = jsonEncode();
    var url = show_enquiry_report_app_url;
    enquiryProvider.getGenerateEnquiryApi(url, {
      'user_id': userid.toString(),
      'from_date': inquiryProvider.startgeneratedDateController.toString(),
      'to_date': inquiryProvider.endgeneratedDateController.toString(),
      "inq_type": "generated",
      "inq_id": '0',
      'branch_id': branchID.toString()
    });
    // pageloder = false;
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
                            await getenquirydataapi();

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
