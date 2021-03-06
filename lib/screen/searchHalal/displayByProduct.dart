import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:ocr_barcode_flutter/screen/complaint/complaint_screen.dart';
import 'package:ocr_barcode_flutter/screen/home/models/searchByProduct.dart';
import 'package:ocr_barcode_flutter/screen/searchHalal/search_screen.dart';

class DisplayByProduct extends StatefulWidget {
  List<ProductData> listProduct = [];
  final bool result;
  DisplayByProduct({this.listProduct, @required this.result});

  @override
  _DisplayByProductState createState() => _DisplayByProductState();
}

class _DisplayByProductState extends State<DisplayByProduct> {
  List<ProductData> listProduct = [];

  @override
  void initState() {
    listProduct = widget.listProduct;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo[200],
        title: Text(
          'List Of Product',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total Product : ${listProduct.length}'.toUpperCase(),
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      children: listProduct.map((item) {
                         Uint8List bytes = base64.decode(item.imagebinary);
                        return Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SearchScreen(
                                      productName: item.name,
                                      expiredDate: item.expiredDate,
                                      brandName: item.brandName,
                                      refNumber: item.noRef,
                                      companyName: item.companyName,
                                      imageProduct: bytes,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                height: 180,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 3,
                                      blurRadius: 7,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Container(
                                      width: 120.0,
                                      height: 120,
                                      decoration: new BoxDecoration(
                                        image: new DecorationImage(
                                          image: item.imagebinary != ""
                                                          ? MemoryImage(
                                                              bytes)
                                                          : AssetImage(
                                                              'assets/images/noImage.jpeg'),
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius: new BorderRadius.all(
                                            new Radius.circular(15.0)),
                                        border: new Border.all(
                                          color: Colors.black,
                                          width: 1.0,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 30,
                                          ),
                                          Text(
                                            'Name : ' + item.name,
                                            softWrap: true,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: 4,
                                          ),
                                          Text(
                                            'No Ref : ' + item.noRef,
                                            softWrap: true,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w300),
                                          ),
                                          SizedBox(
                                            height: 4,
                                          ),
                                          Text(
                                            'Halal Status Expiry Date : ' +
                                                item.expiredDate,
                                            softWrap: true,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w300),
                                          ),
                                          SizedBox(
                                            height: 4,
                                          ),
                                          Expanded(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Expanded(
                                                  child: SizedBox(
                                                      width: double.infinity),
                                                ),
                                                Icon(Icons.arrow_forward),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Any complaint regarding the product, please let us know.',
                      style: TextStyle(color: Colors.redAccent),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    widget.result
                        ? SizedBox(
                            width: 150,
                            height: 50,
                            child: RaisedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ComplaintScreen(),
                                  ),
                                );
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(80.0)),
                              padding: const EdgeInsets.all(0.0),
                              child: Ink(
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: <Color>[
                                      Colors.red,
                                      Colors.red,
                                      Colors.redAccent
                                    ],
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(80.0)),
                                ),
                                child: Container(
                                  constraints: const BoxConstraints(
                                      minWidth: 88.0,
                                      minHeight:
                                          36.0), // min sizes for Material buttons
                                  alignment: Alignment.center,
                                  child: const Text(
                                    'Complaint Product',
                                    style: TextStyle(color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : SizedBox(),
                    SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ),
              // Positioned(
              //   left: 5,
              //   top: 5,
              //   child: Row(
              //     children: [
              //       BackButton(),
              //       Text(
              //         'List Of Product',
              //         style: TextStyle(
              //             fontWeight: FontWeight.bold,
              //             color: Colors.black,
              //             fontSize: 18),
              //       ),
              //     ],
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
