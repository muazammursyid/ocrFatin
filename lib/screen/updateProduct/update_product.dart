import 'package:flutter/material.dart';
import 'package:ocr_barcode_flutter/screen/updateProduct/api/allProductAPI.dart';

class UpdateProduct extends StatefulWidget {
  UpdateProduct({Key key}) : super(key: key);

  @override
  _UpdateProductState createState() => _UpdateProductState();
}

class _UpdateProductState extends State<UpdateProduct> {
  @override
  void initState() {
    var jsons = {};
    UpdateProductAPi.getAllProduct(jsons);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [],
      ),
    );
  }
}
