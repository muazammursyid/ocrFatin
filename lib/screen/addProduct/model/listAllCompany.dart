// To parse this JSON data, do
//
//     final allCompany = allCompanyFromJson(jsonString);

import 'dart:convert';

AllCompany allCompanyFromJson(String str) =>
    AllCompany.fromJson(json.decode(str));

String allCompanyToJson(AllCompany data) => json.encode(data.toJson());

class AllCompany {
  AllCompany({
    this.result,
    this.message,
    this.date,
    this.data,
  });

  bool result;
  String message;
  DateTime date;
  List<Datum> data;

  factory AllCompany.fromJson(Map<String, dynamic> json) => AllCompany(
        result: json["Result"] == null ? null : json["Result"],
        message: json["Message"] == null ? null : json["Message"],
        date: json["Date"] == null ? null : DateTime.parse(json["Date"]),
        data: json["Data"] == null
            ? null
            : List<Datum>.from(json["Data"].map((x) => Datum.fromJson(x))),
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

class Datum {
  Datum({
    this.idx,
    this.name,
    this.address,
    this.postcode,
    this.city,
    this.stateId,
    this.stateName,
    this.telephone,
    this.fax,
    this.email,
    this.website,
    this.officerName,
    this.officerTelephone,
    this.createBy,
    this.createDate,
    this.updateBy,
    this.updateDate,
  });

  String idx;
  String name;
  String address;
  String postcode;
  String city;
  String stateId;
  String stateName;
  String telephone;
  String fax;
  String email;
  String website;
  String officerName;
  String officerTelephone;
  String createBy;
  String createDate;
  String updateBy;
  String updateDate;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        idx: json["idx"] == null ? null : json["idx"],
        name: json["name"] == null ? null : json["name"],
        address: json["address"] == null ? null : json["address"],
        postcode: json["postcode"] == null ? null : json["postcode"],
        city: json["city"] == null ? null : json["city"],
        stateId: json["state_id"] == null ? null : json["state_id"],
        stateName: json["state_name"] == null ? null : json["state_name"],
        telephone: json["telephone"] == null ? null : json["telephone"],
        fax: json["fax"] == null ? null : json["fax"],
        email: json["email"] == null ? null : json["email"],
        website: json["website"] == null ? null : json["website"],
        officerName: json["officer_name"] == null ? null : json["officer_name"],
        officerTelephone: json["officer_telephone"] == null
            ? null
            : json["officer_telephone"],
        createBy: json["create_by"] == null ? null : json["create_by"],
        createDate: json["create_date"] == null ? null : json["create_date"],
        updateBy: json["update_by"] == null ? null : json["update_by"],
        updateDate: json["update_date"] == null ? null : json["update_date"],
      );

  Map<String, dynamic> toJson() => {
        "idx": idx == null ? null : idx,
        "name": name == null ? null : name,
        "address": address == null ? null : address,
        "postcode": postcode == null ? null : postcode,
        "city": city == null ? null : city,
        "state_id": stateId == null ? null : stateId,
        "state_name": stateName == null ? null : stateName,
        "telephone": telephone == null ? null : telephone,
        "fax": fax == null ? null : fax,
        "email": email == null ? null : email,
        "website": website == null ? null : website,
        "officer_name": officerName == null ? null : officerName,
        "officer_telephone": officerTelephone == null ? null : officerTelephone,
        "create_by": createBy == null ? null : createBy,
        "create_date": createDate == null ? null : createDate,
        "update_by": updateBy == null ? null : updateBy,
        "update_date": updateDate == null ? null : updateDate,
      };
}
