import 'package:flutter/material.dart';
import 'package:ocr_barcode_flutter/provider/rest.dart';
import 'package:ocr_barcode_flutter/screen/admin/admin_screen.dart';

class LoginAPI {
  static Future loginApi(jsons, context) async {
    try {
      var result = await GetAPI.providersPOST(jsons, 'User/postuser');
      var response = result[1];
      var statusCode = result[0];
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AdminScreen(),
        ),
      );
      // if (statusCode == 200) {
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => AdminScreen(),
      //     ),
      //   );
      // } else {}
    } catch (e) {}
  }
}
