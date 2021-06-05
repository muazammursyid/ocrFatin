import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:ocr_barcode_flutter/screen/home/api/homeApi.dart';
import 'package:ocr_barcode_flutter/screen/login/login_screen.dart';
import 'package:ocr_barcode_flutter/screen/scannerProduct/scanner_screen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController searchText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
              image: AssetImage("assets/images/backgroundhalal.png"),
              fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
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
                Text(
                  'WELCOME TO HALAL SCANNER',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ScannerScreen(),
                      ),
                    );
                  },
                  child: buildContainer('assets/images/scanlottie.json',
                      'SCAN HALAL PRODUCT', 60),
                ),
                InkWell(
                  onTap: () {
                    openAlertBox();
                  },
                  child: buildContainer('assets/images/searchlottie.json',
                      'SEARCH HALAL\nPRODUCT', 10),
                ),
                Text(
                  'Click On The Link Bellow For',
                  style: TextStyle(color: Colors.black),
                ),
                RichText(
                  text: new TextSpan(
                    children: [
                      new TextSpan(
                        text: 'Admin Log In : ',
                        style: new TextStyle(color: Colors.black),
                      ),
                      new TextSpan(
                        text: 'Admin Login',
                        style: new TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: new TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(),
                              ),
                            );
                          },
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

  Container buildContainer(assetName, title, double top) {
    return Container(
      margin: EdgeInsets.only(top: top, left: 30, right: 30, bottom: 10),
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 5,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
          border: Border.all(color: Colors.grey)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 20,
          ),
          Container(
            width: 100,
            height: double.infinity,
            child: Lottie.asset(assetName),
          ),
          Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.w500, color: Colors.black, fontSize: 16),
          ),
        ],
      ),
    );
  }

  openAlertBox() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            contentPadding: EdgeInsets.only(top: 10.0),
            content: Container(
              width: 300.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    "Search Product",
                    style: TextStyle(
                        fontSize: 24.0,
                        color: Colors.green,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Divider(
                    color: Colors.grey,
                    height: 4.0,
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
                    child: Container(
                      height: 50.0,
                      width: double.infinity,
                      child: TextField(
                        controller: searchText,
                        textInputAction: TextInputAction.search,
                        decoration: InputDecoration(
                          hintText: "Search...",
                          border: InputBorder.none,
                          contentPadding:
                              EdgeInsets.only(left: 15.0, top: 15.0),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.search),
                            iconSize: 30.0,
                            onPressed: () {},
                          ),
                        ),
                        onSubmitted: (term) {},
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  InkWell(
                    onTap: () {
                      HomeApi.getSearchByProduct(searchText.text, context);
                    },
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(32.0),
                            bottomRight: Radius.circular(32.0)),
                      ),
                      child: Text(
                        "Search",
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
