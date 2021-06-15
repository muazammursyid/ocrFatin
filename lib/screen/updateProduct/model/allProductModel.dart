// To parse this JSON data, do
//
//     final allProduct = allProductFromJson(jsonString);

import 'dart:convert';

AllProduct allProductFromJson(String str) =>
    AllProduct.fromJson(json.decode(str));

String allProductToJson(AllProduct data) => json.encode(data.toJson());

class AllProduct {
  AllProduct({
    this.result,
    this.message,
    this.date,
    this.data,
  });

  bool result;
  String message;
  DateTime date;
  List<DatumAll> data;

  factory AllProduct.fromJson(Map<String, dynamic> json) => AllProduct(
        result: json["Result"] == null ? null : json["Result"],
        message: json["Message"] == null ? null : json["Message"],
        date: json["Date"] == null ? null : DateTime.parse(json["Date"]),
        data: json["Data"] == null
            ? null
            : List<DatumAll>.from(
                json["Data"].map((x) => DatumAll.fromJson(x))),
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

class DatumAll {
  DatumAll({
    this.idx,
    this.name,
    this.noRef,
    this.companyId,
    this.companyName,
    this.brandId,
    this.brandName,
    this.expiredDate,
    this.createBy,
    this.createDate,
    this.updateBy,
    this.updateDate,
    this.imagebinary,
    this.filename,
    this.filetype,
  });

  String idx;
  String name;
  String noRef;
  String companyId;
  String companyName;
  String brandId;
  String brandName;
  String expiredDate;
  String createBy;
  String createDate;
  String updateBy;
  String updateDate;
  String imagebinary;
  String filename;
  String filetype;

  factory DatumAll.fromJson(Map<String, dynamic> json) => DatumAll(
        idx: json["idx"] == null ? null : json["idx"],
        name: json["name"] == null ? null : json["name"],
        noRef: json["no_ref"] == null ? null : json["no_ref"],
        companyId: json["company_id"] == null ? null : json["company_id"],
        companyName: json["company_name"] == null ? null : json["company_name"],
        brandId: json["brand_id"] == null ? null : json["brand_id"],
        brandName: json["brand_name"] == null ? null : json["brand_name"],
        expiredDate: json["expired_date"] == null ? null : json["expired_date"],
        createBy: json["create_by"] == null ? null : json["create_by"],
        createDate: json["create_date"] == null ? null : json["create_date"],
        updateBy: json["update_by"] == null ? null : json["update_by"],
        updateDate: json["update_date"] == null ? null : json["update_date"],
        imagebinary: json["imagebinary"] == null ? null : json["imagebinary"],
        filename: json["filename"] == null ? null : json["filename"],
        filetype: json["filetype"] == null ? null : json["filetype"],
      );

  Map<String, dynamic> toJson() => {
        "idx": idx == null ? null : idx,
        "name": name == null ? null : name,
        "no_ref": noRef == null ? null : noRef,
        "company_id": companyId == null ? null : companyId,
        "company_name": companyName == null ? null : companyName,
        "brand_id": brandId == null ? null : brandId,
        "brand_name": brandName == null ? null : brandName,
        "expired_date": expiredDate == null ? null : expiredDate,
        "create_by": createBy == null ? null : createBy,
        "create_date": createDate == null ? null : createDate,
        "update_by": updateBy == null ? null : updateBy,
        "update_date": updateDate == null ? null : updateDate,
        "imagebinary": imagebinary == null ? null : imagebinary,
        "filename": filename == null ? null : filename,
        "filetype": filetype == null ? null : filetype,
      };
}
