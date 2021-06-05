import 'package:ocr_barcode_flutter/provider/rest.dart';

class AddProductAPI {
  static Future getApiAddProduct(jsons, context) async {
    try {
      var result = await GetAPI.addProductProvider(jsons, 'Product/insert');
      var statusCode = result[0];
      var response = result[1];
      print(response);
    } catch (e) {
      print(e);
    }
  }
}
