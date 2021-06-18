import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ocr_barcode_flutter/provider/rest.dart';
import 'package:ocr_barcode_flutter/screen/complaint/model/allComplaintModel.dart';
import 'package:ocr_barcode_flutter/widget/custom_dialog.dart';

class ComplainAPI {
  static Future getInsertComplaint(jsons, context) async {
    try {
      var result = await GetAPI.addProductProvider(jsons, 'Complaint/insert');
      var statusCode = result[0];
      var response = result[1];
      print(response);
      if (statusCode == 200) {
        final map = json.decode(response);
        if (map["Result"] == true) {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return CustomDialogBox(
                  title: "Success ! ",
                  img: 'assets/images/success.jpeg',
                  descriptions:
                      "Your Appeal Application is under investigation. Thank you for contacting us.",
                  text: "Ok",
                );
              }).then((value) {
            Navigator.of(context).pop();
          });
        } else {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return CustomDialogBox(
                  title: "Unsuccessful !",
                  descriptions: "Please try again later.",
                  text: "Ok",
                );
              });
        }
      } else {}
    } catch (e) {}
  }

  static Future getUpdateComplaint(jsons, context) async {
    try {
      var result = await GetAPI.addProductProvider(jsons, 'Complaint/update');
      var statusCode = result[0];
      var response = result[1];
      print(response);
      if (statusCode == 200) {
        final map = json.decode(response);
        if (map["Result"] == true) {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return CustomDialogBox(
                  title: "Success ! ",
                  img: 'assets/images/success.jpeg',
                  descriptions: "Complaint successfully updated.",
                  text: "Ok",
                );
              }).then((value) {
            Navigator.of(context).pop();
          });
        } else {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return CustomDialogBox(
                  title: "Unsuccessful",
                  descriptions: "Please try again later.",
                  text: "Ok",
                );
              });
        }
      } else {}
    } catch (e) {}
  }

  static Future<List<Datum>> getAllComplaint() async {
    try {
      var jsons = {};
      var result =
          await GetAPI.providersGET(jsons, 'Complaint/getallcomplaint');
      var statusCode = result[0];
      var response = result[1];
      if (statusCode == 200) {
        final allComplaintData = allComplaintDataFromJson(response);
        return allComplaintData.data;
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }
}
