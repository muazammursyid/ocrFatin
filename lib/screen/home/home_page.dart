import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:ocr_barcode_flutter/screen/home/api/homeApi.dart';
import 'package:ocr_barcode_flutter/screen/login/login_screen.dart';
import 'package:ocr_barcode_flutter/screen/scannerProduct/scanner_screen.dart';
import 'package:ocr_barcode_flutter/widget/header_logo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  final searchText = TextEditingController();
  final emailText = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String username = "";
  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        username = prefs.getString('username');
      });
    });
  }

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
        key: _scaffoldKey,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.indigo[200],
          title: Text(
            'Hello, $username'.toUpperCase() + '👋!',
            style: TextStyle(color: Colors.black, letterSpacing: 2),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.logout,
                color: Colors.black,
              ),
              onPressed: () async {
                final pref = await SharedPreferences.getInstance();
                await pref.clear();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                );
              },
            )
          ],
        ),
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
                      height: 70,
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
                    InkWell(
                      onTap: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        String email = prefs.getString('email');
                        HomeApi.getMyComplaint(email, context).then((value) {
                          setState(() {
                            emailText.text = "";
                            SystemChannels.textInput
                                .invokeMethod('TextInput.hide');
                          });
                        });
                      },
                      child: buildContainer('assets/images/comment.json',
                          'My Complaint'.toUpperCase(), 10),
                    ),
                    // Text(
                    //   'Click On The Link Bellow For',
                    //   style: TextStyle(color: Colors.black),
                    // ),
                    // RichText(
                    //   text: new TextSpan(
                    //     children: [
                    //       new TextSpan(
                    //         text: 'Admin Log In : ',
                    //         style: new TextStyle(color: Colors.black),
                    //       ),
                    //       new TextSpan(
                    //         text: 'Admin Login',
                    //         style: new TextStyle(
                    //           color: Colors.blue,
                    //           decoration: TextDecoration.underline,
                    //           fontWeight: FontWeight.bold,
                    //         ),
                    //         recognizer: new TapGestureRecognizer()
                    //           ..onTap = () {
                    //             Navigator.push(
                    //               context,
                    //               MaterialPageRoute(
                    //                 builder: (context) => LoginScreen(),
                    //               ),
                    //             );
                    //           },
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    SizedBox(
                      height: 50,
                    ),
                  ],
                ),
                // Positioned(
                //   left: 5,
                //   top: 5,
                //   child: InkWell(
                //     onTap: () async {
                //       final pref = await SharedPreferences.getInstance();
                //       await pref.clear();
                //       Navigator.pushReplacement(
                //         context,
                //         MaterialPageRoute(
                //           builder: (context) => LoginScreen(),
                //         ),
                //       );
                //     },
                //     child: Icon(
                //       Icons.logout,
                //       size: 35,
                //     ),
                //   ),
                // ),
                HeaderLogoHalal(),
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

  openDialogComplaint() {
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
                    "Search By Email",
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
                        controller: emailText,
                        textInputAction: TextInputAction.search,
                        decoration: InputDecoration(
                          hintText: "contoh@gmail.com",
                          border: InputBorder.none,
                          contentPadding:
                              EdgeInsets.only(left: 15.0, top: 15.0),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.email),
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
                      Navigator.of(context).pop();
                      HomeApi.getMyComplaint(emailText.text, context)
                          .then((value) {
                        setState(() {
                          emailText.text = "";
                          SystemChannels.textInput
                              .invokeMethod('TextInput.hide');
                        });
                      });
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
                          hintText: "",
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
                    height: 15.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Text(
                      'Note : Search product by brand, company, name & id',
                      style: TextStyle(color: Colors.redAccent),
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                      HomeApi.getSearchByProduct(
                              searchText.text, _scaffoldKey.currentContext)
                          .then((value) {
                        setState(() {
                          searchText.text = "";
                          SystemChannels.textInput
                              .invokeMethod('TextInput.hide');
                        });
                      });
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
