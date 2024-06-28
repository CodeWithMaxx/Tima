// To parse this JSON data, do
//
//     final attendanceModel = attendanceModelFromJson(jsonString);

import 'dart:convert';

AttendanceModel attendanceModelFromJson(String str) =>
    AttendanceModel.fromJson(json.decode(str));

String attendanceModelToJson(AttendanceModel data) =>
    json.encode(data.toJson());

class AttendanceModel {
  int? status;
  String? message;
  List<Datum>? data;

  AttendanceModel({
    this.status,
    this.message,
    this.data,
  });

  factory AttendanceModel.fromJson(Map<String, dynamic> json) =>
      AttendanceModel(
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
  String? attDate;
  String? inTime;
  String? outTime;
  String? status;

  Datum({
    this.id,
    this.userId,
    this.attDate,
    this.inTime,
    this.outTime,
    this.status,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        userId: json["user_id"],
        attDate: json["att_date"],
        inTime: json["in_time"],
        outTime: json["out_time"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "att_date": attDate,
        "in_time": inTime,
        "out_time": outTime,
        "status": status,
      };
}
