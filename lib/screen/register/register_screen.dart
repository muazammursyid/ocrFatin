import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ocr_barcode_flutter/widget/custom_dialog.dart';
import 'package:ocr_barcode_flutter/widget/header_logo.dart';

import 'api/registerAPI.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool loading = false;
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();

  bool validateUsername = false;
  bool validatePassword = false;
  bool validateConfirmPassword = false;
  bool validateFullName = false;
  bool validateEmail = false;

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
                            height: 70,
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
                          validateUsername
                              ? errorEmpty('Username can\'t be blank')
                              : SizedBox(),
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: TextField(
                              controller: fullNameController,
                              obscureText: false,
                              decoration: InputDecoration(
                                hintText: 'Full Name',
                                suffixIcon: Icon(Icons.badge),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
                            ),
                          ),
                          validateFullName
                              ? errorEmpty('Full name can\'t be blank')
                              : SizedBox(),
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: TextField(
                              controller: emailController,
                              obscureText: false,
                              decoration: InputDecoration(
                                hintText: 'Email',
                                suffixIcon: Icon(Icons.email),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
                            ),
                          ),
                          validateEmail
                              ? errorEmpty('Email can\'t be blank')
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
                          validatePassword
                              ? errorEmpty('Password can\'t be blank')
                              : SizedBox(),
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: TextField(
                              controller: confirmPasswordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: 'Confirm Password',
                                suffixIcon: Icon(Icons.lock),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
                            ),
                          ),
                          validateConfirmPassword
                              ? errorEmpty('Confirm Password can\'t be blank')
                              : SizedBox(),
                          SizedBox(
                            height: 30,
                          ),
                          Align(
                            child: SizedBox(
                              height: 50,
                              width: 150,
                              child: ElevatedButton(
                                onPressed: () {
                                  checkEmptyField();
                                  checkValiation();
                                },
                                child: Text('REGISTER'),
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
                            height: 50,
                          ),
                        ],
                      ),
                      Positioned(
                        left: 5,
                        top: 5,
                        child: BackButton(),
                      ),
                      HeaderLogoHalal(),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  checkEmptyField() {
    setState(() {
      userNameController.text.isEmpty
          ? validateUsername = true
          : validateUsername = false;
      passwordController.text.isEmpty
          ? validatePassword = true
          : validatePassword = false;
      confirmPasswordController.text.isEmpty
          ? validateConfirmPassword = true
          : validateConfirmPassword = false;
      fullNameController.text.isEmpty
          ? validateFullName = true
          : validateFullName = false;
      emailController.text.isEmpty
          ? validateEmail = true
          : validateEmail = false;
    });
  }

  checkValiation() {
    if (!validateUsername &&
        !validatePassword &&
        !validateConfirmPassword &&
        !validateFullName &&
        !validateEmail) {
      if (passwordController.text == confirmPasswordController.text) {
        setState(() {
          loading = true;
        });
        DateTime now = DateTime.now();
        String createDate = DateFormat('yyyy-MM-dd').format(now);
        var jsons = {
          "username": userNameController.text,
          "password": passwordController.text,
          "email": emailController.text,
          "fullname": fullNameController.text,
          "user_role": 'user',
          "trans_last_seen": createDate + " 00:00:00",
          "create_by": "admin",
          "create_date": createDate + " 00:00:00",
          "update_by": "admin",
          "update_date": createDate + " 00:00:00"
        };
        RegisterAPI.registerAPI(jsons, context).then((value) {
          setState(() {
            loading = false;
          });
        });
      } else {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return CustomDialogBox(
                title: "Unsuccessful !",
                descriptions:
                    "Your password and confirm password is not match. Please try again",
                text: "Ok",
              );
            });
      }
    }
  }

  Padding errorEmpty(alert) {
    return Padding(
      padding: const EdgeInsets.only(left: 30),
      child: Text(
        alert,
        style: TextStyle(color: Colors.redAccent),
      ),
    );
  }
}
