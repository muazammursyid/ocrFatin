import 'package:ocr_barcode_flutter/provider/rest.dart';
import 'package:ocr_barcode_flutter/screen/updateProduct/model/allProductModel.dart';

class UpdateProductAPi {
  static Future<List<Datum>> getAllProduct(jsons) async {
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
}
