// ignore_for_file: must_be_immutable

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tima_app/Admin/controller/adminController.dart';
import 'package:tima_app/DataBase/keys/keys.dart';
import 'package:tima_app/core/GWidgets/btnText.dart';
import 'package:tima_app/core/GWidgets/textfieldsStyle.dart';
import 'package:tima_app/core/GWidgets/toast.dart';
import 'package:tima_app/core/constants/apiUrlConst.dart';
import 'package:tima_app/core/constants/colorConst.dart';
import 'package:tima_app/feature/NavBar/home/homeNavBar.dart';
import 'package:tima_app/providers/LocationProvider/location_provider.dart';
import 'package:tima_app/router/routes/routerConst.dart';

class RequestAdmin extends StatefulWidget {
  var inquiryID;
  RequestAdmin({super.key, this.inquiryID});

  @override
  State<RequestAdmin> createState() => _RequestAdminState();
}

class _RequestAdminState extends AdminController {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        // backgroundColor: colorConst.backgroundcolor,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'Visit',
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Column(
                children: [
                  Container(
                    height: 40,
                    width: size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: tfColor),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          fit: FlexFit.loose,
                          child: RadioListTile(
                            visualDensity: const VisualDensity(
                                vertical: -4, horizontal: -4),
                            value: 1,
                            activeColor: colorConst.primarycolor,
                            groupValue: selectedRadioTile,
                            title: const Text(
                              "Client",
                              style: TextStyle(
                                  fontSize: 14.2, fontWeight: FontWeight.bold),
                            ),
                            onChanged: (dynamic val) async {
                              setSelectedRadioTile(val);
                            },
                            selected: false,
                          ),
                        ),
                        Flexible(
                          fit: FlexFit.loose,
                          //color: Colors.red,
                          child: RadioListTile(
                            visualDensity: const VisualDensity(
                                vertical: -4, horizontal: -4),
                            value: 2,
                            groupValue: selectedRadioTile,
                            title: const Text("Vender",
                                style: TextStyle(
                                    fontSize: 14.2,
                                    fontWeight: FontWeight.bold)),
                            onChanged: (dynamic val) {
                              setSelectedRadioTile(val);
                            },
                            activeColor: colorConst.primarycolor,
                            selected: false,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      lebelText(
                          labelText: selectedRadioTile == 1
                              ? 'Client Name'
                              : 'Vendor Name',
                          size: 14.2,
                          color: blueColor),
                    ],
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  selectedRadioTile == 1
                      ? Container(
                          alignment: Alignment.centerLeft,
                          width: size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: tfColor),
                          child: TextFormField(
                            // readOnly: true,
                            controller: clientController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter client name';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                hintText: "Client Name",
                                border: boarder,
                                focusedBorder: focusboarder,
                                errorBorder: errorboarder,
                                labelStyle: const TextStyle(
                                  fontSize: 14,
                                ),
                                suffixIcon: GestureDetector(
                                    onTap: () {
                                      getClientFromApi();
                                      clientController.clear();
                                      selectedClientid = null;
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
                              if (clientController.text.isEmpty) {
                                getClientFromApi();
                                clientController.clear();
                                selectedClientid = null;
                                setState(() {});
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
                        )
                      : Container(),
                  isShowUi != true
                      ? Container()
                      : ListView.builder(
                          itemCount: ClientList.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemBuilder: (BuildContext context, int index) {
                            var ClientLists = ClientList[index];
                            return ListTile(
                              onTap: () {
                                isShowUi = false;
                                setState(() {
                                  setState(() {
                                    clientController.text =
                                        ClientLists['org_name'];
                                    selectedClientid = ClientLists['id'];
                                  });
                                });
                              },
                              title: Text(
                                ClientLists['org_name'],
                                style: const TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.2),
                              ),
                            );
                          },
                        ),
                  selectedRadioTile == 1
                      ? SizedBox(
                          height: 5.h,
                        )
                      : Container(),
                  selectedRadioTile == 2
                      ? SizedBox(
                          height: 5.h,
                        )
                      : Container(),
                  // SizedBox(
                  //   height: 10.h,
                  // ),
                  selectedRadioTile == 2
                      ? Container(
                          alignment: Alignment.centerLeft,
                          width: size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: tfColor),
                          child: TextFormField(
                            // readOnly: true,
                            controller: vendorController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter vender name';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                hintText: "Vender Name",
                                border: boarder,
                                focusedBorder: focusboarder,
                                errorBorder: errorboarder,
                                hintStyle: const TextStyle(fontSize: 14.5),
                                suffixIcon: GestureDetector(
                                    onTap: () {
                                      getVendorFromApi();
                                      vendorController.clear();
                                      selectedVendorid = null;
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
                              if (vendorController.text.isEmpty) {
                                getVendorFromApi();
                                vendorController.clear();
                                selectedVendorid = null;
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
                        )
                      : Container(),
                  isShowUi2 != true
                      ? Container()
                      : ListView.builder(
                          itemCount: VendorList.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemBuilder: (BuildContext context, int index) {
                            var ClientLists = VendorList[index];
                            return ListTile(
                              onTap: () {
                                isShowUi2 = false;
                                setState(() {
                                  setState(() {
                                    vendorController.text =
                                        ClientLists['org_name'];
                                    selectedVendorid = ClientLists['id'];
                                  });
                                });
                              },
                              title: Text(
                                ClientLists['org_name'],
                                style: const TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16),
                              ),
                            );
                          },
                        ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      lebelText(
                          labelText: 'Person Name',
                          size: 14.2,
                          color: blueColor),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: tfColor),
                    child: TextFormField(
                      // readOnly: true,
                      controller: personNameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Person Name';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          hintText: "Person Name",
                          border: boarder,
                          focusedBorder: focusboarder,
                          errorBorder: errorboarder,
                          hintStyle: const TextStyle(fontSize: 14.5)),
                      onChanged: (text) {
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
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      lebelText(
                          labelText: 'Designation Name',
                          size: 14.2,
                          color: blueColor),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: tfColor),
                    child: TextFormField(
                      // readOnly: true,
                      controller: personDesignationController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Designation';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          hintText: "Designation Name",
                          border: boarder,
                          focusedBorder: focusboarder,
                          errorBorder: errorboarder,
                          hintStyle: const TextStyle(fontSize: 14.5)),
                      onChanged: (text) {
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
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      lebelText(
                          labelText: 'Contact No',
                          size: 14.2,
                          color: blueColor),
                    ],
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: tfColor),
                    child: TextFormField(
                      // readOnly: true,
                      controller: personMobileNoController,
                      maxLength: 10,
                      keyboardType: TextInputType.number,

                      validator: (value) {
                        RegExp regex = RegExp(r'^[6-9][0-9]{9}$');
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Your Phone Number';
                        } else if (!regex.hasMatch(value)) {
                          return 'Invalid Contact No';
                        } else if (value.length != 10) {
                          return 'Phone Number is not valid';
                        }
                        return null;
                      },

                      decoration: InputDecoration(
                          counterText: "",
                          hintText: "Contact No",
                          border: boarder,
                          focusedBorder: focusboarder,
                          errorBorder: errorboarder,
                          hintStyle: const TextStyle(fontSize: 14.5)),
                      onChanged: (text) {
                        setState(() {});
                      },
                      // maxLength: 10,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      lebelText(
                          labelText: 'Start Time', size: 14.2, color: blueColor)
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),

                  GestureDetector(
                    onTap: () => selectStartTimeByUser(context),
                    child: Container(
                      width: size.width,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: tfColor),
                      child: Text(
                          selectedStartTime != null
                              ? "Start Time: ${selectedStartTime!.format(context)}"
                              : "Select Start Time",
                          style: const TextStyle(
                              color: blueColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w700)),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      lebelText(
                          labelText: 'Pick Image', size: 14.2, color: blueColor)
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      pickeImageByUser();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 220,
                      width: 220,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: tfColor),
                      child: image != null
                          ? Image.file(
                              image ?? File(''),
                              fit: BoxFit.cover,
                              width:
                                  200, // Set the desired width of the square box
                              height: 150,
                            )
                          : Image.asset(
                              'assets/timalogo.jpeg', // Replace with your image path
                              fit: BoxFit.cover,
                              width:
                                  200, // Set the desired width of the square box
                              height: 150,
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
                          labelText: 'Select Product/Service',
                          size: 14.2,
                          color: blueColor),
                    ],
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Container(
                    width: size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: tfColor),
                    child: FormField<String>(
                      builder: (FormFieldState<String> state) {
                        return InputDecorator(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0))),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              hint: const Text("Select Product/Service "),
                              value: productServiceTypeID,
                              isDense: true,
                              onChanged: (newValue) {
                                setState(() {
                                  productServiceTypeID = newValue;
                                });
                                log(productServiceTypeID);
                              },
                              items: productServiceType.map((value) {
                                return DropdownMenuItem(
                                  value: value['id'],
                                  child: Text(value['name'].toString()),
                                  onTap: () {
                                    setState(() {
                                      productServiceTypeID = value['id'];
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
                  SizedBox(
                    height: 10.h,
                  ),
                  const Text(
                    "Order Done",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Row(
                    children: [
                      Flexible(
                        fit: FlexFit.loose,
                        child: RadioListTile<String>(
                          title: const Text("Yes"),
                          value: "yes",
                          groupValue: selectedOption,
                          onChanged: (value) {
                            setState(() {
                              selectedOption = value;
                            });
                          },
                        ),
                      ),
                      Flexible(
                        fit: FlexFit.loose,
                        child: RadioListTile<String>(
                          title: const Text("No"),
                          value: "no",
                          groupValue: selectedOption,
                          onChanged: (value) {
                            setState(() {
                              selectedOption = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      lebelText(
                          labelText: 'Complaint', size: 14.2, color: blueColor),
                    ],
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: tfColor),
                    child: TextFormField(
                      // readOnly: true,
                      controller: quiryController,

                      decoration: InputDecoration(
                          hintText: "Complaint",
                          border: boarder,
                          focusedBorder: focusboarder,
                          errorBorder: errorboarder,
                          hintStyle: const TextStyle(fontSize: 14.5)),
                      onChanged: (text) {
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
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      lebelText(
                          labelText: 'Remark', size: 14.2, color: blueColor),
                    ],
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: tfColor),
                    child: TextFormField(
                      // readOnly: true,
                      controller: remarkController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Your Remark';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          hintText: "Remark",
                          border: boarder,
                          focusedBorder: focusboarder,
                          errorBorder: errorboarder,
                          hintStyle: const TextStyle(fontSize: 14.5)),
                      onChanged: (text) {
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
                  SizedBox(
                    height: 15.h,
                  ),
                  const Text(
                    "Next Visit",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(Icons.calendar_month),
                      SizedBox(
                        width: 8.h,
                      ),
                      lebelText(
                          labelText: 'Select Date',
                          size: 14.2,
                          color: blueColor),
                    ],
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  GestureDetector(
                    onTap: () => selectDateByUser(context),
                    child: Container(
                      alignment: Alignment.center,
                      height: 50,
                      width: size.width,
                      padding: const EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: tfColor),
                      child: Text(
                        selectedDate != null
                            ? "Selected Date: ${selectedDate.toString().split(' ')[0]}"
                            : "Tap to Select Date",
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: blueColor),
                      ),
                    ),
                  ),

                  SizedBox(height: 32.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(Icons.timer),
                      SizedBox(
                        width: 8.h,
                      ),
                      lebelText(
                          labelText: 'Select Time',
                          size: 14.2,
                          color: blueColor),
                    ],
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  GestureDetector(
                    onTap: () => selectTimeByUser(context),
                    child: Container(
                      alignment: Alignment.center,
                      height: 50,
                      width: size.width,
                      padding: const EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: tfColor),
                      child: Text(
                        selectedTime != null
                            ? "Selected Time: ${selectedTime!.format(context)}"
                            : "Tap to Select Time",
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: blueColor),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Consumer<LocationProvider>(builder: (_, ref, __) {
                    return GestureDetector(
                      onTap: formloder == true
                          ? null
                          : () async {
                              List productServiceID = [];
                              if (_formKey.currentState!.validate()) {
                                if (selectedRadioTile.toString() != '') {
                                  if (selectedRadioTile == 1) {
                                    if (selectedClientid != null) {
                                      if (selectedStartTime != null) {
                                        if (image != null) {
                                          if (productServiceTypeID != null) {
                                            if (selectedOption != null) {
                                              ref.updateMap();
                                              setState(() {
                                                formloder = true;
                                              });

                                              // if (selectedDate != null) {
                                              //   if (selectedTime != null) {
                                              productServiceID
                                                  .add(productServiceTypeID);
                                              String? userid =
                                                  await secureStorageService
                                                      .getUserID(
                                                          key: StorageKeys
                                                              .userIDKey);
                                              String? usercompanyid =
                                                  await secureStorageService
                                                      .getUserCompanyID(
                                                          key: StorageKeys
                                                              .companyIdKey);
                                              var url =
                                                  Uri.parse(get_visitsave_url);
                                              EndDate = DateFormat("yyyy-MM-dd")
                                                      .format(DateTime.now()) +
                                                  " " +
                                                  DateFormat.Hms()
                                                      .format(DateTime.now());
                                              var body = ({
                                                'user_id': userid,
                                                "company_id": usercompanyid,
                                                'visit_at': 'client',
                                                'client_id':
                                                    selectedClientid.toString(),
                                                'start_at': selectedStartTime ==
                                                        null
                                                    ? ''
                                                    : "${DateFormat("yyyy-MM-dd").format(DateTime.now())} ${selectedStartTime!.format(context).toString()}",
                                                'end_at': EndDate.toString(),
                                                'person_name':
                                                    personNameController.text,
                                                'person_desi':
                                                    personDesignationController
                                                        .text,
                                                'person_mobile':
                                                    personMobileNoController
                                                        .text,
                                                'product_service':
                                                    productServiceID.toString(),
                                                'query_complaint':
                                                    quiryController.text,
                                                'order_done': selectedOption,
                                                'next_visit': selectedDate !=
                                                        null
                                                    ? '${selectedDate.toString().split(' ')[0]} ${selectedTime!.format(context)}'
                                                    : '',
                                                'remark': remarkController.text,
                                                "inq_id": widget.inquiryID,
                                                'location':
                                                    "${ref.lat.value},${ref.lng.value}"
                                              });
                                              log("postAPICall Visit body :$body");
                                              var request =
                                                  http.MultipartRequest(
                                                      'POST',
                                                      Uri.parse(
                                                          get_visitsave_url));
                                              request.fields.addAll({
                                                'user_id': userid.toString(),
                                                "company_id":
                                                    usercompanyid.toString(),
                                                'visit_at': 'client',
                                                'client_id':
                                                    selectedClientid.toString(),
                                                'start_at': selectedStartTime ==
                                                        null
                                                    ? ''
                                                    : "${DateFormat("yyyy-MM-dd").format(DateTime.now())} ${selectedStartTime!.format(context).toString()}",
                                                'end_at': EndDate.toString(),
                                                'person_name':
                                                    personNameController.text,
                                                'person_desi':
                                                    personDesignationController
                                                        .text,
                                                'person_mobile':
                                                    personMobileNoController
                                                        .text,
                                                'product_service':
                                                    productServiceID.toString(),
                                                'query_complaint':
                                                    quiryController.text,
                                                'order_done':
                                                    selectedOption.toString(),
                                                'next_visit': selectedDate !=
                                                        null
                                                    ? '${selectedDate.toString().split(' ')[0]} ${selectedTime!.format(context)}'
                                                    : '',
                                                'remark': remarkController.text,
                                                "inq_id": widget.inquiryID,
                                                'location':
                                                    "${ref.lat.value},${ref.lng.value}"
                                              });
                                              request.files.add(
                                                  await http.MultipartFile
                                                      .fromPath('person_image',
                                                          image!.path));
                                              // var result = await ApiBaseHelper()
                                              //     .postAPICall(url, body);
                                              http.StreamedResponse responses =
                                                  await request.send();
                                              var result = await http.Response
                                                  .fromStream(responses);
                                              print(
                                                  "postAPICall Enquiry response " +
                                                      result.body.toString());
                                              setState(() {
                                                formloder = false;
                                              });
                                              if (result.statusCode == 200) {
                                                var responsedata =
                                                    jsonDecode(result.body);
                                                GoRouter.of(context).goNamed(
                                                    routerConst.homeNavBar);
                                                print(
                                                    "Create Enquiry registration " +
                                                        body.toString());
                                                print(
                                                    "Create Enquiry registration " +
                                                        result.body.toString());
                                                toastMsg(
                                                    "${responsedata['message']}",
                                                    false);
                                              } else {
                                                GoRouter.of(context).goNamed(
                                                    routerConst.homeNavBar);
                                                var responsedata =
                                                    jsonDecode(result.body);
                                                toastMsg(
                                                    "${responsedata['message']}",
                                                    false);
                                              }
                                            } else {
                                              toastMsg(
                                                  "Please Select Order is done or not",
                                                  true);
                                            }
                                          } else {
                                            toastMsg(
                                                "Please Select Services", true);
                                          }
                                        } else {
                                          toastMsg("Please Select Image", true);
                                        }
                                      } else {
                                        toastMsg(
                                            "Please Select Start Time", true);
                                      }
                                    } else {
                                      toastMsg("Please Select Client", true);
                                    }
                                  } else {
                                    if (selectedVendorid != null) {
                                      if (selectedStartTime != null) {
                                        if (image != null) {
                                          if (productServiceTypeID != null) {
                                            if (selectedOption != null) {
                                              ref.updateMap();
                                              setState(() {
                                                formloder = true;
                                              });
                                              productServiceID
                                                  .add(productServiceTypeID);

                                              String? userid =
                                                  await secureStorageService
                                                      .getUserID(
                                                          key: StorageKeys
                                                              .userIDKey);
                                              String? usercompanyid =
                                                  await secureStorageService
                                                      .getUserCompanyID(
                                                          key: StorageKeys
                                                              .companyIdKey);
                                              var url =
                                                  Uri.parse(get_visitsave_url);
                                              EndDate = DateFormat("yyyy-MM-dd")
                                                      .format(DateTime.now()) +
                                                  " " +
                                                  DateFormat.Hms()
                                                      .format(DateTime.now());
                                              var body = ({
                                                'user_id': userid,
                                                "company_id": usercompanyid,
                                                'visit_at': 'vendor',
                                                'vendor_id':
                                                    selectedVendorid.toString(),
                                                'start_at': selectedStartTime ==
                                                        null
                                                    ? ''
                                                    : "${DateFormat("yyyy-MM-dd").format(DateTime.now())} ${selectedStartTime!.format(context).toString()}",
                                                'end_at': EndDate.toString(),
                                                'person_name':
                                                    personNameController.text,
                                                'person_desi':
                                                    personDesignationController
                                                        .text,
                                                'person_mobile':
                                                    personMobileNoController
                                                        .text,
                                                'product_service':
                                                    productServiceID.toString(),
                                                'query_complaint':
                                                    quiryController.text,
                                                'order_done': selectedOption,
                                                'next_visit': selectedDate !=
                                                        null
                                                    ? '${selectedDate.toString().split(' ')[0]} ${selectedTime!.format(context)}'
                                                    : '',
                                                'remark': remarkController.text,
                                                "inq_id": widget.inquiryID,
                                                'location':
                                                    "${ref.lat.value},${ref.lng.value}"
                                              });
                                              print("check body : " +
                                                  body.toString());
                                              var request =
                                                  http.MultipartRequest(
                                                      'POST',
                                                      Uri.parse(
                                                          get_visitsave_url));
                                              request.fields.addAll({
                                                'user_id': userid.toString(),
                                                "company_id":
                                                    usercompanyid.toString(),
                                                'visit_at': 'vendor',
                                                'vendor_id':
                                                    selectedVendorid.toString(),
                                                'start_at': selectedStartTime ==
                                                        null
                                                    ? ''
                                                    : "${DateFormat("yyyy-MM-dd").format(DateTime.now())} ${selectedStartTime!.format(context).toString()}",
                                                'end_at': EndDate.toString(),
                                                'person_name':
                                                    personNameController.text,
                                                'person_desi':
                                                    personDesignationController
                                                        .text,
                                                'person_mobile':
                                                    personMobileNoController
                                                        .text,
                                                'product_service':
                                                    productServiceID.toString(),
                                                'query_complaint':
                                                    quiryController.text,
                                                'order_done':
                                                    selectedOption.toString(),
                                                'next_visit': selectedDate !=
                                                        null
                                                    ? '${selectedDate.toString().split(' ')[0]} ${selectedTime!.format(context)}'
                                                    : '',
                                                'remark': remarkController.text,
                                                "inq_id": widget.inquiryID,
                                                'location':
                                                    "${ref.lat.value},${ref.lng.value}"
                                              });
                                              request.files.add(
                                                  await http.MultipartFile
                                                      .fromPath('person_image',
                                                          image!.path));
                                              // var result = await ApiBaseHelper()
                                              //     .postAPICall(url, body);
                                              http.StreamedResponse responses =
                                                  await request.send();
                                              var result = await http.Response
                                                  .fromStream(responses);
                                              print(
                                                  "postAPICall Enquiry response " +
                                                      result.body.toString());
                                              setState(() {
                                                formloder = false;
                                              });

                                              if (result.statusCode == 200) {
                                                var responsedata =
                                                    jsonDecode(result.body);
                                                print(
                                                    "Create Enquiry registration " +
                                                        body.toString());
                                                print(
                                                    "Create Enquiry registration " +
                                                        result.body.toString());
                                                GoRouter.of(context).goNamed(
                                                    routerConst.homeNavBar);
                                                toastMsg(
                                                    "${responsedata['message']}",
                                                    false);
                                              } else {
                                                var responsedata =
                                                    jsonDecode(result.body);
                                                Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            HomeNavBar()
                                                        //logIN==true?BottomBar() :LoginScreen()
                                                        ));
                                                toastMsg(
                                                    "${responsedata['message']}",
                                                    false);
                                              }
                                            } else {
                                              toastMsg(
                                                  "Please Select Order is done or not",
                                                  true);
                                            }
                                          } else {
                                            toastMsg(
                                                "Please Select Services", true);
                                          }
                                        } else {
                                          toastMsg("Please Select Image", true);
                                        }
                                      } else {
                                        toastMsg(
                                            "Please Select Start Time", true);
                                      }
                                    } else {
                                      toastMsg("Please Select Vendor", true);
                                    }
                                  }
                                } else {
                                  toastMsg("Please Select Visit Type", true);
                                }
                              }
                            },
                      child: Container(
                        alignment: Alignment.center,
                        height: size.height * 0.073,
                        width: size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: blueColor,
                        ),
                        child: Text(
                          formloder == true ? "Please wait.." : "End Visit",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: size.height * 0.020,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  }),
                  SizedBox(
                    height: 30.h,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
