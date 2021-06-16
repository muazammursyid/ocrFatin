import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ocr_barcode_flutter/provider/rest.dart';
import 'package:ocr_barcode_flutter/screen/admin/admin_screen.dart';
import 'package:ocr_barcode_flutter/screen/home/home_page.dart';
import 'package:ocr_barcode_flutter/widget/custom_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginAPI {
  static Future loginApi(jsons, context) async {
    try {
      var result = await GetAPI.providersPOST(jsons, 'User/postuser');
      var response = result[1];
      var statusCode = result[0];
      print(response);
      if (statusCode == 200) {
        final map = json.decode(response);
        if (map['Result'] == true) {
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString("idx", map["Data"][0]["idx"]);
          prefs.setString("fullname", map["Data"][0]["fullname"]);
          prefs.setString('email', map["Data"][0]["email"]);
          if (map["Data"][0]["user_role"] != "user") {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => AdminScreen(
                  username: map["Data"][0]["username"],
                ),
              ),
            );
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            );
          }
        } else {
          //! show alert wrong password
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return CustomDialogBox(
                  title: "Unsuccessful !",
                  descriptions:
                      "Your username and password is incorecct. Please try again",
                  text: "Ok",
                );
              });
        }
      } else {}
    } catch (e) {}
  }
}
