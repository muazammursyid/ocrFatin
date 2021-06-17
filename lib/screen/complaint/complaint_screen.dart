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
        body: loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SafeArea(
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
                          makeInput(
                              label: "Product Name",
                              controllerText: productNameText),
                          makeInput(
                              label: "Company Name",
                              controllerText: companyNameText),
                          makeInput(
                              label: "Complaint",
                              controllerText: complaintProductText),
                          makeInput(
                              label: "Username", controllerText: usernameText),
                          makeInput(
                              label: "Number Telephone",
                              controllerText: userTelefone),
                          makeInput(
                              label: "User Email", controllerText: userEmail),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 30, right: 40),
                            child: SizedBox(
                              height: 50,
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    loading = true;
                                  });
                                  DateTime now = DateTime.now();
                                  String createDate =
                                      DateFormat('yyyy-MM-dd').format(now);
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
                                  ComplainAPI.getInsertComplaint(jsons, context)
                                      .then((value) {
                                    setState(() {
                                      loading = false;
                                    });
                                  });
                                },
                                child: Text('Submit'),
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
                            height: 20,
                          )
                        ],
                      ),
                      Positioned(
                        left: 5,
                        top: 5,
                        child: Row(
                          children: [
                            BackButton(),
                            Text(
                              'Complaint Product',
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

  Widget makeInput({
    label,
    TextEditingController controllerText,
    Function onTap,
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
