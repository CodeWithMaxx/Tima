import 'dart:convert';
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:tima_app/ApiService/postApiBaseHelper.dart';
import 'package:tima_app/DataBase/dataHub/secureStorageService.dart';
import 'package:tima_app/DataBase/keys/keys.dart';
import 'package:tima_app/core/constants/apiUrlConst.dart';
import 'package:tima_app/feature/drawerPage/inquiry/createInquiry/screen/createInqueryPage.dart';
import 'package:tima_app/providers/LocationProvider/location_provider.dart';

abstract class CreateInquiryController extends State<CreateInquiry> {
  GlobalKey<FormState> creatformkey = GlobalKey<FormState>();
  LocationProvider locationProvider = LocationProvider();
  SecureStorageService secureStorageService = SecureStorageService();
  final clientNameController = TextEditingController();
  final contactPersonController = TextEditingController();
  final contactNoController = TextEditingController();
  final currentVendorController = TextEditingController();
  final currentPriceController = TextEditingController();
  final targetBussinessController = TextEditingController();
  final remarkController = TextEditingController();

  List person = [];
  List enquiryType = [];
  List productserviceType = [];
  List branches = [];
  var personid = "0";
  var enquiryTypeid;
  var productserviceTypeid;
  var branchesid;
  var userLogedin_id;
  String? userID;
  var inquiryTypeid;

  @override
  void initState() {
    super.initState();
    clearControllersData();
    // getInquiryTypeCallApi();
    // getBranchesCall();
    // getProductServices();
  }

  clearControllersData() async {
    locationProvider.updateMap();
    userID = await secureStorageService.getUserID(key: StorageKeys.userIDKey);

    setState(() {
      // userID;
      clientNameController.clear();
      contactPersonController.clear();
      contactNoController.clear();
      currentVendorController.clear();
      currentPriceController.clear();
      targetBussinessController.clear();
      remarkController.clear();
      person = [];
      enquiryType = [];
      productserviceType = [];
      branches = [];
      personid = "0";
      inquiryTypeid = null;
      productserviceTypeid = null;
      branchesid = null;
      getInquiryTypeCallApi();
      getBranchesCall();
      getProductServices();
    });
  }

  getInquiryTypeCallApi() async {
    String? companyID = await secureStorageService.getUserCompanyID(
        key: StorageKeys.companyIdKey);
    var url = getenquirytype_url;
    var body = ({'id': '0', 'company': companyID});

    var result = await ApiBaseHelper().postAPICall(Uri.parse(url), body);
    if (result.statusCode == 200) {
      var responsedata = jsonDecode(result.body);
      if (responsedata['status'] == 1) {
        enquiryType.addAll(responsedata['data']);
      }
      // setState(() {

      //   log("enquiryType : $enquiryType");
      // });
    }
  }

  getBranchesCall() async {
    String? companyID = await secureStorageService.getUserCompanyID(
        key: StorageKeys.companyIdKey);
    var url = getbranchestype_url;
    var body = ({'company_id': companyID, 'branch_id': '0'});

    var result = await ApiBaseHelper().postAPICall(Uri.parse(url), body);
    if (result.statusCode == 200) {
      var responsedata = jsonDecode(result.body);
      setState(() {
        branches.addAll(responsedata['data']);
        log("branches : $branches ");
      });
    }
  }

  getUserCall(String branchid) async {
    person.clear();
    personid = '';
    var url = getusers_url;
    var body =
        ({'company_id': '1', 'branch_id': branchid.toString(), 'user_id': "0"});
    log("person body: $body");
    var result = await ApiBaseHelper().postAPICall(Uri.parse(url), body);
    if (result.statusCode == 200) {
      var responsedata = jsonDecode(result.body);
      setState(() {
        var firstdata = [
          {
            "user_id": "0",
            "name": "--Select User--",
            "city_name": "Jodhpur",
            "state_name": "Rajasthan"
          }
        ];
        person.addAll(firstdata);

        person.addAll(responsedata['data']);
        log("person 1 --> $person");
        person.removeWhere((element) => element['user_id'] == userID);
        log("person 2--> $person");
        personid = person[0]["user_id"];
        log("person : $person");
      });
    }
  }

  getProductServices() async {
    setState(() {
      productserviceType.clear();
    });
    String? companyID = await secureStorageService.getUserCompanyID(
        key: StorageKeys.companyIdKey);

    var url = Uri.parse(product_service_url);
    var body = ({'type': 'product', "company_id": companyID, 'id': '0'});
    var result = await ApiBaseHelper().postAPICall(url, body);
    if (result.statusCode == 200) {
      var responsedata = jsonDecode(result.body);
      if (responsedata['status'] == 1) {
        productserviceType.addAll(responsedata['data']);
      }

      //----service----//
      var url = Uri.parse(product_service_url);
      var bodys = ({'type': 'service', "company_id": companyID, 'id': '0'});
      var results = await ApiBaseHelper().postAPICall(url, bodys);
      var responsedatas = jsonDecode(results.body);
      if (results.statusCode == 200) {
        if (responsedatas['status'] == 1) {
          setState(() {
            productserviceType.addAll(responsedatas['data']);
          });
        }
      }
    }
  }
}
