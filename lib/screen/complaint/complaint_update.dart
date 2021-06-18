import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ocr_barcode_flutter/screen/home/models/complaintData.dart';

import 'api/complaintAPI.dart';

class ComplaintUpdate extends StatefulWidget {
  final DatumComplaint detailsComplaint;

  ComplaintUpdate({Key key, this.detailsComplaint}) : super(key: key);

  @override
  _ComplaintUpdateState createState() => _ComplaintUpdateState();
}

class _ComplaintUpdateState extends State<ComplaintUpdate> {
  final productNameText = TextEditingController();
  final companyNameText = TextEditingController();
  final complaintProductText = TextEditingController();
  final usernameText = TextEditingController();
  final userTelefone = TextEditingController();
  final userEmail = TextEditingController();
  String createBy, createDate, updateBy, updateDate;

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
    setState(() {
      productNameText.text = widget.detailsComplaint.productName;
      companyNameText.text = widget.detailsComplaint.companyName;
      complaintProductText.text = widget.detailsComplaint.complaint;
      usernameText.text = widget.detailsComplaint.userName;
      userTelefone.text = widget.detailsComplaint.userTelephone;
      userEmail.text = widget.detailsComplaint.userEmail;
      createBy = widget.detailsComplaint.createBy;
      createDate = widget.detailsComplaint.createDate;
      updateBy = widget.detailsComplaint.updateBy;
      updateDate = widget.detailsComplaint.updateDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: SafeArea(
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 80,
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
                            ? errorEmpty('User Email Telephone can\'t be blank')
                            : SizedBox(),
                        SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30, right: 40),
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
                                    'Update',
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
                    Positioned(
                      left: 5,
                      top: 5,
                      child: Row(
                        children: [
                          BackButton(),
                          Text(
                            'Update Complaint',
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

  Padding errorEmpty(alert) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Text(
        alert,
        style: TextStyle(color: Colors.redAccent),
      ),
    );
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
      String updateDate = DateFormat('yyyy-MM-dd').format(now);
      var jsons = {
        "idx": widget.detailsComplaint.idx,
        "product_name": productNameText.text,
        "company_name": companyNameText.text,
        "complaint": companyNameText.text,
        "user_name": usernameText.text,
        "user_telephone": userTelefone.text,
        "user_email": userEmail.text,
        "create_by": createBy,
        "create_date": createDate,
        "update_by": userEmail.text,
        "update_date": updateDate,
      };
      ComplainAPI.getUpdateComplaint(jsons, context).then((value) {
        setState(() {
          loading = false;
        });
      });
    }
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
