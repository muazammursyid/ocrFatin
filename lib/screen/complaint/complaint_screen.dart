import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api/complaintAPI.dart';

class ComplaintScreen extends StatefulWidget {
  ComplaintScreen({Key key}) : super(key: key);

  @override
  _ComplaintScreenState createState() => _ComplaintScreenState();
}

class _ComplaintScreenState extends State<ComplaintScreen> {
  final productNameText = TextEditingController();
  final companyNameText = TextEditingController();
  final complaintProductText = TextEditingController();
  final usernameText = TextEditingController();
  final userTelefone = TextEditingController();
  final userEmail = TextEditingController();

  bool validateProductName = false;
  bool validateCompanyName = false;
  bool validateComplaintProduct = false;
  bool validateUsername = false;
  bool validateTelephone = false;
  bool validateUserEmail = false;

  bool loading = false;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      usernameText.text = prefs.getString('username');
      userEmail.text = prefs.getString('email');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Complaint Product',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.indigo[200],
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SafeArea(
                child: SingleChildScrollView(
                  child: Stack(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          makeInput(
                              label: "Product Name",
                              controllerText: productNameText,
                              disable: false),
                          validateProductName
                              ? errorEmpty('Product Name can\'t be blank')
                              : SizedBox(),
                          SizedBox(
                            height: 20,
                          ),
                          makeInput(
                              label: "Company Name",
                              controllerText: companyNameText,
                              disable: false),
                          validateCompanyName
                              ? errorEmpty('Company Name can\'t be blank')
                              : SizedBox(),
                          SizedBox(
                            height: 20,
                          ),
                          makeInput(
                              label: "Complaint",
                              controllerText: complaintProductText,
                              disable: false),
                          validateComplaintProduct
                              ? errorEmpty('Complaint can\'t be blank')
                              : SizedBox(),
                          SizedBox(
                            height: 20,
                          ),
                          makeInput(
                              label: "Username",
                              controllerText: usernameText,
                              disable: true),
                          validateUsername
                              ? errorEmpty('Username can\'t be blank')
                              : SizedBox(),
                          SizedBox(
                            height: 20,
                          ),
                          makeInput(
                              label: "Number Telephone",
                              controllerText: userTelefone,
                              disable: false),
                          validateTelephone
                              ? errorEmpty('Number Telephone can\'t be blank')
                              : SizedBox(),
                          SizedBox(
                            height: 20,
                          ),
                          makeInput(
                              label: "User Email",
                              controllerText: userEmail,
                              disable: true),
                          validateUserEmail
                              ? errorEmpty(
                                  'User Email Telephone can\'t be blank')
                              : SizedBox(),
                          SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 30, right: 40),
                            child: SizedBox(
                              height: 50,
                              width: double.infinity,
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
                                        Color(0xFF4CAF50),
                                        Color(0xFF66BB6A),
                                        Color(0xFF81C784)
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
                                      'Submit',
                                      style: TextStyle(color: Colors.white),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          )
                        ],
                      ),
                      // Positioned(
                      //   left: 5,
                      //   top: 5,
                      //   child: Row(
                      //     children: [
                      //       BackButton(),
                      //       Text(
                      //         'Complaint Product',
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

  Padding errorEmpty(alert) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Text(
        alert,
        style: TextStyle(color: Colors.redAccent),
      ),
    );
  }

  passValidation() {
    if (!validateProductName &&
        !validateCompanyName &&
        !validateComplaintProduct &&
        !validateUsername &&
        !validateTelephone &&
        !validateUserEmail) {
      setState(() {
        loading = true;
      });
      DateTime now = DateTime.now();
      String createDate = DateFormat('yyyy-MM-dd').format(now);
      var jsons = {
        "product_name": productNameText.text,
        "company_name": companyNameText.text,
        "complaint": companyNameText.text,
        "user_name": usernameText.text,
        "user_telephone": userTelefone.text,
        "user_email": userEmail.text,
        "create_by": userEmail.text,
        "create_date": createDate,
        "update_by": userEmail.text,
        "update_date": createDate,
      };
      ComplainAPI.getInsertComplaint(jsons, context).then((value) {
        setState(() {
          loading = false;
        });
      });
    }
  }

  checkValidation() {
    setState(() {
      productNameText.text.isEmpty
          ? validateProductName = true
          : validateProductName = false;
      companyNameText.text.isEmpty
          ? validateCompanyName = true
          : validateCompanyName = false;
      complaintProductText.text.isEmpty
          ? validateComplaintProduct = true
          : validateComplaintProduct = false;
      usernameText.text.isEmpty
          ? validateUsername = true
          : validateUsername = false;
      userTelefone.text.isEmpty
          ? validateTelephone = true
          : validateTelephone = false;
      userEmail.text.isEmpty
          ? validateUserEmail = true
          : validateUserEmail = false;
    });
  }

  Widget makeInput({
    label,
    TextEditingController controllerText,
    Function onTap,
    bool disable,
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
          TextField(
            onTap: onTap,
            readOnly: disable,
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
        ],
      ),
    );
  }
}
