import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tima_app/Admin/screen/requestAdmin.dart';
import 'package:tima_app/ApiService/postApiBaseHelper.dart';
import 'package:tima_app/DataBase/dataHub/secureStorageService.dart';
import 'package:tima_app/DataBase/keys/keys.dart';
import 'package:tima_app/core/constants/apiUrlConst.dart';
import 'package:tima_app/providers/LocationProvider/location_provider.dart';

abstract class AdminController extends State<RequestAdmin> {
  SecureStorageService secureStorageService = SecureStorageService();
  bool formloder = false;
  String? selectedOption;
  int selectedIndex = 2;
  int selectedRadioTile = 1;
  String? selectedClientid;
  String? selectedVendorid;
  var StartDate;
  var EndDate;
  final clientController = TextEditingController();
  final vendorController = TextEditingController();
  final personNameController = TextEditingController();
  final personDesignationController = TextEditingController();
  final personMobileNoController = TextEditingController();
  final quiryController = TextEditingController();
  final remarkController = TextEditingController();

  var productServiceTypeID;
  List productServiceType = [];

  List ClientList = [];
  List VendorList = [];
  LocationProvider locationProvider = LocationProvider();

  bool isShowUi = false;
  bool isShowUi2 = false;
  @override
  void initState() {
    super.initState();
    locationProvider.updateMap();

    getClientFromApi();
    getVendorFromApi();
    getProductService();
  }

  getProductService() async {
    setState(() {
      productServiceType.clear();
    });

    var url = Uri.parse(product_service_url);
    var companyID =
        await secureStorageService.getUserID(key: StorageKeys.userIDKey);
    var body = ({'type': 'product', "company_id": companyID, 'id': '0'});
    var result = await ApiBaseHelper().postAPICall(url, body);
    if (result.statusCode == 200) {
      var responsedata = jsonDecode(result.body);
      if (responsedata['status'] == 1) {
        productServiceType.addAll(responsedata['data']);
      }

      //----service----//
      var url = Uri.parse(product_service_url);
      var bodys = ({'type': 'service', "company_id": companyID, 'id': '0'});
      var results = await ApiBaseHelper().postAPICall(url, bodys);
      var responsedatas = jsonDecode(results.body);
      if (results.statusCode == 200) {
        if (responsedatas['status'] == 1) {
          setState(() {
            productServiceType.addAll(responsedatas['data']);
          });
        }
      }
    }
  }

  setSelectedRadioTile(int val) {
    setState(() {
      selectedRadioTile = val;
      isShowUi = false;
      isShowUi2 = false;
    });
  }

  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  TimeOfDay? selectedStartTime;

  Future<void> selectDateByUser(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  Future<void> selectTimeByUser(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        selectedTime = pickedTime;
      });
    }
  }

  Future<void> selectStartTimeByUser(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        selectedStartTime = pickedTime;
      });
    }
  }

  getClientFromApi() async {
    var url = get_client_data_url;
    String? companyID = await secureStorageService.getUserCompanyID(
        key: StorageKeys.companyIdKey);
    String? userID =
        await secureStorageService.getUserID(key: StorageKeys.userIDKey);
    var body = ({
      'id': '0',
      "company_id": companyID,
      "user_id": userID,
    });
    ClientList.clear();
    var result = await ApiBaseHelper().postAPICall(Uri.parse(url), body);
    if (result.statusCode == 200) {
      var responsedata = jsonDecode(result.body);
      setState(() {
        ClientList.addAll(responsedata['data']);
        log("ClientList : $ClientList");
      });
    }
  }

  getVendorFromApi() async {
    String? companyID = await secureStorageService.getUserCompanyID(
        key: StorageKeys.companyIdKey);
    String? userID =
        await secureStorageService.getUserID(key: StorageKeys.userIDKey);
    var url = get_vendor_data_url;
    var body = ({
      'id': '0',
      "company_id": companyID,
      "user_id": userID,
    });
    VendorList.clear();
    var result = await ApiBaseHelper().postAPICall(Uri.parse(url), body);
    if (result.statusCode == 200) {
      var responsedata = jsonDecode(result.body);
      setState(() {
        VendorList.addAll(responsedata['data']);
        log("VendorList : $VendorList ");
      });
    }
  }

  File? image;

  Future<void> pickeImageByUser() async {
    final pickedImage = await ImagePicker().pickImage(
        source: ImageSource.camera,
        imageQuality: 50,
        maxWidth: 800,
        maxHeight: 600);
    if (pickedImage != null) {
      setState(() {
        image = File(pickedImage.path);
      });
    }
  }
}
