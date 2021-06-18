import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ocr_barcode_flutter/provider/rest.dart';
import 'package:ocr_barcode_flutter/widget/custom_dialog.dart';

class RegisterAPI {
  static Future registerAPI(jsons, context) async {
    try {
      var result = await GetAPI.addProductProvider(jsons, 'User/insert');
      var statusCode = result[0];
      var response = result[1];
      if (statusCode == 200) {
        final map = json.decode(response);
        if (map["Result"] == true) {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return CustomDialogBox(
                  title: "Success !",
                  img: 'assets/images/success.jpeg',
                  descriptions: "Succesfully Registered",
                  text: "Ok",
                );
              }).then((value) => Navigator.of(context).pop());
        } else {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return CustomDialogBox(
                  title: "Unsuccessful !",
                  descriptions:
                      "Your username and password is incorrect. Please try again",
                  text: "Ok",
                );
              });
        }
      } else {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return CustomDialogBox(
                title: "Unsuccessful !",
                descriptions:
                    "Your username and password is incorrect. Please try again",
                text: "Ok",
              );
            });
      }
    } catch (e) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: "Unsuccessful !",
              descriptions: "Connection error",
              text: "Ok",
            );
          });
    }
  }
}
