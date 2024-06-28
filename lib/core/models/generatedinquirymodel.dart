// To parse this JSON data, do
//
//     final generatedInquiryModel = generatedInquiryModelFromJson(jsonString);

import 'dart:convert';

GeneratedInquiryModel generatedInquiryModelFromJson(String str) =>
    GeneratedInquiryModel.fromJson(json.decode(str));

String generatedInquiryModelToJson(GeneratedInquiryModel data) =>
    json.encode(data.toJson());

class GeneratedInquiryModel {
  int? status;
  String? message;
  List<Datum>? data;

  GeneratedInquiryModel({
    this.status,
    this.message,
    this.data,
  });

  factory GeneratedInquiryModel.fromJson(Map<String, dynamic> json) =>
      GeneratedInquiryModel(
        status: json["status"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  final String id;
  DateTime? dateTime;
  final String userId;
  final String userName;
  final String userBranch;
  final String userMobile;
  final String userEmail;
  final String enqTypeId;
  final String enqTypeName;
  final String branchId;
  final String branchName;
  final String branchCity;
  final String personId;
  final String personName;
  final String personMobile;
  final String personEmail;
  final String productServiceId;
  final String productServiceType;
  final String productServiceName;
  final String client;
  final String contactPerson;
  final String contactNo;
  final String currentVendor;
  final String currentPrice;
  final String targetBusiness;
  final String remark;
  final String opStatus;
  final String clientId;
  dynamic vendorId;
  final String visitId;
  dynamic rejectReason;
  final String status;

  Datum({
    required this.id,
    this.dateTime,
    required this.userId,
    required this.userName,
    required this.userBranch,
    required this.userMobile,
    required this.userEmail,
    required this.enqTypeId,
    required this.enqTypeName,
    required this.branchId,
    required this.branchName,
    required this.branchCity,
    required this.personId,
    required this.personName,
    required this.personMobile,
    required this.personEmail,
    required this.productServiceId,
    required this.productServiceType,
    required this.productServiceName,
    required this.client,
    required this.contactPerson,
    required this.contactNo,
    required this.currentVendor,
    required this.currentPrice,
    required this.targetBusiness,
    required this.remark,
    required this.opStatus,
    required this.clientId,
    required this.vendorId,
    required this.visitId,
    this.rejectReason,
    required this.status,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        dateTime: DateTime.parse(json["date_time"]),
        userId: json["user_id"],
        userName: json["user_name"],
        userBranch: json["user_branch"],
        userMobile: json["user_mobile"],
        userEmail: json["user_email"],
        enqTypeId: json["enq_type_id"],
        enqTypeName: json["enq_type_name"],
        branchId: json["branch_id"],
        branchName: json["branch_name"],
        branchCity: json["branch_city"],
        personId: json["person_id"],
        personName: json["person_name"],
        personMobile: json["person_mobile"],
        personEmail: json["person_email"],
        productServiceId: json["product_service_id"],
        productServiceType: json["product_service_type"],
        productServiceName: json["product_service_name"],
        client: json["client"],
        contactPerson: json["contact_person"],
        contactNo: json["contact_no"],
        currentVendor: json["current_vendor"],
        currentPrice: json["current_price"],
        targetBusiness: json["target_business"],
        remark: json["remark"],
        opStatus: json["op_status"],
        clientId: json["client_id"],
        vendorId: json["vendor_id"],
        visitId: json["visit_id"],
        rejectReason: json["reject_reason"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date_time": dateTime!.toIso8601String(),
        "user_id": userId,
        "user_name": userName,
        "user_branch": userBranch,
        "user_mobile": userMobile,
        "user_email": userEmail,
        "enq_type_id": enqTypeId,
        "enq_type_name": enqTypeName,
        "branch_id": branchId,
        "branch_name": branchName,
        "branch_city": branchCity,
        "person_id": personId,
        "person_name": personName,
        "person_mobile": personMobile,
        "person_email": personEmail,
        "product_service_id": productServiceId,
        "product_service_type": productServiceType,
        "product_service_name": productServiceName,
        "client": client,
        "contact_person": contactPerson,
        "contact_no": contactNo,
        "current_vendor": currentVendor,
        "current_price": currentPrice,
        "target_business": targetBusiness,
        "remark": remark,
        "op_status": opStatus,
        "client_id": clientId,
        "vendor_id": vendorId,
        "visit_id": visitId,
        "reject_reason": rejectReason,
        "status": status,
      };
}
