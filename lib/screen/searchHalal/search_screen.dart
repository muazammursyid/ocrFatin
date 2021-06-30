import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:ocr_barcode_flutter/screen/complaint/complaint_screen.dart';
import 'package:ocr_barcode_flutter/screen/home/models/searchByProduct.dart';

class SearchScreen extends StatefulWidget {
  final String productName;
  final String expiredDate;
  final String brandName;
  final String refNumber;
  final String companyName;
  final Uint8List imageProduct;
  SearchScreen({
    this.productName,
    this.expiredDate,
    this.brandName,
    this.refNumber,
    this.companyName,
    this.imageProduct,
  });
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo[200],
          title: Text(
            'Details Of Product',
            style: TextStyle(color: Colors.black),
          ),
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Container(
                        width: 200.0,
                        height: 200.0,
                        decoration: new BoxDecoration(
                          color: const Color(0xff7c94b6),
                          image: new DecorationImage(
                           image: widget.imageProduct != null
                                              ? MemoryImage(widget.imageProduct)
                                              : AssetImage(
                                                  'assets/images/noImage.jpeg'),
                            fit: BoxFit.cover,
                          ),
                          borderRadius:
                              new BorderRadius.all(new Radius.circular(15.0)),
                          border: new Border.all(
                            color: Colors.blue,
                            width: 1.0,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    makeInput(
                        label: "Product Name", displayText: widget.productName),
                    makeInput(
                        label: "Halal Status Expiry Date",
                        displayText: widget.expiredDate),
                    makeInput(label: "Brand", displayText: widget.brandName),
                    makeInput(
                        label: "Reference Number",
                        displayText: widget.refNumber),
                    makeInput(
                        label: "Company Name", displayText: widget.companyName),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Any complaint regarding the product, please let us know.',
                      style: TextStyle(color: Colors.redAccent),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
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
                    ),
                    SizedBox(
                      height: 40,
                    ),
                  ],
                ),
                // Positioned(
                //   left: 5,
                //   top: 5,
                //   child: Row(
                //     children: [
                //       BackButton(),
                //       Text(
                //         'Details Of Product',
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
      ),
    );
  }
}

Widget makeInput({label, displayText}) {
  return Padding(
    padding: const EdgeInsets.only(left: 20, right: 20, top: 2),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          padding: const EdgeInsets.only(left: 8, right: 8),
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 15,
              ),
              Text(
                displayText,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: Colors.black),
              ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
        // TextField(
        //   controller: TextEditingController()..text = displayText,
        //   decoration: InputDecoration(
        //     contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        //     enabledBorder: OutlineInputBorder(
        //       borderSide: BorderSide(
        //         color: Colors.grey[400],
        //       ),
        //     ),
        //     border: OutlineInputBorder(
        //         borderSide: BorderSide(color: Colors.grey[400])),
        //   ),
        // ),
        SizedBox(
          height: 30,
        )
      ],
    ),
  );
}
