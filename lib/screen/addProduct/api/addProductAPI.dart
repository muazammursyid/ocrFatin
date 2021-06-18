import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ocr_barcode_flutter/provider/rest.dart';
import 'package:ocr_barcode_flutter/screen/addProduct/model/allBrandedmodel.dart';
import 'package:ocr_barcode_flutter/screen/addProduct/model/listAllCompany.dart';
import 'package:ocr_barcode_flutter/widget/custom_dialog.dart';

class AddProductAPI {
  static Future getApiAddProduct(jsons, context) async {
    try {
      var result = await GetAPI.addProductProvider(jsons, 'Product/insert');
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
                  title: "Success !",
                  img: 'assets/images/success.jpeg',
                  descriptions: "Product successfully added.",
                  text: "Ok",
                );
              }).then((value) => Navigator.of(context).pop());
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
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<List<Branded>> getAlbrand() async {
    try {
      var jsons = {};
      var result = await GetAPI.providersGET(jsons, 'Brand/getbrand');
      var statusCode = result[0];
      var response = result[1];
      print(response);
      if (statusCode == 200) {
        final allBranded = allBrandedFromJson(response);
        return allBranded.data;
      } else {}
    } catch (e) {
      print(e);
    }
  }

  static Future<List<Datum>> getAllCompanyName() async {
    try {
      var jsons = {};
      var result = await GetAPI.providersGET(jsons, 'Company/getallcompany');
      var statusCode = result[0];
      var response = result[1];
      print(response);
      if (statusCode == 200) {
        final allCompany = allCompanyFromJson(response);
        return allCompany.data;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}
