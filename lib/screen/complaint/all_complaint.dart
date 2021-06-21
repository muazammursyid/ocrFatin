import 'package:flutter/material.dart';

import 'api/complaintAPI.dart';
import 'details_complaint.dart';
import 'model/allComplaintModel.dart';

class AllComplaint extends StatefulWidget {
  AllComplaint({Key key}) : super(key: key);

  @override
  _AllComplaintState createState() => _AllComplaintState();
}

class _AllComplaintState extends State<AllComplaint> {
  List<Datum> listAllComplaint = [];
  bool loading = true;
  @override
  void initState() {
    super.initState();
    ComplainAPI.getAllComplaint().then((value) {
      setState(() {
        print(value);
        listAllComplaint = value;
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'All Complaint',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.indigo[200],
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: SafeArea(
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Total Complaint : ${listAllComplaint.length}'
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
                            children: listAllComplaint.map((item) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailsComplaint(
                                        detailsComplaint: item,
                                      ),
                                    ),
                                  );
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
                                        left: 10,
                                        right: 10,
                                        top: 10,
                                        bottom: 10),
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
                                        buildRowContent(
                                            'Complaint', item.complaint),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        buildRowContent(
                                            'Username', item.userName),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        buildRowContent(
                                            'Created Date', item.createDate),
                                        SizedBox(
                                          height: 5,
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
                    // Positioned(
                    //   left: 5,
                    //   top: 5,
                    //   child: Row(
                    //     children: [
                    //       BackButton(),
                    //       Text(
                    //         'My Complaint',
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
    );
  }

  Row buildRowContent(title, value) {
    return Row(
      children: [
        Container(
          width: 145,
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
