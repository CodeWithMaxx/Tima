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
              title: Text(
                'Report List',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontFamily: 'Comfortaa',
                    fontWeight: FontWeight.bold),
              ),
              bottom: TabBar(
                labelStyle: TextStyle(
                  color: Colors.black, // Custom tab text color
                ),
                indicatorColor:
                    colorConst.primarycolor, // Custom indicator color
                unselectedLabelColor: colorConst.colorblack,
                labelColor: colorConst.primarycolor,
                tabs: [
                  Tab(
                    icon: Icon(
                      Icons.view_stream,
                      color: Colors.black,
                    ),
                    text: 'Next Visit',
                  ),
                  Tab(
                    icon: Icon(
                      Icons.view_stream,
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
            body: TabBarView(children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        lebelText(
                            labelText: 'Start Date',
                            size: 16.5,
                            color: blueColor)
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
                          controller.startDateController.toString(),
                          style: const TextStyle(
                            color: colorConst.colorIconBlue,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w600,
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
                            labelText: 'End Date', size: 16.5, color: blueColor)
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
                          controller.endDateController.toString(),
                          style: const TextStyle(
                            color: colorConst.colorIconBlue,
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Consumer<ReportProvider>(builder: (_, provider, __) {
                      if (provider.attendanceDataLoad) {
                        return const CircularProgressIndicator();
                      } else {
                        return Expanded(
                          child: provider.nextVisitData.length == 0
                              ? Text("${provider.nextVisitData.first.message}")
                              : ListView.builder(
                                  physics: AlwaysScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: provider.nextVisitData.length,
                                  itemBuilder: (context, index) {
                                    var inquiryDetail =
                                        provider.nextVisitData.first.data;
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
                                            child: Container(
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
                                                        "Client/Vendor : ${inquiryDetail?[index].client}",
                                                        style: TextStyle(
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
                                                        "Product/Service : ${inquiryDetail?[index].productService}",
                                                        style: TextStyle(
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
                                                        "Last Visit : ${DateFormat.yMd().add_jm().format(inquiryDetail!.first.startAt!)} ",
                                                        style: TextStyle(
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
                                                        "Next Visit : ${DateFormat.yMd().add_jm().format(inquiryDetail.first.nextVisit!)} ",
                                                        style: TextStyle(
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
                                  }),
                        );
                      }
                    })
                  ],
                ), // Container for Tab 1
              ),
              Container(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 15),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              lebelText(
                                  labelText: 'Start Date',
                                  size: 16.5,
                                  color: blueColor)
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
                                controller.startDateController.toString(),
                                style: const TextStyle(
                                  color: colorConst.colorIconBlue,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w600,
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
                                  size: 16.5,
                                  color: blueColor)
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
                                controller.endDateController.toString(),
                                style: const TextStyle(
                                  color: colorConst.colorIconBlue,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          Consumer<ReportProvider>(builder: (_, provider, __) {
                            if (provider.enquiryVisitDetailLoad) {
                              return CircularProgressIndicator();
                            } else {
                              return Expanded(
                                  child: provider.enquiryVisitDetail.data!
                                              .length ==
                                          0
                                      ? Text(
                                          "${provider.enquiryVisitDetail.message}")
                                      : ListView.builder(
                                          physics: ClampingScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: provider
                                              .enquiryVisitDetail.data!.length,
                                          itemBuilder: (context, index) {
                                            var enquirydetail = provider
                                                .enquiryVisitDetail
                                                .data![index];
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Stack(
                                                children: [
                                                  Card(
                                                    elevation: 5,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    ),
                                                    child: Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(5.0),
                                                              child: Text(
                                                                "Visit At : ${enquirydetail.visitAt}",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15,
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
                                                                "Client/Vendor : ${enquirydetail.vendor == null ? enquirydetail.client : enquirydetail.vendor}",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15,
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
                                                                "Product/Services : ${enquirydetail.productService}",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15,
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
                                                                "Visit Date : ${DateFormat.yMMMMd('en_US').format(enquirydetail.startAt!)}",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15,
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
                                                                "Person Name : ${enquirydetail.personName}",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15,
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
                                                                "Order : ${enquirydetail.orderDone}",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15,
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
                                                                "Complaints : ${enquirydetail.queryComplaint}",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15,
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
                                                                "Remark : ${enquirydetail.remark}",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15,
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 15),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              lebelText(
                                  labelText: 'Start Date',
                                  size: 16.5,
                                  color: blueColor)
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
                                controller.startDateController.toString(),
                                style: const TextStyle(
                                  color: colorConst.colorIconBlue,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w600,
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
                                  size: 16.5,
                                  color: blueColor)
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
                                controller.endDateController.toString(),
                                style: const TextStyle(
                                  color: colorConst.colorIconBlue,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          Consumer<ReportProvider>(builder: (_, provider, __) {
                            if (provider.attendanceDataLoad) {
                              return CircularProgressIndicator();
                            } else {
                              return Expanded(
                                child: provider.attendanceData.data!.length == 0
                                    ? Text("${provider.attendanceData.message}")
                                    : ListView.builder(
                                        physics:
                                            AlwaysScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: provider
                                            .attendanceData.data!.length,
                                        itemBuilder: (context, index) {
                                          var enquirydetail = provider
                                              .attendanceData.data![index];
                                          return Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Stack(
                                              children: [
                                                Card(
                                                  elevation: 5,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                  ),
                                                  child: Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(5.0),
                                                            child: Text(
                                                              "Date : ${enquirydetail.attDate}",
                                                              style: TextStyle(
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
                                                              "Check In : ${enquirydetail.inTime == null ? " Na " : enquirydetail.inTime}",
                                                              style: TextStyle(
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
                                                              "Check Out : ${enquirydetail.outTime == null ? " Na " : enquirydetail.outTime} ",
                                                              style: TextStyle(
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
                                                              "Status : ${enquirydetail.status} ",
                                                              style: TextStyle(
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
            ])));
  }
}
