import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tima_app/ApiService/postApiBaseHelper.dart';
import 'package:tima_app/DataBase/keys/keys.dart';
import 'package:tima_app/core/constants/apiUrlConst.dart';
import 'package:tima_app/core/constants/colorConst.dart';
import 'package:tima_app/feature/attendence/builder/attendenceBuilder.dart';
import 'package:tima_app/providers/LocationProvider/location_provider.dart';
import 'package:tima_app/router/routes/routerConst.dart';

class Markattendance extends StatefulWidget {
  const Markattendance({super.key});

  @override
  State<Markattendance> createState() => _MarkattendanceState();
}

class _MarkattendanceState extends AttendenceBuilder {
  bool isShowUi = false;
  bool isShowUi2 = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'Mark Attendance',
            style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: 'Metropilis',
                fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              selectedAttendancePlacesid != null
                  ? Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        'Branch Selected',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: blueColor),
                      ),
                    )
                  : selectedAttendancePlacesid != 'office'
                      ? Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            'Select Branch',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: blueColor),
                          ),
                        )
                      : const SizedBox(),
              SizedBox(
                height: 8.h,
              ),
              Container(
                height: 55,
                padding: const EdgeInsets.only(top: 5, left: 18, right: 20),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10), color: tfColor),
                child: FormField<String>(
                  builder: (FormFieldState<String> state) {
                    return InputDecorator(
                      decoration:
                          const InputDecoration(border: InputBorder.none),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          hint: const Text("Select Place"),
                          value: selectedAttendancePlacesid,
                          isDense: true,
                          onChanged: (newValue) {
                            setState(() {
                              selectedAttendancePlacesid = newValue.toString();
                              isShowUi = false;
                              isShowUi2 = false;
                              client_controller.clear();
                              vendor_controller.clear();
                            });
                            log(selectedAttendancePlacesid.toString());
                          },
                          items: AttendancePlaces.map((value) {
                            return DropdownMenuItem(
                              value: value['id'],
                              child: Text(value['name']),
                              onTap: () {
                                setState(() {
                                  selectedAttendancePlacesid = value['id'];
                                  branchesid = null;
                                  selectedClientid = '';
                                  selectedVendorid = '';
                                  isShowUi = false;
                                  isShowUi2 = false;
                                  client_controller.clear();
                                  vendor_controller.clear();
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
              selectedAttendancePlacesid != "branch"
                  ? Container()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20, top: 20),
                          child: Text(
                            'Branch',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: blueColor),
                          ),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              top: 10, left: 20, right: 20),
                          child: FormField<String>(
                            builder: (FormFieldState<String> state) {
                              return InputDecorator(
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0))),
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
                                        child: Text(
                                            value['branch_name'].toString()),
                                        onTap: () {
                                          setState(() {
                                            branchesid = value['branch_id'];
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
                      ],
                    ),
              selectedAttendancePlacesid != "client"
                  ? Container()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20, top: 20),
                          child: Text(
                            'Select Client',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: blueColor),
                          ),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          padding: const EdgeInsets.only(left: 8),
                          width: size.width,
                          height: 55,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: tfColor),
                          child: TextFormField(
                            // readOnly: true,
                            controller: client_controller,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter client name';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                hintText: "Client Name",
                                border: InputBorder.none,
                                // focusedBorder: focusboarder,
                                // errorBorder: errorboarder,
                                suffixIcon: GestureDetector(
                                    onTap: () {
                                      getClients();
                                      client_controller.clear();
                                      selectedClientid = '';
                                    },
                                    child: const Icon(Icons.refresh))),
                            onChanged: (text) {
                              isShowUi = true;
                              setState(() {
                                ClientList = ClientList.where((item) =>
                                    item['org_name']
                                        .toLowerCase()
                                        .contains(text.toLowerCase())).toList();
                              });
                              if (client_controller.text.isEmpty) {
                                getClients();
                                client_controller.clear();
                                selectedClientid = '';
                                setState(() {});
                                isShowUi = false;
                              }
                            },

                            onTap: () {
                              isShowUi = true;
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
                      ],
                    ),
              isShowUi != true
                  ? Container()
                  : Container(
                      width: size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      child: ListView.builder(
                        itemCount: ClientList.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            onTap: () {
                              isShowUi = false;
                              setState(() {
                                client_controller.text =
                                    ClientList[index]['org_name'];
                                selectedClientid = ClientList[index]['id'];
                              });
                            },
                            title: Text(
                              ClientList[index]['org_name'],
                              style: const TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16),
                            ),
                          );
                        },
                      ),
                    ),
              selectedAttendancePlacesid != "vendor"
                  ? Container()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20, top: 20),
                          child: Text(
                            'Select Vendor',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: blueColor),
                          ),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          padding: const EdgeInsets.only(left: 8),
                          width: size.width,
                          height: 55,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: tfColor),
                          child: TextFormField(
                            readOnly: true,
                            controller: vendor_controller,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter vender name';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                hintText: "Vender Name",
                                border: InputBorder.none,
                                // focusedBorder: focusboarder,
                                // errorBorder: errorboarder,
                                suffixIcon: GestureDetector(
                                    onTap: () {
                                      getVendors();
                                      vendor_controller.clear();
                                      selectedVendorid = '';
                                    },
                                    child: const Icon(Icons.refresh))),
                            onChanged: (text) {
                              isShowUi2 = true;
                              setState(() {
                                VendorList = VendorList.where((item) =>
                                    item['org_name']
                                        .toLowerCase()
                                        .contains(text.toLowerCase())).toList();
                              });
                              if (vendor_controller.text.isEmpty) {
                                getVendors();
                                vendor_controller.clear();
                                selectedVendorid = '';
                                setState(() {});
                              }
                            },

                            onTap: () {
                              isShowUi2 = true;
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
                      ],
                    ),
              isShowUi2 != true
                  ? Container()
                  : Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 15,
                      ),
                      width: size.width,
                      child: ListView.builder(
                        itemCount: VendorList.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            onTap: () {
                              isShowUi2 = false;
                              setState(() {
                                setState(() {
                                  vendor_controller.text =
                                      VendorList[index]['org_name'];
                                  selectedVendorid = VendorList[index]['id'];
                                });
                              });
                            },
                            title: Text(
                              VendorList[index]['org_name'],
                              style: const TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16),
                            ),
                          );
                        },
                      ),
                    ),
              SizedBox(
                height: 30.h,
              ),
              Consumer<LocationProvider>(builder: (_, ref, __) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: 50,
                        width: 150,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (selectedAttendancePlacesid != null) {
                              if (selectedClientid != null ||
                                  branchesid != null ||
                                  selectedVendorid != null ||
                                  selectedAttendancePlacesid == "office") {
                                ref.updateMap();
                                var datetime_Date = DateFormat("yyyy-MM-dd")
                                    .format(DateTime.now());
                                var dateTime_Time =
                                    DateFormat.Hms().format(DateTime.now());
                                String? userId = await secureStorageService
                                    .getUserID(key: StorageKeys.userIDKey);
                                String? companyId =
                                    await secureStorageService.getUserCompanyID(
                                        key: StorageKeys.companyIdKey);
                                String? branchID =
                                    await secureStorageService.getUserBranchID(
                                        key: StorageKeys.branchKey);

                                var url = Uri.parse(mark_attendance_in_url);
                                var body = ({
                                  "company_id": companyId,
                                  "branch_id": branchID,
                                  "user_id": userId,
                                  "att_place":
                                      selectedAttendancePlacesid.toString(),
                                  "att_branch_id": branchesid.toString(),
                                  "att_client_id": selectedClientid.toString(),
                                  "att_vendor_id": selectedVendorid.toString(),
                                  "att_date": datetime_Date,
                                  "att_time": dateTime_Time,
                                  "location":
                                      "${ref.lat.value},${ref.lng.value}"
                                });
                                log("Check In--$body");

                                var result = await ApiBaseHelper()
                                    .postAPICall(url, body);
                                if (result.statusCode == 200) {
                                  var responsedata = jsonDecode(result.body);
                                  log("client registration :${result.body} ");
                                  if (responsedata['status'] == 1) {
                                    GoRouter.of(context)
                                        .pushNamed(routerConst.homeNavBar);
                                    Fluttertoast.showToast(
                                        msg: responsedata['message']);
                                  }
                                }
                              } else {
                                GoRouter.of(context)
                                    .pushNamed(routerConst.homeNavBar);
                                Fluttertoast.showToast(
                                    msg:
                                        "Please select $selectedAttendancePlacesid first");
                              }
                            } else {
                              Fluttertoast.showToast(
                                  msg: "Please select place first");
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: blueColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          child: Text(" Check IN  ".toUpperCase(),
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.white)),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        width: 150,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (selectedAttendancePlacesid != null) {
                              if (selectedClientid != null ||
                                  branchesid != null ||
                                  selectedVendorid != null ||
                                  selectedAttendancePlacesid == "office") {
                                ref.updateMap();
                                var datetime_Date = DateFormat("yyyy-MM-dd")
                                    .format(DateTime.now());
                                var dateTime_Time =
                                    DateFormat.Hms().format(DateTime.now());
                                String? userId = await secureStorageService
                                    .getUserID(key: StorageKeys.userIDKey);
                                String? companyId =
                                    await secureStorageService.getUserCompanyID(
                                        key: StorageKeys.companyIdKey);
                                String? branchID =
                                    await secureStorageService.getUserBranchID(
                                        key: StorageKeys.branchKey);

                                var url = Uri.parse(
                                    mark_attendance_out_url.toString());
                                var body = ({
                                  "company_id": companyId,
                                  "branch_id": branchID,
                                  "user_id": userId,
                                  "att_place": selectedAttendancePlacesid,
                                  "att_branch_id": branchesid,
                                  "att_client_id": selectedClientid,
                                  "att_vendor_id": selectedVendorid,
                                  "att_date": datetime_Date,
                                  "att_time": dateTime_Time,
                                  "location":
                                      "${ref.lat.value},${ref.lng.value}"
                                });
                                var result = await ApiBaseHelper()
                                    .postAPICall(url, body);
                                if (result.statusCode == 200) {
                                  var responsedata = jsonDecode(result.body);
                                  log("client registration : ${result.body} ");
                                  if (responsedata['status'] == 1) {
                                    Fluttertoast.showToast(
                                        msg: responsedata['message']);
                                    GoRouter.of(context)
                                        .pushNamed(routerConst.homeNavBar);
                                  }
                                }
                              } else {
                                GoRouter.of(context)
                                    .pushNamed(routerConst.homeNavBar);
                                Fluttertoast.showToast(
                                    msg:
                                        "Please select $selectedAttendancePlacesid first");
                              }
                            } else {
                              Fluttertoast.showToast(
                                  msg: "Please select place first");
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: blueColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          child: Text(" Check OUT  ".toUpperCase(),
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                );
              }),
              Container(
                child: Text(""),
              ),
            ],
          ),
        ));
  }
}
