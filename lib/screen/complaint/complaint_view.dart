import 'package:flutter/material.dart';
import 'package:ocr_barcode_flutter/screen/complaint/complaint_update.dart';
import 'package:ocr_barcode_flutter/screen/home/api/homeApi.dart';
import 'package:ocr_barcode_flutter/screen/home/models/complaintData.dart';

class ComplaintView extends StatefulWidget {
  List<DatumComplaint> listComplaint = [];
  final String myEmail;
  ComplaintView({Key key, this.listComplaint, this.myEmail}) : super(key: key);

  @override
  _ComplaintViewState createState() => _ComplaintViewState();
}

class _ComplaintViewState extends State<ComplaintView> {
  List<DatumComplaint> listComplaint = [];
  String myEmail;
  @override
  void initState() {
    super.initState();
    setState(() {
      listComplaint = widget.listComplaint;
      myEmail = widget.myEmail;
    });
  }

  refreshList() {
    HomeApi.getMyComplaint(widget.myEmail, context, true).then((value) {
      setState(() {
        listComplaint = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    SizedBox(
                      height: 60,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total Complaint : ${listComplaint.length}'
                              .toUpperCase(),
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      children: listComplaint.map((item) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ComplaintUpdate(
                                  detailsComplaint: item,
                                ),
                              ),
                            ).then((value) {
                              refreshList();
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.only(top: 20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 3,
                                  blurRadius: 7,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, top: 10, bottom: 10),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  buildRowContent(
                                      'Product Name', item.productName),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  buildRowContent(
                                      'Company Name', item.companyName),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  buildRowContent('Complaint', item.complaint),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  buildRowContent('Username', item.userName),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  buildRowContent(
                                      'Created Date', item.createDate),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Icon(Icons.arrow_forward_ios),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    )
                  ],
                ),
              ),
              Positioned(
                left: 5,
                top: 5,
                child: Row(
                  children: [
                    BackButton(),
                    Text(
                      'My Complaint',
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
    );
  }

  Row buildRowContent(title, value) {
    return Row(
      children: [
        Container(
          width: 120,
          child: Row(
            children: [
              Text(
                title,
                softWrap: true,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              Spacer(),
              Text(
                ':',
                softWrap: true,
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        SizedBox(
          width: 8,
        ),
        Expanded(
          child: Text(
            value,
            softWrap: true,
            style: TextStyle(fontSize: 18),
          ),
        ),
      ],
    );
  }
}
