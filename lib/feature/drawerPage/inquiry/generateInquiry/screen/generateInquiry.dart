// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tima_app/core/constants/colorConst.dart';
import 'package:tima_app/feature/drawerPage/inquiry/generateInquiry/controller/generateInquiryController.dart';
import 'package:tima_app/feature/drawerPage/inquiry/inquiryDetails/screen/inquiryDetail.dart';
import 'package:tima_app/providers/inquireyProvider/inquiry_provider.dart';
import 'package:tima_app/router/routeParams/inquiryDetailParams.dart';
import 'package:tima_app/router/routeParams/nextVisitParams.dart';
import 'package:tima_app/router/routes/routerConst.dart';

class GenerateInquiryScreen extends StatefulWidget {
  final String? indexListNo;
  const GenerateInquiryScreen({super.key, this.indexListNo});

  @override
  State<GenerateInquiryScreen> createState() => _GenerateInquiryScreenState();
}

class _GenerateInquiryScreenState extends GenerateInquiryController {
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
          'Generated Enquiry list',
          style: TextStyle(
              color: Colors.black,
              fontSize: 25,
              fontFamily: 'Comfortaa',
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              getBranchesCallFromApi();
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
                    branchesname!,
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
            height: 100,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    selectStartDate(context);
                  },
                  child: Container(
                    height: 85,
                    width: size.width * 0.3,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: colorConst.colorWhite,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text(
                          "Start Date",
                          style: TextStyle(
                            color: colorConst.colorIconBlue,
                            fontSize: 14.0,
                            fontFamily: 'Open Sans',
                            letterSpacing: 0.5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          DateFormat('yyyy-MM-dd').format(selectedDate),
                          style: const TextStyle(
                            color: colorConst.colorIconBlue,
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
                GestureDetector(
                  onTap: () {
                    selectEndDate(context);
                  },
                  child: Container(
                    height: 85,
                    width: size.width * 0.3,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: colorConst.colorWhite,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text(
                          "End Date",
                          style: TextStyle(
                            color: colorConst.colorIconBlue,
                            fontSize: 14.0,
                            fontFamily: 'Open Sans',
                            letterSpacing: 0.5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          DateFormat('yyyy-MM-dd').format(selectedEndDate),
                          style: const TextStyle(
                            color: colorConst.colorIconBlue,
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
              ],
            ),
          ),
          pageloder
              ? const CircularProgressIndicator()
              : Consumer<InquiryProvider>(builder: (_, ref, __) {
                  if (ref.generateenquiryload) {
                    return const CircularProgressIndicator();
                  } else {
                    return Expanded(
                      child: ListView.builder(
                          physics: const ClampingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: ref.generatedinquiry.data!.length,
                          itemBuilder: (context, index) {
                            // var enquirydetail =
                            //     ref.generatedinquiry.data![index];
                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Stack(
                                children: [
                                  Card(
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: SizedBox(
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
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Text(
                                                "Generated On : ${ref.generatedinquiry.data?[index].dateTime}",
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Text(
                                                "Generated By : ${ref.generatedinquiry.data?[index].userName},${ref.generatedinquiry.data?[index].userBranch}",
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Text(
                                                "Enquery Type : ${ref.generatedinquiry.data?[index].enqTypeName}",
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Text(
                                                "Enquiry For : ${ref.generatedinquiry.data?[index].personName},${ref.generatedinquiry.data?[index].branchName}",
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Text(
                                                "Product/Service : ${ref.generatedinquiry.data?[index].productServiceType} (${ref.generatedinquiry.data?[index].productServiceName})",
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
                                                "Client: ${ref.generatedinquiry.data?[index].client} ",
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
                                                "Contact Person : ${ref.generatedinquiry.data?[index].contactPerson} ",
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
                                                "Contact No.: ${ref.generatedinquiry.data?[index].contactNo} ",
                                                style: const TextStyle(
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
                                                  ref
                                                              .generatedinquiry
                                                              .data?[index]
                                                              .opStatus ==
                                                          "closed"
                                                      ? GestureDetector(
                                                          onTap: () {
                                                            GoRouter.of(context).goNamed(
                                                                routerConst
                                                                    .visitDetailScreen,
                                                                extra: VisitDetailScreenParams(
                                                                    indexlistno: ref
                                                                        .generatedinquiry
                                                                        .data?[
                                                                            index]
                                                                        .id,
                                                                    name: ref
                                                                        .generatedinquiry
                                                                        .data?[
                                                                            index]
                                                                        .personName));
                                                          },
                                                          child: Container(
                                                            height: 40,
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.4,
                                                            alignment: Alignment
                                                                .center,
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
                                  ),
                                  Positioned(
                                      right: 15,
                                      top: 10,
                                      child: GestureDetector(
                                          onTap: () {
                                            GoRouter.of(context).goNamed(
                                                routerConst.inquiryDetailScreen,
                                                extra: InquiryDeatil(
                                                    inquiryDetailParams:
                                                        InquiryDetailParams(
                                                  type: "generated",
                                                  typeid: ref.generatedinquiry
                                                      .data?[index].id,
                                                  branchid: branchesid,
                                                  fromdate: ref
                                                      .startgeneratedDateController,
                                                  todate: ref
                                                      .endgeneratedDateController,
                                                )));
                                          },
                                          child:
                                              const Icon(Icons.remove_red_eye)))
                                ],
                              ),
                            );
                          }),
                    );
                  }
                })
        ],
      ),
    );
  }
}
