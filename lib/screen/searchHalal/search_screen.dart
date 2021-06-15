import 'package:flutter/material.dart';
import 'package:ocr_barcode_flutter/screen/home/models/searchByProduct.dart';

class SearchScreen extends StatefulWidget {
  final String productName;
  final String expiredDate;
  final String brandName;
  final String refNumber;
  final String companyName;
  final String imageProduct;
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
        body: SafeArea(
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 80,
                    ),
                    Center(
                      child: Container(
                        width: 200.0,
                        height: 200.0,
                        decoration: new BoxDecoration(
                          color: const Color(0xff7c94b6),
                          image: new DecorationImage(
                            image: AssetImage('assets/images/susu.jpg'),
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
                  ],
                ),
                Positioned(
                  left: 5,
                  top: 5,
                  child: Row(
                    children: [
                      BackButton(),
                      Text(
                        'Details Of Product',
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
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
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
