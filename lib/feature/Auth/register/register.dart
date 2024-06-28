// ignore_for_file: must_be_immutable, non_constant_identifier_names, prefer_typing_uninitialized_variables
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:provider/provider.dart';
import 'package:tima_app/ApiService/postApiBaseHelper.dart';
import 'package:tima_app/DataBase/dataHub/secureStorageService.dart';
import 'package:tima_app/DataBase/keys/keys.dart';
import 'package:tima_app/core/GWidgets/customButton.dart';
import 'package:tima_app/core/GWidgets/textfieldsStyle.dart';
import 'package:tima_app/core/constants/apiUrlConst.dart';
import 'package:tima_app/core/constants/colorConst.dart';
import 'package:tima_app/core/constants/formValidation.dart';
import 'package:tima_app/core/constants/textconst.dart';
import 'package:tima_app/feature/Auth/register/registerController.dart';
import 'package:tima_app/providers/LocationProvider/location_provider.dart';
import 'package:tima_app/router/routes/routerConst.dart';

class RegisterScreen extends StatefulWidget {
  var inquryID;
  RegisterScreen({super.key, this.inquryID});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends RegisterController {
  GlobalKey<FormState> registerkey = GlobalKey<FormState>();
  final SecureStorageService _secureStorageService = SecureStorageService();
  var selectedRadioTile;
  late LocationProvider locationProvider;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    locationProvider = LocationProvider();
    locationProvider.updateMap();
    setState(() {
      locationController = TextEditingController(
          text:
              "${locationProvider.lat.value} , ${locationProvider.lng.value}");
      addressController =
          TextEditingController(text: locationProvider.address.value);
      selectedRadioTile = 1;

      addpersondetail();
    });
    clientVendorRegistration();
    getStateFromApi();
    getProdcutServicesFromApi();
    getServices();
  }

  setSelectedRadioTile(int val) {
    setState(() {
      selectedRadioTile = val;
    });
  }

