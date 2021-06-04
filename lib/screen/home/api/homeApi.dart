import 'package:flutter/material.dart';
import 'package:ocr_barcode_flutter/provider/rest.dart';
import 'package:ocr_barcode_flutter/screen/home/models/searchByProduct.dart';
import 'package:ocr_barcode_flutter/screen/searchHalal/displayByProduct.dart';
import 'package:ocr_barcode_flutter/screen/searchHalal/search_screen.dart';

class HomeApi {
  static Future getSearchByProduct(text, context) async {
    try {
      var jsons = {};
      var result = await GetAPI.providersGET(
          jsons, 'Product/getallproductwithlookup/$text');
      var response = result[1];
      var statusCode = result[0];
      print(response);
      if (statusCode == 200) {
        final goodConductData = goodConductDataFromJson(response);
        if (goodConductData.message == 'Success') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DisplayByProduct(
                listProduct: goodConductData.data,
              ),
            ),
          );
        } else {}
      } else {}
    } catch (e) {
      print(e);
    }
  }
}
