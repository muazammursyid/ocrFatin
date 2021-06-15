// To parse this JSON data, do
//
//     final complaintData = complaintDataFromJson(jsonString);

import 'dart:convert';

ComplaintData complaintDataFromJson(String str) =>
    ComplaintData.fromJson(json.decode(str));

String complaintDataToJson(ComplaintData data) => json.encode(data.toJson());

class ComplaintData {
  ComplaintData({
    this.result,
    this.message,
    this.date,
    this.data,
  });

  bool result;
  String message;
  DateTime date;
  List<DatumComplaint> data;

  factory ComplaintData.fromJson(Map<String, dynamic> json) => ComplaintData(
        result: json["Result"] == null ? null : json["Result"],
        message: json["Message"] == null ? null : json["Message"],
        date: json["Date"] == null ? null : DateTime.parse(json["Date"]),
        data: json["Data"] == null
            ? null
            : List<DatumComplaint>.from(
                json["Data"].map((x) => DatumComplaint.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Result": result == null ? null : result,
        "Message": message == null ? null : message,
        "Date": date == null ? null : date.toIso8601String(),
        "Data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class DatumComplaint {
  DatumComplaint({
    this.idx,
    this.productName,
    this.companyName,
    this.complaint,
    this.userName,
    this.userTelephone,
    this.userEmail,
    this.createBy,
    this.createDate,
    this.updateBy,
    this.updateDate,
  });

  String idx;
  String productName;
  String companyName;
  String complaint;
  String userName;
  String userTelephone;
  String userEmail;
  String createBy;
  String createDate;
  String updateBy;
  String updateDate;

  factory DatumComplaint.fromJson(Map<String, dynamic> json) => DatumComplaint(
        idx: json["idx"] == null ? null : json["idx"],
        productName: json["product_name"] == null ? null : json["product_name"],
        companyName: json["company_name"] == null ? null : json["company_name"],
        complaint: json["complaint"] == null ? null : json["complaint"],
        userName: json["user_name"] == null ? null : json["user_name"],
        userTelephone:
            json["user_telephone"] == null ? null : json["user_telephone"],
        userEmail: json["user_email"] == null ? null : json["user_email"],
        createBy: json["create_by"] == null ? null : json["create_by"],
        createDate: json["create_date"] == null ? null : json["create_date"],
        updateBy: json["update_by"] == null ? null : json["update_by"],
        updateDate: json["update_date"] == null ? null : json["update_date"],
      );

  Map<String, dynamic> toJson() => {
        "idx": idx == null ? null : idx,
        "product_name": productName == null ? null : productName,
        "company_name": companyName == null ? null : companyName,
        "complaint": complaint == null ? null : complaint,
        "user_name": userName == null ? null : userName,
        "user_telephone": userTelephone == null ? null : userTelephone,
        "user_email": userEmail == null ? null : userEmail,
        "create_by": createBy == null ? null : createBy,
        "create_date": createDate == null ? null : createDate,
        "update_by": updateBy == null ? null : updateBy,
        "update_date": updateDate == null ? null : updateDate,
      };
}
