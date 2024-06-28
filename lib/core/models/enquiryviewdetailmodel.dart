// To parse this JSON data, do
//
//     final getEnquiryViewDetailModel = getEnquiryViewDetailModelFromJson(jsonString);

import 'dart:convert';

GetEnquiryViewDetailModel getEnquiryViewDetailModelFromJson(String str) => GetEnquiryViewDetailModel.fromJson(json.decode(str));

String getEnquiryViewDetailModelToJson(GetEnquiryViewDetailModel data) => json.encode(data.toJson());

class GetEnquiryViewDetailModel {
  int? status;
  String? message;
  List<Datum>? data;

  GetEnquiryViewDetailModel({
    this.status,
    this.message,
    this.data,
  });

  factory GetEnquiryViewDetailModel.fromJson(Map<String, dynamic> json) => GetEnquiryViewDetailModel(
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
  String? id;
  String? userId;
  String? visitAt;
  String? client;
  dynamic vendor;
  DateTime? startAt;
  DateTime? endAt;
  String? personName;
  String? personDesi;
  String? personMobile;
  String? personImage;
  String? productService;
  String? queryComplaint;
  String? orderDone;
  DateTime? nextVisit;
  String? remark;
  String? location;

  Datum({
    this.id,
    this.userId,
    this.visitAt,
    this.client,
    this.vendor,
    this.startAt,
    this.endAt,
    this.personName,
    this.personDesi,
    this.personMobile,
    this.personImage,
    this.productService,
    this.queryComplaint,
    this.orderDone,
    this.nextVisit,
    this.remark,
    this.location,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    userId: json["user_id"],
    visitAt: json["visit_at"],
    client: json["client"],
    vendor: json["vendor"],
    startAt: DateTime.parse(json["start_at"]),
    endAt: DateTime.parse(json["end_at"]),
    personName: json["person_name"],
    personDesi: json["person_desi"],
    personMobile: json["person_mobile"],
    personImage: json["person_image"],
    productService: json["product_service"],
    queryComplaint: json["query_complaint"],
    orderDone: json["order_done"],
    nextVisit: DateTime.parse(json["next_visit"]),
    remark: json["remark"],
    location: json["location"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "visit_at": visitAt,
    "client": client,
    "vendor": vendor,
    "start_at": startAt!.toIso8601String(),
    "end_at": endAt!.toIso8601String(),
    "person_name": personName,
    "person_desi": personDesi,
    "person_mobile": personMobile,
    "person_image": personImage,
    "product_service": productService,
    "query_complaint": queryComplaint,
    "order_done": orderDone,
    "next_visit": nextVisit!.toIso8601String(),
    "remark": remark,
    "location": location,
  };
}