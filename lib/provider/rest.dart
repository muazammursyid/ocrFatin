import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:ocr_barcode_flutter/provider/globals.dart' as globals;
import 'package:http/io_client.dart';

class GetAPI {
  static setupHTTPHeader(token) {
    globals.headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  static addProductProvider(jsons, phpFile) async {
    try {
      String api =
          globals.isProduction ? globals.urlProduction : globals.urlStagging;
      String jsonBody = json.encode(jsons);
      print(jsonBody);
      print("$api$phpFile");
      Uri url = Uri.parse('$api$phpFile');
      final ioc = new HttpClient();
      ioc.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      final http = new IOClient(ioc);
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        },
        encoding: Encoding.getByName('utf-8'),
        body: {
          "val": [jsonBody].toString()
        },
      );

      return [response.statusCode, response.body];
    } catch (e) {
      print(e);
    }
  }

  static providersGET(jsons, phpFile) async {
    try {
      String api =
          globals.isProduction ? globals.urlProduction : globals.urlStagging;
      print("$phpFile");
      Uri url = Uri.parse('$api$phpFile');
      final ioc = new HttpClient();
      ioc.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      final http = new IOClient(ioc);
      Response response = await http.get(url, headers: globals.headers);
      return [response.statusCode, response.body];
    } catch (e) {
      print(e.toString());
    }
  }

  static providersDELETE(jsons, phpFile) async {
    try {
      String api =
          globals.isProduction ? globals.urlProduction : globals.urlStagging;
      String jsonBody = json.encode(jsons);
      Uri url = Uri.parse('$api$phpFile');
      final ioc = new HttpClient();
      ioc.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      final http = new IOClient(ioc);
      print(jsonBody);
      Response response = await http.delete(url, headers: globals.headers);
      return [response.statusCode, response.body];
    } catch (e) {
      print(e.toString());
    }
  }

  static providersPOST(jsons, phpFile) async {
    try {
      String api =
          globals.isProduction ? globals.urlProduction : globals.urlStagging;
      print("$phpFile");
      Uri url = Uri.parse('$api$phpFile');
      String jsonBody = json.encode(jsons);
      print(jsonBody);
      final ioc = new HttpClient();
      ioc.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      final http = new IOClient(ioc);
      print('here');
      Response response = await http.post(
        url,
        body: jsonBody,
        headers: {
          'Content-Type': 'application/json',
        },
      );
      return [response.statusCode, response.body];
    } catch (e) {
      print(e.toString());
    }
  }
}
