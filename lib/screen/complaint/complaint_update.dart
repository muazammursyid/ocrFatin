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
                  makeInput(
                      label: "Product Name", controllerText: productNameText),
                  makeInput(
                      label: "Company Name", controllerText: companyNameText),
                  makeInput(
                      label: "Complaint", controllerText: complaintProductText),
                  makeInput(label: "Username", controllerText: usernameText),
                  makeInput(
                      label: "Number Telephone", controllerText: userTelefone),
                  makeInput(label: "User Email", controllerText: userEmail),
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
                          DateTime now = DateTime.now();
                          String updateDate =
                              DateFormat('dd/MM/yyyy').format(now);
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
                          ComplainAPI.getUpdateComplaint(jsons, context);
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
