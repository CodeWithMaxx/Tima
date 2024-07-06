import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tima_app/core/GWidgets/btnText.dart';
import 'package:tima_app/core/constants/colorConst.dart';
import 'package:tima_app/feature/NavBar/report/builder/reportBuilder.dart';
import 'package:tima_app/feature/NavBar/report/provider/reportProvder.dart';

class Reportlist extends StatefulWidget {
  const Reportlist({super.key});

  @override
  State<Reportlist> createState() => _ReportlistState();
}

class _ReportlistState extends ReportScreenBuilder {
  // * next visit label
  bool isShowNxtVisitStartLabel = true;
  bool isShowNxtVisitEndLabel = true;

  // * next visit label
  bool isShowInquriyStartLabel = true;
  bool isShowInquiryEndLabel = true;

  // * next visit label
  bool isShowAttendencStartLabel = true;
  bool isShowAttendenceEndLabel = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'Report List',
            style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: 'Comfortaa',
                fontWeight: FontWeight.bold),
          ),
          bottom: const TabBar(
            labelStyle: TextStyle(
              color: Colors.black, // Custom tab text color
            ),
            indicatorColor: colorConst.primarycolor, // Custom indicator color
            unselectedLabelColor: colorConst.colorblack,
            labelColor: colorConst.primarycolor,
            tabs: [
              Tab(
                icon: Icon(
                  Icons.location_city,
                  color: Colors.black,
                ),
                text: 'Next Visit',
              ),
              Tab(
                icon: Icon(
                  Icons.location_city,
                  color: Colors.black,
                ),
                text: 'Vist',
              ),
              Tab(
                icon: Icon(
                  Icons.person,
                  color: Colors.black,
                ),
                text: 'Attendence',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Column(
                children: [
                  SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            lebelText(
                                labelText: 'Start Date',
                                size: 14.5,
                                color: blueColor),
                          ],
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        GestureDetector(
                          onTap: () {
                            selectStartDate(context);
                            setState(() {
                              isShowNxtVisitStartLabel = false;
                            });
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
                              isShowNxtVisitStartLabel
                                  ? 'Start Date'
                                  : controller.startDateController.toString(),
                              style: const TextStyle(
                                color: colorConst.colorIconBlue,
                                fontSize: 14.0,
                                fontFamily: 'Open Sans',
                                letterSpacing: 0.5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            lebelText(
                                labelText: 'End Date',
                                size: 14.5,
                                color: blueColor),
                          ],
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        GestureDetector(
                          onTap: () {
                            selectEndDate(context);
                            setState(() {
                              isShowNxtVisitEndLabel = false;
                            });
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
                              isShowNxtVisitEndLabel
                                  ? 'End Date'
                                  : controller.endDateController.toString(),
                              style: const TextStyle(
                                color: colorConst.colorIconBlue,
                                fontSize: 14.0,
                                letterSpacing: 0.5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Consumer<ReportProvider>(builder: (_, provider, __) {
                    if (provider.nextVisitLoad) {
                      return const CircularProgressIndicator();
                    } else {
                      return Expanded(
                        child: provider.nextVisitDataList.isEmpty
                            ? Text(
                                provider.nextVisitMessage.toString(),
                                style: const TextStyle(color: blueColor),
                              )
                            : ListView.builder(
                                physics: const AlwaysScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: provider.nextVisitDataList.length,
                                itemBuilder: (context, index) {
                                  var inquiryDetails =
                                      provider.nextVisitDataList[index];

                                  return Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Stack(
                                      children: [
                                        Card(
                                          elevation: 5,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          child: SizedBox(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            5.0),
                                                    child: Text(
                                                      "Client/Vendor : ${inquiryDetails['client']}",
                                                      style: const TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            5.0),
                                                    child: Text(
                                                      "Product/Service : ${inquiryDetails['product_service']}",
                                                      style: const TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            5.0),
                                                    child: Text(
                                                      "Last Visit : ${DateFormat.yMd().add_jm().format(inquiryDetails['start_at'])} ",
                                                      style: const TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            5.0),
                                                    child: Text(
                                                      "Next Visit : ${DateFormat.yMd().add_jm().format(inquiryDetails['next_visit'])} ",
                                                      style: const TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                      );
                    }
                  })
                ],
              ), // Container for Tab 1
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Column(
                children: [
                  SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            lebelText(
                                labelText: 'Start Date',
                                size: 14.5,
                                color: blueColor),
                          ],
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        GestureDetector(
                          onTap: () {
                            selectStartDate(context);
                            setState(() {
                              isShowInquriyStartLabel = false;
                            });
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
                              isShowInquriyStartLabel
                                  ? 'Start Date'
                                  : controller.startDateController.toString(),
                              style: const TextStyle(
                                color: colorConst.colorIconBlue,
                                fontSize: 14.0,
                                fontFamily: 'Open Sans',
                                letterSpacing: 0.5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            lebelText(
                                labelText: 'End Date',
                                size: 14.5,
                                color: blueColor),
                          ],
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        GestureDetector(
                          onTap: () {
                            selectEndDate(context);
                            setState(() {
                              isShowInquiryEndLabel = false;
                            });
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
                              isShowInquiryEndLabel
                                  ? 'End Date'
                                  : controller.endDateController.toString(),
                              style: const TextStyle(
                                color: colorConst.colorIconBlue,
                                fontSize: 14.0,
                                fontFamily: 'Open Sans',
                                letterSpacing: 0.5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Consumer<ReportProvider>(builder: (_, provider, __) {
                    if (provider.enquiryVisitDetailLoad) {
                      return const Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    } else {
                      return Expanded(
                          child: provider.inquiryVisitDetailList.isEmpty
                              ? Text(provider.inquiryVisitMessage.toString())
                              : ListView.builder(
                                  physics: const ClampingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount:
                                      provider.inquiryVisitDetailList.length,
                                  itemBuilder: (context, index) {
                                    var inquiryDetails =
                                        provider.inquiryVisitDetailList[index];
                                    return Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Stack(
                                        children: [
                                          Card(
                                            elevation: 5,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            child: SizedBox(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5.0),
                                                      child: Text(
                                                        "Visit At : ${inquiryDetails['visit_at']}",
                                                        style: const TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5.0),
                                                      child: Text(
                                                        "Client/Vendor : ${inquiryDetails['vendor'] == null ? inquiryDetails['client'] : inquiryDetails['vendor']}",
                                                        style: const TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5.0),
                                                      child: Text(
                                                        "Product/Services : ${inquiryDetails['product_service']}",
                                                        style: const TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5.0),
                                                      child: Text(
                                                        "Visit Date : ${DateFormat.yMMMMd('en_US').format(inquiryDetails.startAt!)}",
                                                        style: const TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5.0),
                                                      child: Text(
                                                        "Person Name : ${inquiryDetails['person_name']}",
                                                        style: const TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5.0),
                                                      child: Text(
                                                        "Order : ${inquiryDetails['order_done']}",
                                                        style: const TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5.0),
                                                      child: Text(
                                                        "Complaints : ${inquiryDetails['query_complaint']}",
                                                        style: const TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5.0),
                                                      child: Text(
                                                        "Remark : ${inquiryDetails['remark']}",
                                                        style: const TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }));
                    }
                  })
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Column(
                children: [
                  SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            lebelText(
                                labelText: 'Start Date',
                                size: 14.5,
                                color: blueColor),
                          ],
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        GestureDetector(
                          onTap: () {
                            selectStartDate(context);
                            setState(() {
                              isShowAttendencStartLabel = false;
                            });
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
                              isShowAttendencStartLabel
                                  ? 'Start Date'
                                  : controller.startDateController.toString(),
                              style: const TextStyle(
                                color: colorConst.colorIconBlue,
                                fontSize: 14.0,
                                fontFamily: 'Open Sans',
                                letterSpacing: 0.5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            lebelText(
                                labelText: 'End Date',
                                size: 14.5,
                                color: blueColor),
                          ],
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        GestureDetector(
                          onTap: () {
                            selectEndDate(context);
                            setState(() {
                              isShowAttendenceEndLabel = false;
                            });
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
                              isShowAttendenceEndLabel
                                  ? 'End Date'
                                  : controller.endDateController.toString(),
                              style: const TextStyle(
                                color: colorConst.colorIconBlue,
                                fontSize: 14.0,
                                fontFamily: 'Open Sans',
                                letterSpacing: 0.5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Consumer<ReportProvider>(builder: (_, provider, __) {
                    if (provider.attendanceDataLoad) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return Expanded(
                        child: provider.attendanceDataList.length == 0
                            ? Text("${provider.attendanceMessage}")
                            : ListView.builder(
                                physics: AlwaysScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: provider.attendanceDataList.length,
                                itemBuilder: (context, index) {
                                  var inquiryDetails =
                                      provider.attendanceDataList[index];
                                  return Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Stack(
                                      children: [
                                        Card(
                                          elevation: 5,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          child: SizedBox(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            5.0),
                                                    child: Text(
                                                      "Date : ${inquiryDetails['att_date']}",
                                                      style: const TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            5.0),
                                                    child: Text(
                                                      "Check In : ${inquiryDetails['in_time'] == null ? " Na " : inquiryDetails['in_time']}",
                                                      style: const TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            5.0),
                                                    child: Text(
                                                      "Check Out : ${inquiryDetails['out_time'] == null ? " Na " : inquiryDetails['out_time']} ",
                                                      style: const TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            5.0),
                                                    child: Text(
                                                      "Status : ${inquiryDetails['status']} ",
                                                      style: const TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                      );
                    }
                  })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
