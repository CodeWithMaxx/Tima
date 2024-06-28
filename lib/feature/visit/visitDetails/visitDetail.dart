// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tima_app/DataBase/dataHub/secureStorageService.dart';
import 'package:tima_app/DataBase/keys/keys.dart';
import 'package:tima_app/core/constants/apiUrlConst.dart';
import 'package:tima_app/providers/inquireyProvider/inquiry_provider.dart';
import 'package:tima_app/router/routeParams/nextVisitParams.dart';
import 'package:tima_app/router/routes/routerConst.dart';

class VisitDeatil extends StatefulWidget {
  final VisitDetailScreenParams visitDetailScreenParams;
  VisitDeatil({super.key, required this.visitDetailScreenParams});

  @override
  State<VisitDeatil> createState() => _VisitDeatilState();
}

class _VisitDeatilState extends State<VisitDeatil> {
  SecureStorageService _secureStorageService = SecureStorageService();
  InquiryProvider inquiryProvider = InquiryProvider();
  var carres;
  List cardatalist = [];
  List imageSliders = ['assets/banner.jpg', 'assets/banner1.jpg'];

  @override
  void initState() {
    getenquirydataapi();
    super.initState();
  }

  Future<void> getenquirydataapi() async {
    var url = get_visit_data_url;
    String? userID =
        await _secureStorageService.getUserID(key: StorageKeys.userIDKey);
    var body = ({
      'user_id': userID.toString(),
      'id': widget.visitDetailScreenParams.indexlistno,
      'from_date': '',
      'to_date': ''
    });

    inquiryProvider.getVisitDetailapi(url, body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
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
                GoRouter.of(context).goNamed(routerConst.homeNavBar);
              },
            ),
          ),
        ),
        centerTitle: true,
        title: Text(
          'Visit Detail list',
          style: TextStyle(
              color: Colors.black,
              fontSize: 25,
              fontFamily: 'Comfortaa',
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          Text(
            'Update of product related enquiry :\n\n${widget.visitDetailScreenParams.name}',
            style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                letterSpacing: 1,
                fontFamily: 'Comfortaa',
                fontWeight: FontWeight.bold),
          ),
          Consumer<InquiryProvider>(builder: (_, ref, __) {
            if (ref.enquiryvisitdetailload) {
              return CircularProgressIndicator();
            } else {
              return ListView.builder(
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: ref.enquiryvisitetail.data!.length,
                  itemBuilder: (context, index) {
                    var InquiryDetails = ref.enquiryvisitetail.data![index];
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Stack(
                        children: [
                          Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        "Visit At : ${InquiryDetails.visitAt}",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        "Client/Vendor : ${InquiryDetails.vendor == null ? InquiryDetails.client : InquiryDetails.vendor}",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        "Product/Services : ${InquiryDetails.productService}",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        "Visit Date : ${DateFormat.yMMMMd('en_US').format(InquiryDetails.startAt!)}",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        "Person Name : ${InquiryDetails.personName}",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        "Order : ${InquiryDetails.orderDone}",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        "Complaints : ${InquiryDetails.queryComplaint}",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        "Remark : ${InquiryDetails.remark}",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
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
                  });
            }
          })
        ],
      ),
    );
  }
}
