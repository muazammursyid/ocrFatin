// To parse this JSON data, do
//
//     final allBranded = allBrandedFromJson(jsonString);

import 'dart:convert';

AllBranded allBrandedFromJson(String str) =>
    AllBranded.fromJson(json.decode(str));

String allBrandedToJson(AllBranded data) => json.encode(data.toJson());

class AllBranded {
  AllBranded({
    this.result,
    this.message,
    this.date,
    this.data,
  });

  bool result;
  String message;
  DateTime date;
  List<Branded> data;

  factory AllBranded.fromJson(Map<String, dynamic> json) => AllBranded(
        result: json["Result"] == null ? null : json["Result"],
        message: json["Message"] == null ? null : json["Message"],
        date: json["Date"] == null ? null : DateTime.parse(json["Date"]),
        data: json["Data"] == null
            ? null
            : List<Branded>.from(json["Data"].map((x) => Branded.fromJson(x))),
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

class Branded {
  Branded({
    this.idx,
    this.name,
    this.companyId,
    this.companyName,
    this.createBy,
    this.createDate,
    this.updateBy,
    this.updateDate,
  });

  String idx;
  String name;
  String companyId;
  dynamic companyName;
  String createBy;
  String createDate;
  String updateBy;
  String updateDate;

  factory Branded.fromJson(Map<String, dynamic> json) => Branded(
        idx: json["idx"] == null ? null : json["idx"],
        name: json["name"] == null ? null : json["name"],
        companyId: json["company_id"] == null ? null : json["company_id"],
        companyName: json["company_name"],
        createBy: json["create_by"] == null ? null : json["create_by"],
        createDate: json["create_date"] == null ? null : json["create_date"],
        updateBy: json["update_by"] == null ? null : json["update_by"],
        updateDate: json["update_date"] == null ? null : json["update_date"],
      );

  Map<String, dynamic> toJson() => {
        "idx": idx == null ? null : idx,
        "name": name == null ? null : name,
        "company_id": companyId == null ? null : companyId,
        "company_name": companyName,
        "create_by": createBy == null ? null : createBy,
        "create_date": createDate == null ? null : createDate,
        "update_by": updateBy == null ? null : updateBy,
        "update_date": updateDate == null ? null : updateDate,
      };
}
