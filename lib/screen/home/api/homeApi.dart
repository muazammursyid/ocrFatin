import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ocr_barcode_flutter/provider/rest.dart';
import 'package:ocr_barcode_flutter/screen/complaint/complaint_screen.dart';
import 'package:ocr_barcode_flutter/screen/complaint/complaint_view.dart';
import 'package:ocr_barcode_flutter/screen/home/models/complaintData.dart';
import 'package:ocr_barcode_flutter/screen/home/models/searchByProduct.dart';
import 'package:ocr_barcode_flutter/screen/searchHalal/displayByProduct.dart';
import 'package:ocr_barcode_flutter/screen/searchHalal/search_screen.dart';
import 'package:ocr_barcode_flutter/widget/custom_dialog_two_button.dart';

class HomeApi {
  static Future<List<ProductData>> getSearchByProduct(text, context,
      [isFromSearch = false]) async {
    try {
      var jsons = {};
      var result = await GetAPI.providersGET(
          jsons, 'Product/getallproductwithlookup/$text');
      var response = result[1];
      var statusCode = result[0];
      print(response);
      if (statusCode == 200) {
        final goodConductData = goodConductDataFromJson(response);
        if (goodConductData.message == "Success") {
          if (isFromSearch) {
            return goodConductData.data;
          }
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DisplayByProduct(
                listProduct: goodConductData.data,
                result: goodConductData.result,
              ),
            ),
          ).then(
            (value) {
              SystemChannels.textInput.invokeMethod('TextInput.hide');
            },
          );
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return CustomTwoDialog(
                title: "Warning !",
                descriptions:
                    'We do not found your search in our database. Do you want make report  ?',
                textOk: "Report",
                img: "assets/images/warning.jpeg",
                functionOk: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ComplaintScreen(),
                    ),
                  ).then((value) => Navigator.of(context).pop());
                },
                textCancel: 'Cancel',
                functionCancel: () {
                  Navigator.of(context).pop();
                },
              );
            },
          );
        }
      } else {}
    } catch (e) {
      print(e);
    }
  }

  static Future getSearchByProductFromScanner(text, context) async {
    try {
      var jsons = {"keyword": text};
      var result = await GetAPI.addProductProvider(
          jsons, 'Product/getallproductwithlookup2');
      var response = result[1];
      var statusCode = result[0];
      print(response);
      if (statusCode == 200) {
        final goodConductData = goodConductDataFromJson(response);
        if (goodConductData.message == "Success") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DisplayByProduct(
                listProduct: goodConductData.data,
                result: goodConductData.result,
              ),
            ),
          ).then(
            (value) {
              SystemChannels.textInput.invokeMethod('TextInput.hide');
            },
          );
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return CustomTwoDialog(
                title: "Warning !",
                descriptions:
                    'We do not found your search in our database. Do you want make report ?',
                textOk: "Report",
                img: "assets/images/warning.jpeg",
                functionOk: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ComplaintScreen(),
                    ),
                  ).then((value) => Navigator.of(context).pop());
                },
                textCancel: 'Cancel',
                functionCancel: () {
                  Navigator.of(context).pop();
                },
              );
            },
          );
        }
      } else {}
    } catch (e) {
      print(e);
    }
  }

  static Future<List<DatumComplaint>> getMyComplaint(myEmail, context,
      [isFromRefresh = false]) async {
    try {
      var jsons = {};
      var result = await GetAPI.providersGET(
          jsons, 'Complaint/getcomplaintbyuser/$myEmail');
      var statusCode = result[0];
      var response = result[1];
      if (statusCode == 200) {
        final complaintData = complaintDataFromJson(response);
        if (isFromRefresh) {
          print(response);
          print('here');
          return complaintData.data;
        }
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ComplaintView(
                listComplaint: complaintData.data, myEmail: myEmail),
          ),
        ).then((value) {
          SystemChannels.textInput.invokeMethod('TextInput.hide');
        });
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }
}
