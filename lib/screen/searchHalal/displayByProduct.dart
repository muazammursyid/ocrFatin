import 'package:flutter/material.dart';
import 'package:ocr_barcode_flutter/screen/home/models/searchByProduct.dart';
import 'package:ocr_barcode_flutter/screen/searchHalal/search_screen.dart';

class DisplayByProduct extends StatefulWidget {
  List<Datum> listProduct = [];
  DisplayByProduct({this.listProduct});

  @override
  _DisplayByProductState createState() => _DisplayByProductState();
}

class _DisplayByProductState extends State<DisplayByProduct> {
  List<Datum> listProduct = [];

  @override
  void initState() {
    listProduct = widget.listProduct;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    SizedBox(
                      height: 60,
                    ),
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
                        return InkWell(
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
                                  imageProduct: item.filename,
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
                                      image: item.filename == ""
                                          ? AssetImage('assets/images/susu.jpg')
                                          : NetworkImage(item.filename),
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
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        'Name : ' + item.name,
                                        softWrap: true,
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
                                        'Expired Date : ' + item.expiredDate,
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
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    )
                  ],
                ),
              ),
              Positioned(
                left: 5,
                top: 5,
                child: Row(
                  children: [
                    BackButton(),
                    Text(
                      'List Of Product',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 18),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
