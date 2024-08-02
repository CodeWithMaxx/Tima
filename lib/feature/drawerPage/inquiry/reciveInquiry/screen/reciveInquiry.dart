// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:tima_app/core/GWidgets/btnText.dart';
import 'package:tima_app/core/constants/colorConst.dart';
import 'package:tima_app/core/constants/textconst.dart';
import 'package:tima_app/feature/drawerPage/inquiry/reciveInquiry/controller/recivedInquiryController.dart';
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
          title:
              txtHelper().heading1Text('RECIEVED INQUIRY LIST', 21, blueColor)),
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
                      "${branchesName ?? "None"}",
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
            enquirydetailload
                ? const Center(
                    child: CircularProgressIndicator.adaptive(),
                  )
                : Expanded(
                    child: ListView.builder(
                        physics: const ClampingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: getEnqList.length,
                        itemBuilder: (context, index) {
                          return Stack(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: tfColor),
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        "Generated On : ${getEnqList[index].dateTime}",
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        "Generated By : ${getEnqList[index].userName},${getEnqList[index].userBranch}",
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        "Contact No.: ${getEnqList[index].userMobile} ",
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        "Enquery Type : ${getEnqList[index].enqTypeName}",
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        "Enquiry For : ${getEnqList[index].personName},${getEnqList[index].branchName}",
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        "Contact No.: ${getEnqList[index].personMobile} ",
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        "Product/Service : ${getEnqList[index].productServiceType} (${getEnqList[index].productServiceName})",
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        "Client: ${getEnqList[index].client} ",
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        "Contact Person : ${getEnqList[index].contactPerson} ",
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        "Contact No.: ${getEnqList[index].contactNo} ",
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    //========-
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        "Client/Vendor Name : ${getEnqList[index].currentVendor}",
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        "Current price : ${getEnqList[index].currentPrice}",
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        "Target Buisness : ${getEnqList[index].targetBusiness}",
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        "Remark: ${getEnqList[index].remark} ",
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        "Status: ${getEnqList[index].opStatus} ",
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    Flex(
                                        direction: Axis.horizontal,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          getEnqList[index].opStatus == "closed"
                                              ? GestureDetector(
                                                  onTap: () {
                                                    GoRouter.of(context).pushNamed(
                                                        routerConst
                                                            .visitDetailScreen,
                                                        extra: VisitDetailScreenParams(
                                                            indexlistno:
                                                                getEnqList[
                                                                        index]
                                                                    .id,
                                                            name: getEnqList[
                                                                    index]
                                                                .personName));
                                                  },
                                                  child: Container(
                                                    height: 40,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.4,
                                                    alignment: Alignment.center,
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    color:
                                                        colorConst.orangeColour,
                                                    child: const Text(
                                                      "View Detail",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          letterSpacing: 0.8),
                                                    ),
                                                  ))
                                              : getEnqList[index].clientId ==
                                                          null &&
                                                      getEnqList[index]
                                                              .vendorId ==
                                                          null
                                                  ? Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        GestureDetector(
                                                            onTap: () {
                                                              GoRouter.of(context).pushNamed(
                                                                  routerConst
                                                                      .register,
                                                                  extra: getEnqList[
                                                                          index]
                                                                      .id);
                                                            },
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                                color: const Color
                                                                    .fromARGB(
                                                                    255,
                                                                    94,
                                                                    113,
                                                                    94),
                                                              ),
                                                              height: 40,
                                                              width:
                                                                  size.width /
                                                                      3,
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: const Text(
                                                                "Map Client",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    letterSpacing:
                                                                        0.8),
                                                              ),
                                                            )),
                                                        SizedBox(
                                                          width: 10.w,
                                                        ),
                                                        GestureDetector(
                                                            onTap: () {
                                                              showRejectDialogBoxWidget(
                                                                  getEnqList[
                                                                          index]
                                                                      .id);
                                                            },
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                                color:
                                                                    Colors.red,
                                                              ),
                                                              height: 40,
                                                              width:
                                                                  size.width /
                                                                      3,
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: const Text(
                                                                "Reject",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    letterSpacing:
                                                                        0.8),
                                                              ),
                                                            )),
                                                      ],
                                                    )
                                                  : Container(),
                                          getEnqList[index].opStatus == "closed"
                                              ? Container()
                                              : getEnqList[index].clientId ==
                                                          null &&
                                                      getEnqList[index]
                                                              .vendorId ==
                                                          null
                                                  ? Container()
                                                  : GestureDetector(
                                                      onTap: () {
                                                        GoRouter.of(context)
                                                            .pushNamed(
                                                          routerConst
                                                              .requestAdmin,
                                                          extra:
                                                              getEnqList[index]
                                                                  .id,
                                                        );
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
                                                            .primarycolor,
                                                        child: const Text(
                                                          "Visit",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
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
                            ],
                          );
                        }),
                  )
          ],
        ),
      ),
    );
  }
}
