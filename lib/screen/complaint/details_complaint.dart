import 'package:flutter/material.dart';

import 'model/allComplaintModel.dart';

class DetailsComplaint extends StatefulWidget {
  final Datum detailsComplaint;
  DetailsComplaint({this.detailsComplaint});
  @override
  _DetailsComplaintState createState() => _DetailsComplaintState();
}

class _DetailsComplaintState extends State<DetailsComplaint> {
  final productNameText = TextEditingController();
  final companyNameText = TextEditingController();
  final complaintProductText = TextEditingController();
  final usernameText = TextEditingController();
  final userTelefone = TextEditingController();
  final userEmail = TextEditingController();
  String createBy, createDate, updateBy, updateDate;

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
      appBar: AppBar(
        title: Text(
          'Details Complaint',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.indigo[200],
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: SafeArea(
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 30,
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
                    //         'Details Complaint',
                    //         style: TextStyle(
                    //             fontWeight: FontWeight.bold,
                    //             color: Colors.black,
                    //             fontSize: 18),
                    //       ),
                    //     ],
                    //   ),
                    // ),
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
