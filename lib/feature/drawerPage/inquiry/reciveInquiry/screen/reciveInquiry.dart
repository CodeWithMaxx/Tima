// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tima_app/core/GWidgets/btnText.dart';
import 'package:tima_app/core/constants/colorConst.dart';
import 'package:tima_app/feature/drawerPage/inquiry/reciveInquiry/controller/recivedInquiryController.dart';
import 'package:tima_app/providers/inquireyProvider/inquiry_provider.dart';
import 'package:tima_app/router/routeParams/inquiryDetailParams.dart';
import 'package:tima_app/router/routeParams/nextVisitParams.dart';
import 'package:tima_app/router/routes/routerConst.dart';

class ReciveInquiry extends StatefulWidget {
  var indexlistno;
  ReciveInquiry({super.key, this.indexlistno});

  @override
  State<ReciveInquiry> createState() => _ReciveInquiryState();
}

class _ReciveInquiryState extends RecivedInquiryController {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 15, top: 10, bottom: 3),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(100),
              ),
            ),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_outlined,
                color: Colors.black,
              ),
              padding: const EdgeInsets.all(0),
              onPressed: () {
                GoRouter.of(context).goNamed(routerConst.homeNavBar);
              },
            ),
          ),
        ),
        centerTitle: true,
        title: const Text(
          'Received Inquiry list',
          style: TextStyle(
              color: Colors.black,
              fontSize: 25,
              fontFamily: 'Comfortaa',
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                getBranchesCall();
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
                    Text(
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
                      "${branchesName ?? "None"}",
                      style: TextStyle(
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 15.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      lebelText(
                          labelText: 'Start Date',
                          size: 16.5,
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
                        DateFormat('yyyy-MM-dd')
                            .format(selectedDate)
                            .toString(),
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
                    height: 15.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      lebelText(
                          labelText: 'End Date', size: 16.5, color: blueColor),
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
                        DateFormat('yyyy-MM-dd')
                            .format(selectedEndDate)
                            .toString(),
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
            pageloder == true
                ? CircularProgressIndicator()
                : Consumer<InquiryProvider>(builder: (_, provider, __) {
                    if (provider.enquirydetailload) {
                      return CircularProgressIndicator();
                    } else {
                      return Expanded(
                        child: ListView.builder(
                            physics: ClampingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: provider.enquirydetail.data!.length,
                            itemBuilder: (context, index) {
                              var enquirydetail =
                                  provider.enquirydetail.data![index];
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
                                        width:
                                            MediaQuery.of(context).size.width,
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
                                                  "Generated On : ${enquirydetail.dateTime}",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Text(
                                                  "Generated By : ${enquirydetail.userName},${enquirydetail.userBranch}",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Text(
                                                  "Enquery Type : ${enquirydetail.enqTypeName}",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Text(
                                                  "Enquiry For : ${enquirydetail.personName},${enquirydetail.branchName}",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Text(
                                                  "Product/Service : ${enquirydetail.productServiceType} (${enquirydetail.productServiceName})",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Text(
                                                  "Client: ${enquirydetail.client} ",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Text(
                                                  "Contact Person : ${enquirydetail.contactPerson} ",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Text(
                                                  "Contact No.: ${enquirydetail.contactNo} ",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Flex(
                                                  direction: Axis.horizontal,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    enquirydetail.opStatus ==
                                                            "closed"
                                                        ? GestureDetector(
                                                            onTap: () {
                                                              GoRouter.of(context).pushNamed(
                                                                  routerConst
                                                                      .visitDetailScreen,
                                                                  extra: VisitDetailScreenParams(
                                                                      indexlistno:
                                                                          enquirydetail
                                                                              .id,
                                                                      name: enquirydetail
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
                                                                  Alignment
                                                                      .center,
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(8.0),
                                                              color: colorConst
                                                                  .orangeColour,
                                                              child: Text(
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
                                                        : enquirydetail.clientId ==
                                                                    null &&
                                                                enquirydetail
                                                                        .vendorId ==
                                                                    null
                                                            ? Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        GoRouter.of(context).pushNamed(
                                                                            routerConst
                                                                                .registerScreen,
                                                                            extra:
                                                                                enquirydetail.id);
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        height:
                                                                            40,
                                                                        width: MediaQuery.of(context).size.width *
                                                                            0.4,
                                                                        alignment:
                                                                            Alignment.center,
                                                                        padding:
                                                                            EdgeInsets.all(8.0),
                                                                        color: Colors
                                                                            .green,
                                                                        child:
                                                                            Text(
                                                                          "Map Client",
                                                                          style: TextStyle(
                                                                              color: Colors.white,
                                                                              fontWeight: FontWeight.bold,
                                                                              letterSpacing: 0.8),
                                                                        ),
                                                                      )),
                                                                  SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        showRejectDialogBoxWidget(
                                                                            enquirydetail.id);
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        height:
                                                                            40,
                                                                        width: MediaQuery.of(context).size.width *
                                                                            0.4,
                                                                        alignment:
                                                                            Alignment.center,
                                                                        padding:
                                                                            EdgeInsets.all(8.0),
                                                                        color: Colors
                                                                            .red,
                                                                        child:
                                                                            Text(
                                                                          "Reject",
                                                                          style: TextStyle(
                                                                              color: Colors.white,
                                                                              fontWeight: FontWeight.bold,
                                                                              letterSpacing: 0.8),
                                                                        ),
                                                                      )),
                                                                ],
                                                              )
                                                            : Container(),
                                                    enquirydetail.opStatus ==
                                                            "closed"
                                                        ? Container()
                                                        : enquirydetail.clientId ==
                                                                    null &&
                                                                enquirydetail
                                                                        .vendorId ==
                                                                    null
                                                            ? Container()
                                                            : GestureDetector(
                                                                onTap: () {
                                                                  GoRouter.of(
                                                                          context)
                                                                      .pushNamed(
                                                                    routerConst
                                                                        .requestAdmin,
                                                                    extra:
                                                                        enquirydetail
                                                                            .id,
                                                                  );
                                                                },
                                                                child:
                                                                    Container(
                                                                  height: 40,
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.4,
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              8.0),
                                                                  color: colorConst
                                                                      .primarycolor,
                                                                  child: Text(
                                                                    "Visit",
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
                                                  ]),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                        right: 15,
                                        top: 10,
                                        child: GestureDetector(
                                            onTap: () {
                                              GoRouter.of(context).pushNamed(
                                                  routerConst
                                                      .inquiryDetailScreen,
                                                  extra: InquiryDetailParams(
                                                    type: "received",
                                                    typeid: enquirydetail.id,
                                                    branchid: branchesID,
                                                    fromdate: provider
                                                        .startDateController,
                                                    todate: provider
                                                        .endDateController,
                                                  ));
                                            },
                                            child: Icon(Icons.remove_red_eye)))
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
    );
  }
}
