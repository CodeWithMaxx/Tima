import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:tima_app/core/GWidgets/btnText.dart';
import 'package:tima_app/core/constants/colorConst.dart';
import 'package:tima_app/core/constants/textconst.dart';
import 'package:tima_app/feature/NavBar/report/builder/reportBuilder.dart';

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
          title: txtHelper().heading1Text('REPORT LIST', 21, blueColor),
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
                              startDateController.toString(),
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
                              endDateController.toString(),
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
                  nextVisitLoad
                      ? const Center(
                          child: CircularProgressIndicator.adaptive(),
                        )
                      : Expanded(
                          child: nextVisitDataList.isEmpty
                              ? Text(nextVisitMessage,
                                  style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                      color: blueColor))
                              : ListView.builder(
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: nextVisitDataList.length,
                                  itemBuilder: (context, index) {
                                    var inquiryDetails =
                                        nextVisitDataList[index];

                                    return Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Stack(
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: tfColor),
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
                                                      "Client/Vendor : ${inquiryDetails.client}",
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
                                                      "Product/Service : ${inquiryDetails.productService}",
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
                                                      "Last Visit : ${DateFormat.yMd().add_jm().format(inquiryDetails.startAt)} ",
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
                                                      "Next Visit : ${DateFormat.yMd().add_jm().format(inquiryDetails.nextVisit)} ",
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
                                        ],
                                      ),
                                    );
                                  }),
                        )
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
                              startDateController.toString(),
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
                              endDateController.toString(),
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
                  enquiryVisitDetailLoad
                      ? const Center(
                          child: CircularProgressIndicator.adaptive(),
                        )
                      : Expanded(
                          child: inquiryVisitDetailList.isEmpty
                              ? Text(inquiryVisitMessage.toString(),
                                  style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                      color: blueColor))
                              : ListView.builder(
                                  physics: const ClampingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: inquiryVisitDetailList.length,
                                  itemBuilder: (context, index) {
                                    var inquiryDetails =
                                        inquiryVisitDetailList[index];
                                    return Stack(
                                      children: [
                                        Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: tfColor),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: Text(
                                                    "Visit At : ${inquiryDetails.visitAt}",
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: Text(
                                                    "Client/Vendor : ${inquiryDetails.vendor == null ? inquiryDetails.client : inquiryDetails.vendor}",
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: Text(
                                                    "Product/Services : ${inquiryDetails.productService}",
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: Text(
                                                    "Visit Date : ${DateFormat.yMMMMd('en_US').format(inquiryDetails.startAt!)}",
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: Text(
                                                    "Person Name : ${inquiryDetails.personName}",
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: Text(
                                                    "Order : ${inquiryDetails.orderDone}",
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: Text(
                                                    "Complaints : ${inquiryDetails.queryComplaint}",
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: Text(
                                                    "Remark : ${inquiryDetails.remark}",
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
                                      ],
                                    );
                                  }))
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
                              startDateController.toString(),
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
                              endDateController.toString(),
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
                  attendanceDataLoad
                      ? const Center(
                          child: CircularProgressIndicator.adaptive(),
                        )
                      : Expanded(
                          child: attendanceDataList.isEmpty
                              ? Text(
                                  attendanceMessage,
                                  style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                      color: blueColor),
                                )
                              : Expanded(
                                  child: ListView.builder(
                                      physics:
                                          const AlwaysScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: attendanceDataList.length,
                                      itemBuilder: (context, index) {
                                        var inquiryDetails =
                                            attendanceDataList[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Stack(
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: tfColor),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5.0),
                                                        child: Text(
                                                          "Date : ${inquiryDetails.attDate}",
                                                          style: const TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5.0),
                                                        child: Text(
                                                          "Check In : ${inquiryDetails.inTime == null ? " Na " : inquiryDetails.inTime}",
                                                          style: const TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5.0),
                                                        child: Text(
                                                          "Check Out : ${inquiryDetails.outTime == null ? " Na " : inquiryDetails.outTime} ",
                                                          style: const TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5.0),
                                                        child: Text(
                                                          "Status : ${inquiryDetails.status} ",
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
                                            ],
                                          ),
                                        );
                                      }),
                                ),
                        )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
