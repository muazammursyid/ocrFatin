import 'package:flutter/material.dart';
import 'package:ocr_barcode_flutter/screen/login/api/loginAPI.dart';
import 'package:ocr_barcode_flutter/screen/register/register_screen.dart';
import 'package:ocr_barcode_flutter/widget/header_logo.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  bool userNameValidate = false;
  bool passwordValidate = false;
  bool loading = false;
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
        body: loading
            ? Center(child: CircularProgressIndicator())
            : SafeArea(
                child: SingleChildScrollView(
                  child: Stack(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          HeaderLogo(),
                          SizedBox(
                            height: 70.0,
                          ),
                          Align(
                            child: Text(
                              'LOGIN',
                              style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25),
                            ),
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: TextField(
                              controller: userNameController,
                              decoration: InputDecoration(
                                hintText: 'Username',
                                suffixIcon: Icon(Icons.person),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
                            ),
                          ),
                          userNameValidate
                              ? Padding(
                                  padding: const EdgeInsets.only(left: 30),
                                  child: Text(
                                    'Username can\'t be blank',
                                    style: TextStyle(color: Colors.redAccent),
                                  ),
                                )
                              : SizedBox(),
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: TextField(
                              controller: passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: 'Password',
                                suffixIcon: Icon(Icons.lock),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
                            ),
                          ),
                          passwordValidate
                              ? Padding(
                                  padding: const EdgeInsets.only(left: 30),
                                  child: Text(
                                    'Password can\'t be blank',
                                    style: TextStyle(color: Colors.redAccent),
                                  ),
                                )
                              : SizedBox(),
                          SizedBox(
                            height: 15, //adjust kt sni
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            child: SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: RaisedButton(
                                onPressed: () {
                                  checkValidation();
                                  passValidation();
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(80.0)),
                                padding: const EdgeInsets.all(0.0),
                                child: Ink(
                                  decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: <Color>[
                                        Color(0xFF4527A0),
                                        Color(0xFF512DA8),
                                        Color(0xFFEF9A9A)
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
                                      'Login',
                                      style: TextStyle(color: Colors.white),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            child: SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: RaisedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => RegisterScreen(),
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
                                        Color(0xFF455A64),
                                        Color(0xFF546E7A),
                                        Color(0xFFEF9A9A)
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
                                      'Register',
                                      style: TextStyle(color: Colors.white),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      HeaderLogoHalal(),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  checkValidation() {
    setState(() {
      userNameController.text.isEmpty
          ? userNameValidate = true
          : userNameValidate = false;
      passwordController.text.isEmpty
          ? passwordValidate = true
          : passwordValidate = false;
    });
  }

  passValidation() {
    if (!userNameValidate && !passwordValidate) {
      setState(() {
        loading = true;
      });
      var jsons = {
        "user": userNameController.text,
        "pass": passwordController.text
      };
      LoginAPI.loginApi(jsons, context).then((value) {
        setState(() {
          loading = false;
        });
      });
    }
  }
}
