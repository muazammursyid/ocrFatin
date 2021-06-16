import 'package:flutter/material.dart';
import 'package:ocr_barcode_flutter/screen/addProduct/add_product.dart';
import 'package:ocr_barcode_flutter/screen/complaint/all_complaint.dart';
import 'package:ocr_barcode_flutter/screen/login/login_screen.dart';
import 'package:ocr_barcode_flutter/screen/updateProduct/all_product.dart';
import 'package:ocr_barcode_flutter/widget/header_logo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminScreen extends StatefulWidget {
  final String username;
  AdminScreen({this.username});
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
                    HeaderLogo(),
                    SizedBox(
                      height: 100,
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
                                builder: (context) => AddProduct(
                                  username: widget.username,
                                ),
                              ),
                            );
                          },
                          child: Text('Add Product'),
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
                                builder: (context) => AllProduct(
                                  username: widget.username,
                                ),
                              ),
                            );
                          },
                          child: Text('Update Product'),
                          style: OutlinedButton.styleFrom(
                            shape: BeveledRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
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
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AllComplaint(),
                              ),
                            );
                          },
                          child: Text('View Complaint'),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(5), // <-- Radius
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  left: 5,
                  top: 5,
                  child: InkWell(
                    onTap: () async {
                      final pref = await SharedPreferences.getInstance();
                      await pref.clear();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                      );
                    },
                    child: Icon(
                      Icons.logout,
                      size: 35,
                    ),
                  ),
                ),
                HeaderLogoHalal(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
