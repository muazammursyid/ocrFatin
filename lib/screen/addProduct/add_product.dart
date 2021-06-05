import 'package:flutter/material.dart';
import 'package:ocr_barcode_flutter/screen/addProduct/api/addProductAPI.dart';

class AddProduct extends StatefulWidget {
  AddProduct({Key key}) : super(key: key);

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final productNameText = TextEditingController();
  final expiredDateText = TextEditingController();
  final brandText = TextEditingController();
  final referenceNumberText = TextEditingController();
  final companyNameText = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
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
                    child: Stack(
                      children: [
                        Container(
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
                        Positioned(
                          right: 1,
                          bottom: 1,
                          child: CircleAvatar(
                            backgroundColor: Colors.blue,
                            radius: 20,
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              icon: Icon(Icons.edit),
                              color: Colors.white,
                              onPressed: () {},
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  makeInput(
                      label: "Product Name", controllerText: productNameText),
                  makeInput(
                      label: "Expired Date", controllerText: expiredDateText),
                  makeInput(label: "Brand", controllerText: brandText),
                  makeInput(
                      label: "Reference Number",
                      controllerText: referenceNumberText),
                  makeInput(
                      label: "Company Name", controllerText: companyNameText),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30, right: 40),
                    child: SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          var jsons = {
                            // "name": productNameText.text,
                            "name": 'testing',
                            // "no_ref": referenceNumberText.text,
                            "no_ref": 'JAKIM TESTINGG',
                            "company_id": "4",
                            "brand_id": "6",
                            // "expired_date": expiredDateText.text,
                            "expired_date": '31/5/2022 12:00:00 AM',
                            "create_by": "fatin@gmail",
                            "create_date": "1/6/2021 11:49:23 PM",
                            "update_by": "fatin@gmail.com",
                            "update_date": "1/6/2021 11:49:23 PM",
                            "imagebinary": "",
                            "filename": "",
                            "filetype": "",
                          };
                          AddProductAPI.getApiAddProduct(jsons, context);
                        },
                        child: Text('ADD Product'),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(5), // <-- Radius
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 80,
                  ),
                ],
              ),
              Positioned(
                left: 5,
                top: 5,
                child: Row(
                  children: [
                    BackButton(),
                    Text(
                      'Add Product',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 18),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget makeInput({
    label,
    TextEditingController controllerText,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: Colors.black87),
          ),
          SizedBox(
            height: 5,
          ),
          // Container(
          //   padding: const EdgeInsets.only(left: 8, right: 8),
          //   decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          //   width: double.infinity,
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.start,
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       SizedBox(
          //         height: 15,
          //       ),
          //       Text(
          //         displayText,
          //         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          //       ),
          //       SizedBox(
          //         height: 15,
          //       ),
          //     ],
          //   ),
          // ),
          TextField(
            controller: controllerText,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey[400],
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey[400],
                ),
              ),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[400])),
            ),
          ),
          SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }
}
