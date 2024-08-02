// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:tima_app/core/constants/colorConst.dart';
import 'package:tima_app/core/constants/textconst.dart';
import 'package:tima_app/feature/drawerPage/inquiry/generateInquiry/controller/generateInquiryController.dart';
import 'package:tima_app/router/routeParams/nextVisitParams.dart';
import 'package:tima_app/router/routes/routerConst.dart';

class Generateinquiry extends StatefulWidget {
  var indexlistno;
  Generateinquiry({super.key, this.indexlistno});

  @override
  State<Generateinquiry> createState() => _GenerateinquiryState();
}

class _GenerateinquiryState extends GenerateInquiryBuilder {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
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
                  GoRouter.of(context).pushNamed(routerConst.homeNavBar);
                },
              ),
            ),
          ),
          centerTitle: true,
          title:
              txtHelper().heading1Text('GENERATE INQUIRY LIST', 21, blueColor)),
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
                        letterSpacing: 0.9,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "$branchesname",
                      style: const TextStyle(
                        color: colorConst.buttonColor,
                        fontSize: 14.0,
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
            SizedBox(
              height: 20.h,
            ),
            // pageloder
            //     ? const Center(
            //         child: CircularProgressIndicator.adaptive(),
            //       )
            //     :
            generateenquiryload
                ? const Center(
                    child: CircularProgressIndicator.adaptive(),
                  )
                : Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemCount: enquiryList.length,
                        itemBuilder: (context, index) {
                          var generateRespList = enquiryList[index];
                          return Stack(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: tfColor),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
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
                                          "Contact No. : ${generateRespList.userMobile}",
                                          style: const TextStyle(
                                              fontSize: 15,
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
                                          "Contact No.: ${generateRespList.personMobile}",
                                          style: const TextStyle(
                                              fontSize: 15,
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
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          "Client/Vendor Name : ${generateRespList.currentVendor}",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          "Current price : ${generateRespList.currentPrice}",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          "Target Buisness : ${generateRespList.targetBusiness}",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          "Remark: ${generateRespList.remark} ",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          "Status: ${generateRespList.opStatus} ",
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
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.4,
                                                      alignment:
                                                          Alignment.center,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      color: colorConst
                                                          .orangeColour,
                                                      child: const Text(
                                                        "View Detail",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            letterSpacing: 0.8),
                                                      ),
                                                    ))
                                                : Container()
                                          ]),
                                    ],
                                  ),
                                ),
                              ),
                              // Positioned(
                              //     right: 15,
                              //     top: 10,
                              //     child: GestureDetector(
                              //         onTap: () async {
                              //           GoRouter.of(context).pushNamed(
                              //               routerConst.inquiryDetailScreen,
                              //               extra: InquiryDetailParams(
                              //                   type: "generated",
                              //                   typeid: generateRespList.id,
                              //                   branchid: branchesid,
                              //                   fromdate: inquiryProvider
                              //                       .startgeneratedDateController,
                              //                   todate: inquiryProvider
                              //                       .endgeneratedDateController));
                              //         },
                              //         child: const Icon(Icons.remove_red_eye)))
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
