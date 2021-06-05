import 'package:flutter/material.dart';
import 'package:ocr_barcode_flutter/screen/addProduct/add_product.dart';
import 'package:ocr_barcode_flutter/screen/updateProduct/update_product.dart';

class AdminScreen extends StatefulWidget {
  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
              image: AssetImage("assets/images/background8.png"),
              fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.all(15),
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        image: DecorationImage(
                            image: AssetImage("assets/images/logo.png"),
                            fit: BoxFit.fitWidth),
                      ),
                    ),
                    SizedBox(
                      height: 80,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30, right: 40),
                      child: SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddProduct(),
                              ),
                            );
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
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30, right: 40),
                      child: SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UpdateProduct(),
                              ),
                            );
                          },
                          child: Text('UPDATE Product'),
                          style: OutlinedButton.styleFrom(
                            shape: BeveledRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                Positioned(
                  left: 5,
                  top: 5,
                  child: BackButton(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