  addpersondetail() {
    setState(() {
      final startcontroller = TextEditingController();
      final endcontroller = TextEditingController();
      final emailcontroller = TextEditingController();
      final fiels1 = TextFormField(
        cursorColor: Colors.grey,
        enableInteractiveSelection: true,
        // onTap: () async {

        // },
        style: const TextStyle(
          color: Colors.black,
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.2,
        ),
        decoration: InputDecoration(
          hintText: "Contact Person",
          labelText: "Contact Person${startController.length + 1}",
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 14.0,
            fontWeight: FontWeight.w300,
            fontStyle: FontStyle.normal,
            letterSpacing: 0.2,
          ),
          isDense: true,
          errorStyle: const TextStyle(
            color: Colors.red,
            fontSize: 12.0,
            fontWeight: FontWeight.w300,
            letterSpacing: 1.2,
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
        ),
        controller: startcontroller,
        readOnly: false,
        validator: ((value) {
          if (value == null || value == '') {
            return "Contact person Required";
          } else {
            return null;
          }
        }),
      );
      final fiels2 = TextFormField(
        cursorColor: Colors.grey,
        enableInteractiveSelection: false,
        maxLength: 10,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        // onTap: () async {

        // },
        style: const TextStyle(
          color: Colors.black,
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.2,
        ),
        decoration: InputDecoration(
          hintText: "Contact Mobile",
          labelText: "Contact Mobile${endController.length + 1}",
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          counterText: "",
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 14.0,
            fontWeight: FontWeight.w300,
            fontStyle: FontStyle.normal,
            letterSpacing: 0.2,
          ),
          isDense: true,
          errorStyle: const TextStyle(
            color: Colors.red,
            fontSize: 12.0,
            fontWeight: FontWeight.w300,
            letterSpacing: 1.2,
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
        ),
        controller: endcontroller,
        validator: ((value) {
          if (value == null || value == '') {
            return "Contact Number Required";
          } else {
            return null;
          }
        }),
      );
      final fiels3 = TextFormField(
        cursorColor: Colors.grey,
        enableInteractiveSelection: false,
        // onTap: () async {
        // },
        style: TextStyle(
          color: Colors.black,
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.2,
        ),
        decoration: const InputDecoration(
          hintText: "Contact Email",
          // labelText: "Contact Email${emailcontroller.length + 1}",
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 14.0,
            fontWeight: FontWeight.w300,
            letterSpacing: 0.2,
          ),
          isDense: true,
          errorStyle: TextStyle(
            color: Colors.red,
            fontSize: 12.0,
            fontWeight: FontWeight.w300,
            fontStyle: FontStyle.normal,
            letterSpacing: 1.2,
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
        ),
        controller: emailcontroller,
        validator: form_validation.validateEmail,
      );

      final field = TextField(
        controller: endcontroller,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          // labelText: "name${_emailcontrollers.length + 1}",
        ),
      );

      setState(() {
        startController.add(startcontroller);
        endController.add(endcontroller);
        emailcontrollers.add(emailcontroller);
        fields1.add(fiels1);
        log("_field" + fields1.length.toString());
        fields2.add(fiels2);
        fields3.add(fiels3);
        fields.add(field);
      });
    });
  }

  Widget _addTile() {
    return ListTile(
      title: Container(
        height: 60,
        width: 290,
        decoration: BoxDecoration(
          border: Border.all(
            color: colorConst.primarycolor,
          ),
          borderRadius: BorderRadius.circular(100.0),
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.add),
            Center(
              child: Text(
                'Add Contact',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: colorConst.primarycolor,
                ),
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        final startcontroller = TextEditingController();
        final endcontroller = TextEditingController();
        final emailcontroller = TextEditingController();
        final fiels1 = TextFormField(
          cursorColor: Colors.grey,
          enableInteractiveSelection: true,
          // onTap: () async {

          // },
          style: TextStyle(
            color: Colors.black,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.normal,
            letterSpacing: 0.2,
          ),
          decoration: InputDecoration(
            hintText: "Contact Person",
            labelText: "Contact Person${startController.length + 1}",
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            hintStyle: const TextStyle(
              color: Colors.grey,
              fontSize: 14.0,
              fontWeight: FontWeight.w300,
              fontStyle: FontStyle.normal,
              letterSpacing: 0.2,
            ),
            isDense: true,
            errorStyle: TextStyle(
              color: Colors.grey,
              fontSize: 12.0,
              fontWeight: FontWeight.w300,
              fontStyle: FontStyle.normal,
              letterSpacing: 1.2,
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
          ),
          controller: startcontroller,
          readOnly: false,
          validator: ((value) {
            if (value == null || value == '') {
              return "Contact person Required";
            } else {
              return null;
            }
          }),
        );
        final fiels2 = TextFormField(
          cursorColor: Colors.grey,
          enableInteractiveSelection: false,
          maxLength: 10,
          keyboardType: TextInputType.number,

          // validator: form_validation().validatephonenumber,
          // onTap: () async {

          // },
          style: TextStyle(
            color: Colors.black,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.normal,
            letterSpacing: 0.2,
          ),
          decoration: InputDecoration(
            hintText: "Contact Mobile",
            counterText: "",
            labelText: "Contact Mobile${endController.length + 1}",
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            hintStyle: const TextStyle(
              color: Colors.grey,
              fontSize: 14.0,
              fontWeight: FontWeight.w300,
              fontStyle: FontStyle.normal,
              letterSpacing: 0.2,
            ),
            isDense: true,
            errorStyle: TextStyle(
              color: Colors.grey,
              fontSize: 12.0,
              fontWeight: FontWeight.w300,
              fontStyle: FontStyle.normal,
              letterSpacing: 1.2,
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
          ),
          controller: endcontroller,
          validator: ((value) {
            if (value == null || value == '') {
              return "Contact Number Required";
            } else {
              return null;
            }
          }),
        );
        final fiels3 = TextFormField(
          cursorColor: Colors.grey,
          enableInteractiveSelection: false,
          style: TextStyle(
            color: Colors.black,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.normal,
            letterSpacing: 0.2,
          ),
          decoration: InputDecoration(
            hintText: "Contact Email",
            labelText: "Contact Email${emailcontrollers.length + 1}",
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            hintStyle: const TextStyle(
              color: Colors.grey,
              fontSize: 14.0,
              fontWeight: FontWeight.w300,
              fontStyle: FontStyle.normal,
              letterSpacing: 0.2,
            ),
            isDense: true,
            errorStyle: TextStyle(
              color: Colors.grey,
              fontSize: 12.0,
              fontWeight: FontWeight.w300,
              fontStyle: FontStyle.normal,
              letterSpacing: 1.2,
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
          ),
          controller: emailcontroller,
          validator: form_validation.validateEmail,
        );
        final field = TextField(
          controller: endcontroller,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: "name${emailcontrollers.length + 1}",
          ),
        );

        setState(() {
          startController.add(startcontroller);
          endController.add(endcontroller);
          emailcontrollers.add(emailcontroller);
          fields1.add(fiels1);
          log("_field--> ${fields1.length}");
          fields2.add(fiels2);
          fields3.add(fiels3);
          fields.add(field);
        });
      },
    );
  }

  Widget _listView() {
    return ListView.builder(
      itemCount: fields.length,
      // itemCount: 1,
      scrollDirection: Axis.vertical,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Container(
          // color: Colors.red,
          margin: EdgeInsets.all(5),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    log("startController : " + index.toString());
                    startController.removeAt(index);
                    endController.removeAt(index);
                    emailcontrollers.removeAt(index);
                    fields1.removeAt(index);
                    fields2.removeAt(index);
                    fields3.removeAt(index);
                    fields.removeAt(index);
                  });
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.delete_forever,
                        color: Colors.red,
                      ),
                    ),
                    Text(
                      "Remove",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              fields1[index],
              SizedBox(height: 20),
              fields2[index],
              SizedBox(height: 15),
              fields3[index],
              SizedBox(height: 15),
              // _fields[index],
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor: colorConst.backgroundcolor,

      body: Consumer<LocationProvider>(builder: (_, ref, __) {
        return SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            margin:
                const EdgeInsets.only(left: 16, right: 16, top: 20, bottom: 40),
            child: Form(
              key: registerkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30.h,
                  ),
                  Center(
                      child: txtHelper()
                          .heading1Text('REGISTERATION', 23, blueColor)),
                  SizedBox(
                    height: 30.h,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    height: 40,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
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
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            onChanged: (dynamic val) async {
                              setSelectedRadioTile(val);

                              nameController.clear();
                              emailController.clear();
                              mobileController.clear();
                              pinController.clear();
                              webController.clear();
                              addressController.clear();
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
                                    fontSize: 16, fontWeight: FontWeight.w500)),
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
                    height: 30.h,
                  ),
                  Text(
                    'Organization Name',
                    style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: blueColor),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 5),
                    alignment: Alignment.centerLeft,
                    // height: 50.h,
                    width: size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: tfColor),
                    child: TextFormField(
                      controller: nameController,
                      validator: form_validation.validatename,
                      decoration: InputDecoration(
                        prefixIcon: Icon(CupertinoIcons.building_2_fill),
                        hintText: "Organization Name",
                        border: InputBorder.none,
                        // focusedBorder: focusboarder,
                        // errorBorder: errorboarder,
                      ),
                      onChanged: (text) {
                        setState(() {
                          if (text.length > 0) {
                            errororgname = true;
                          }
                        });
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
                    height: 12.h,
                  ),
                  Text(
                    'Email',
                    style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: blueColor),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),

                  Container(
                    padding: const EdgeInsets.only(left: 5),
                    alignment: Alignment.centerLeft,
                    // height: 50.h,
                    width: size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: tfColor),
                    child: TextFormField(
                      controller: emailController,
                      validator: form_validation.validateEmail,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        counterText: "",
                        hintText: "Email *",
                        border: InputBorder.none,
                        // focusedBorder: focusboarder,
                        // errorBorder: errorboarder,
                      ),
                      onChanged: (text) {
                        setState(() {
                          if (text.length > 0) {
                            erroremail = true;
                          }
                        });
                      },
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  Text(
                    'Mobile Number',
                    style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: blueColor),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),

                  Container(
                    padding: const EdgeInsets.only(left: 5),
                    alignment: Alignment.centerLeft,
                    // height: 50.h,
                    width: size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: tfColor),
                    child: TextFormField(
                      controller: mobileController,
                      validator: form_validation.validatephonenumber,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.phone),
                        counterText: "",
                        hintText: "Mobile Number *",
                        border: InputBorder.none,
                        // focusedBorder: focusboarder,
                        // errorBorder: errorboarder,
                      ),
                      onChanged: (text) {
                        setState(() {
                          if (text.length > 0) {
                            errormobile = true;
                          }
                        });
                      },
                      maxLength: 10,
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                          fontFamily: 'Barlow',
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  Text(
                    'Select State',
                    style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: blueColor),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    // height: 55.h,
                    width: size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: tfColor),
                    child: DropdownButtonFormField(
                      validator: form_validation.validatestate,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        // focusedBorder: focusboarder,
                        // errorBorder: errorboarder,
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey),
                        hintText: "Select State",

                        fillColor: tfColor,
                        // prefixIcon: Icon(Icons.language),
                      ),
                      value: selcectState,
                      onChanged: (value) {
                        setState(() {
                          selcectState = value;
                          selectCity = null;
                        });
                        log("selectedstateId--->" + selectedstateId.toString());

                        if (selectedstateId.isEmpty) {
                          selectedstateId = '';
                        } else {
                          getCityFromApi(selectedstateId);
                        }
                      },
                      items: States.map((explist) {
                        return DropdownMenuItem(
                          value: explist['state_name'].toString(),
                          child: Text(
                            explist['state_name'].toString(),
                          ),
                          onTap: () {
                            selectedstateId = explist['id'].toString();
                            log("selectedstateId--->" +
                                selectedstateId.toString());
                          },
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  Text(
                    'Select City',
                    style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: blueColor),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    // height: 55.h,
                    width: size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: tfColor),
                    child: DropdownButtonFormField(
                      validator: form_validation.validatecity,
                      decoration: InputDecoration(
                        border: InputBorder.none,

                        // focusedBorder: focusboarder,
                        // errorBorder: errorboarder,
                        filled: true,
                        hintStyle: const TextStyle(color: Colors.grey),
                        hintText: "Select City",
                        labelStyle: TextStyle(color: Colors.grey.shade600),
                        fillColor: tfColor,
                        // prefixIcon: Icon(Icons.language),
                      ),
                      value: selectCity,
                      onChanged: (value) {
                        setState(() {
                          selectCity = value;
                        });
                        if (selectCityID == 0) {
                          selectCityID = null;
                        }
                      },
                      items: City.map((explist) {
                        return DropdownMenuItem(
                          value: explist['city_name'].toString(),
                          child: Text(
                            explist['city_name'].toString(),
                          ),
                          onTap: () {
                            selectCityID = explist['id'].toString();
                          },
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  Text(
                    'Pin Code',
                    style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: blueColor),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),

                  Container(
                    padding: const EdgeInsets.only(left: 5),
                    alignment: Alignment.centerLeft,
                    // height: 50.h,
                    width: size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: tfColor),
                    child: TextFormField(
                      controller: pinController,
                      // validator: form_validation().validatepincode,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.pin),
                        counterText: "",
                        hintText: "Pin",
                        border: InputBorder.none,
                        // focusedBorder: focusboarder,
                        // errorBorder: errorboarder,
                      ),
                      maxLength: 10,
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  Text(
                    'Web',
                    style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: blueColor),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 5),
                    alignment: Alignment.centerLeft,
                    // height: 50.h,
                    width: size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: tfColor),
                    child: TextFormField(
                      controller: webController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.web),
                        counterText: "",
                        hintText: "Web",
                        border: InputBorder.none,
                        focusedBorder: focusboarder,
                        errorBorder: errorboarder,
                      ),
                      // maxLength: 10,
                      // keyboardType: TextInputType.number,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Text(
                    'Select Products',
                    style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: blueColor),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    width: size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: tfColor),
                    child: MultiSelectFormField(
                      autovalidate: AutovalidateMode.disabled,
                      chipBackGroundColor: colorConst.primarycolor,
                      chipLabelStyle: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                      dialogTextStyle:
                          const TextStyle(fontWeight: FontWeight.bold),
                      checkBoxActiveColor: colorConst.primarycolor,
                      checkBoxCheckColor: tfColor,
                      dialogShapeBorder: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(12.0))),
                      title: const Text(
                        "Select Product",
                        style: TextStyle(fontSize: 16),
                      ),
                      validator: (value) {
                        if (value == null || value.length == 0) {
                          return null;
                        }
                        return null;
                      },
                      dataSource: AllLanguageServicesData,
                      textField: 'name',
                      valueField: 'id',
                      okButtonLabel: 'OK',
                      cancelButtonLabel: 'CANCEL',
                      hintWidget: Text('Please choose one or more Product'),
                      initialValue: AllLanguageServices,
                      onSaved: (value) {
                        if (value == null) return;
                        setState(() {
                          AllLanguageServices = value;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  Text(
                    'Select Service',
                    style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: blueColor),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    width: size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: tfColor),
                    child: MultiSelectFormField(
                      autovalidate: AutovalidateMode.disabled,
                      chipBackGroundColor: colorConst.primarycolor,
                      chipLabelStyle: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                      dialogTextStyle:
                          const TextStyle(fontWeight: FontWeight.bold),
                      checkBoxActiveColor: colorConst.primarycolor,
                      checkBoxCheckColor: Colors.white,
                      dialogShapeBorder: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(12.0))),
                      title: const Text(
                        "Select Service",
                        style: TextStyle(fontSize: 16),
                      ),
                      validator: (value) {
                        if (value == null || value.length == 0) {
                          return null;
                        }
                        return null;
                      },
                      dataSource: AllServicesData,
                      textField: 'name',
                      valueField: 'id',
                      okButtonLabel: 'OK',
                      cancelButtonLabel: 'CANCEL',
                      hintWidget:
                          const Text('Please choose one or more Service'),
                      initialValue: AllServices,
                      onSaved: (value) {
                        if (value == null) return;
                        setState(() {
                          AllServices = value;
                        });
                      },
                    ),
                  ),

                  SizedBox(
                    height: 15.h,
                  ),
                  Text(
                    'Location',
                    style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: blueColor),
                  ),
                  SizedBox(
                    height: 12.h,
                  ),

                  Container(
                    padding: const EdgeInsets.only(left: 5),
                    alignment: Alignment.centerLeft,
                    // height: 50.h,
                    width: size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: tfColor),
                    child: TextFormField(
                      controller: locationController,
                      readOnly: true,

                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.location_city),
                        counterText: "",
                        hintText: "Location *",
                        border: InputBorder.none,
                      ),
                      onChanged: (text) {
                        setState(() {
                          if (text.length > 0) {
                            erroelocation = true;
                          }
                        });
                      },
                      // maxLength: 10,
                      // keyboardType: TextInputType.number,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        ref.updateMap();
                        locationController = TextEditingController(
                            text: "${ref.lat.value} , ${ref.lng.value}");
                        addressController =
                            TextEditingController(text: ref.address.value);
                      },
                      icon: const Icon(Icons.location_searching),
                      label: const Text(
                        "Get Location",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(backgroundColor: tfColor),
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Text(
                    'Address',
                    style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: blueColor),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 5),
                    alignment: Alignment.centerLeft,
                    height: 70,
                    width: size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: tfColor),
                    child: TextFormField(
                      readOnly: true,
                      controller: addressController,
                      validator: form_validation.validateaddress,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.home),
                        counterText: "",
                        hintText: "Address *",
                        border: InputBorder.none,
                      ),
                      onChanged: (text) {
                        setState(() {
                          if (text.length > 0) {
                            erroradd = true;
                          }
                        });
                      },
                      maxLines: 3,
                      keyboardType: TextInputType.text,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  _listView(),
                  // _addTile(),
                  ListTile(
                    title: Container(
                      height: 60,
                      width: 290,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: colorConst.primarycolor,
                        ),
                        borderRadius: BorderRadius.circular(100.0),
                        color: Colors.white,
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.add),
                          Center(
                            child: Text(
                              'Add Contact',
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                                color: colorConst.primarycolor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      final startcontroller = TextEditingController();
                      final endcontroller = TextEditingController();
                      final emailcontroller = TextEditingController();
                      final fiels1 = TextFormField(
                        cursorColor: Colors.grey,
                        enableInteractiveSelection: true,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.2,
                        ),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Contact Person",
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w300,
                            fontStyle: FontStyle.normal,
                            letterSpacing: 0.2,
                          ),
                          isDense: true,
                          errorStyle: TextStyle(
                            color: Colors.red,
                            fontSize: 12.0,
                            fontWeight: FontWeight.w300,
                            letterSpacing: 1.2,
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        ),
                        controller: startcontroller,
                        readOnly: false,
                        validator: ((value) {
                          if (value == null || value == '') {
                            return "Contact person Required";
                          } else {
                            return null;
                          }
                        }),
                      );
                      final fiels2 = TextFormField(
                        cursorColor: Colors.grey,
                        enableInteractiveSelection: false,
                        maxLength: 10,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        // validator: form_validation().validatephonenumber,
                        onTap: () async {},
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.normal,
                          letterSpacing: 0.2,
                        ),
                        decoration: InputDecoration(
                          hintText: "Contact Mobile",
                          counterText: "",
                          labelText:
                              "Contact Mobile${endController.length + 1}",
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          hintStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w300,
                            fontStyle: FontStyle.normal,
                            letterSpacing: 0.2,
                          ),
                          isDense: true,
                          errorStyle: const TextStyle(
                            color: Colors.red,
                            fontSize: 12.0,
                            fontWeight: FontWeight.w300,
                            letterSpacing: 1.2,
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        ),
                        controller: endcontroller,
                        validator: ((value) {
                          if (value == null || value == '') {
                            return "Contact Number Required";
                          } else {
                            return null;
                          }
                        }),
                      );
                      final fiels3 = TextFormField(
                        cursorColor: Colors.grey,
                        enableInteractiveSelection: false,
                        onTap: () async {},
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.2,
                        ),
                        decoration: InputDecoration(
                          hintText: "Contact Email",
                          labelText:
                              "Contact Email${emailcontrollers.length + 1}",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          hintStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w300,
                            fontStyle: FontStyle.normal,
                            letterSpacing: 0.2,
                          ),
                          isDense: true,
                          errorStyle: const TextStyle(
                            color: Colors.red,
                            fontSize: 12.0,
                            fontWeight: FontWeight.w300,
                            letterSpacing: 1.2,
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        ),
                        controller: emailcontroller,
                        validator: form_validation.validateEmail,
                      );
                      final field = TextField(
                        controller: endcontroller,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: "name${emailcontrollers.length + 1}",
                        ),
                      );

                      setState(() {
                        startController.add(startcontroller);
                        endController.add(endcontroller);
                        emailcontrollers.add(emailcontroller);
                        fields1.add(fiels1);
                        log("_field--> ${fields1.length}");
                        fields2.add(fiels2);
                        fields3.add(fiels3);
                        fields.add(field);
                      });
                    },
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  appButton(
                      onPressed: () async {
                        ref.updateMap();
                        // bool validemail;
                        log("AllServices--> $AllServices");

                        try {
                          if (registerkey.currentState!.validate()) {
                            log("AllLanguageServices--> $AllLanguageServices");

                            startController
                                .where((element) => element.text != "")
                                .fold("", (previousValue, element) {
                              arrayList1.add(element.text);
                              return '';
                            });
                            emailcontrollers
                                .where((element) => element.text != "")
                                .fold("", (previousValue, element) {
                              arrayListmail.add(element.text);
                              return '';
                            });
                            endController
                                .where((element) => element.text != "")
                                .fold("", (previousValue, element) {
                              arrayListmobile.add(element.text);
                              return '';
                            });
                            var url;
                            if (selectedRadioTile == 1) {
                              url = Uri.parse(client_reg_url.toString());
                            } else {
                              url = Uri.parse(vender_reg_url.toString());
                            }
                            String? companyID =
                                await _secureStorageService.getUserCompanyID(
                                    key: StorageKeys.companyIdKey);

                            var userID = await _secureStorageService.getUserID(
                                key: StorageKeys.userIDKey);
                            var body = ({
                              "company_id": companyID,
                              'user_id': userID,
                              "org_name": nameController.text,
                              "address": addressController.text,
                              "city": selectCityID,
                              "pin": pinController.text,
                              "state": selectedstateId,
                              "contact_no": "8852911910",
                              "mobile": mobileController.text,
                              "web": webController.text,
                              "email": emailController.text,
                              "inq_id": widget.inquryID,
                              "location": "${ref.lat.value},${ref.lng.value}",
                              'products':
                                  '${AllLanguageServices.length == 0 ? "" : jsonEncode(AllLanguageServices)}',
                              'services':
                                  '${AllServices.length == 0 ? "" : jsonEncode(AllServices)}',
                              'contact_person': '${jsonEncode(arrayList1)}',
                              'contact_mobile':
                                  '${jsonEncode(arrayListmobile)}',
                              'contact_email': '${jsonEncode(arrayListmail)}'
                            });
                            log("boss-----" +
                                jsonEncode(arrayList1).toString());
                            log("boss-----" +
                                jsonEncode(arrayListmail).toString());
                            log("boss-----" +
                                jsonEncode(arrayListmobile).toString());
                            log("client registration " + body.toString());
                            var result =
                                await ApiBaseHelper().postAPICall(url, body);
                            if (result.statusCode == 200) {
                              var responsedata = jsonDecode(result.body);

                              log("client registration " +
                                  result.body.toString());
                              Fluttertoast.showToast(
                                  msg: responsedata['message']);
                              nameController.clear();
                              emailController.clear();
                              mobileController.clear();
                              pinController.clear();
                              webController.clear();
                              addressController.clear();
                              startController.clear();
                              endController.clear();
                              emailcontrollers.clear();
                              fields1.clear();
                              fields2.clear();
                              fields3.clear();
                              timefields1.clear();
                              timefields2.clear();
                              fields.clear();
                              GoRouter.of(context)
                                  .pushNamed(routerConst.homeNavBar);
                            }
                            // Registration();
                            // if(registerkey.currentState.validate()){
                            //
                            // }
                          } else {
                            log("ok not");
                          }
                        } catch (e) {
                          log("exception : $e");
                        }
                      },
                      text: 'Submit',
                      height: 50,
                      width: double.infinity),
                  //     child:  CustomRichText(text: "Already Have An Account ?",text2: "Login",)),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
