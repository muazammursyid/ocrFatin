import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ocr_barcode_flutter/provider/rest.dart';
import 'package:ocr_barcode_flutter/screen/updateProduct/model/allProductModel.dart';
import 'package:ocr_barcode_flutter/widget/custom_dialog.dart';

class UpdateProductAPi {
  static Future<List<DatumAll>> getAllProduct(jsons) async {
    try {
      var result = await GetAPI.providersGET(jsons, 'Product/getallproduct');
      var statusCode = result[0];
      var response = result[1];
      print(response);
      if (statusCode == 200) {
        final allProduct = allProductFromJson(response);
        return allProduct.data;
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  static Future getApiUpdateProduct(jsons, context) async {
    try {
      print(jsons);
      var result = await GetAPI.addProductProvider(jsons, 'Product/update');
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
                  descriptions: "Product successfully updated.",
                  text: "Ok",
                );
              }).then((value) => Navigator.of(context).pop());
        } else {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return CustomDialogBox(
                  title: "Unsuccessful !",
                  descriptions: "Please try again later. ",
                  text: "Ok",
                );
              });
        }
      }
    } catch (e) {
      print(e);
    }
  }
}
