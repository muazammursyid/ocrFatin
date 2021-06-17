import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ocr_barcode_flutter/screen/addProduct/api/addProductAPI.dart';

import 'model/allBrandedmodel.dart';
import 'model/listAllCompany.dart';

class AddProduct extends StatefulWidget {
  final String username;
  AddProduct({Key key, this.username}) : super(key: key);

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final productNameText = TextEditingController();
  final expiredDateText = TextEditingController();
  final brandText = TextEditingController();
  final referenceNumberText = TextEditingController();
  final companyNameText = TextEditingController();
  List<Datum> listCompany = [];
  var idxCompany;
  List<Branded> listbranded = [];
  var idxBranded;
  String expiredForApi;
  bool loading = false;

  @override
  void initState() {
    AddProductAPI.getAllCompanyName().then((value) {
      AddProductAPI.getAlbrand().then((value2) {
        setState(() {
          listCompany = value;
          listbranded = value2;
        });
      });
    });
    super.initState();
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
                        Center(
                          child: Stack(
                            children: [
                              Container(
                                width: 200.0,
                                height: 200.0,
                                decoration: new BoxDecoration(
                                  color: const Color(0xff7c94b6),
                                  image: new DecorationImage(
                                    image: AssetImage(
                                        'assets/images/noImage.jpeg'),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: new BorderRadius.all(
                                      new Radius.circular(15.0)),
                                  border: new Border.all(
                                    color: Colors.blue,
                                    width: 1.0,
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 1,
                                bottom: 1,
                                child: CircleAvatar(
                                  backgroundColor: Colors.blue,
                                  radius: 20,
                                  child: IconButton(
                                    padding: EdgeInsets.zero,
                                    icon: Icon(Icons.edit),
                                    color: Colors.white,
                                    onPressed: () {},
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        makeInput(
                            label: "Product Name",
                            controllerText: productNameText),
                        makeInput(
                            label: "Halal Status Expiry Date",
                            controllerText: expiredDateText,
                            onTap: () {
                              showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2015, 8),
                                      lastDate: DateTime(2101))
                                  .then((pickedDate) {
                                expiredDateText.text =
                                    DateFormat('dd/MM/yyy').format(pickedDate);
                                expiredForApi =
                                    DateFormat('yyyy-MM-dd').format(pickedDate);
                              });
                            }),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 2),
                          child: Text(
                            'Brand',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.black87),
                          ),
                        ),
                        Container(
                            margin: const EdgeInsets.only(
                                left: 20, right: 20, top: 2),
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              border: new Border.all(
                                color: Colors.grey[400],
                                // width: 0.6,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              color: Colors.white,
                            ),
                            child: DropdownButtonHideUnderline(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 14.0, right: 14),
                                child: DropdownButton(
                                  isExpanded: true,
                                  dropdownColor: Colors.white,
                                  value: idxBranded,
                                  items: listbranded.map((e) {
                                    return DropdownMenuItem(
                                        child: Text(e.name), value: e.idx);
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      idxBranded = value;
                                    });
                                  },
                                ),
                              ),
                            )),
                        SizedBox(
                          height: 30,
                        ),
                        makeInput(
                            label: "Reference Number",
                            controllerText: referenceNumberText),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 2),
                          child: Text(
                            'Company Name',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.black87),
                          ),
                        ),
                        Container(
                            margin: const EdgeInsets.only(
                                left: 20, right: 20, top: 2),
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              border: new Border.all(
                                color: Colors.grey[400],
                                // width: 0.6,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              color: Colors.white,
                            ),
                            child: DropdownButtonHideUnderline(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 14.0, right: 14),
                                child: DropdownButton(
                                  isExpanded: true,
                                  dropdownColor: Colors.white,
                                  value: idxCompany,
                                  items: listCompany.map((e) {
                                    return DropdownMenuItem(
                                        child: Text(e.name), value: e.idx);
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      idxCompany = value;
                                    });
                                  },
                                ),
                              ),
                            )),
                        SizedBox(
                          height: 30,
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
                                String createDateNow =
                                    DateFormat('yyyy-MM-dd').format(now);
                                var jsons = {
                                  "name": productNameText.text,
                                  "no_ref": referenceNumberText.text,
                                  "company_id": idxCompany,
                                  "brand_id": idxBranded,
                                  "expired_date": expiredForApi,
                                  "create_by": widget.username,
                                  "create_date": createDateNow,
                                  "update_by": widget.username,
                                  "update_date": createDateNow,
                                  "imagebinary": "",
                                  "filename": "",
                                  "filetype": "",
                                };
                                AddProductAPI.getApiAddProduct(jsons, context)
                                    .then((value) {
                                  setState(() {
                                    loading = false;
                                  });
                                });
                              },
                              child: Text('Add Product'),
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
                          height: 80,
                        ),
                      ],
                    ),
                    Positioned(
                      left: 5,
                      top: 5,
                      child: Row(
                        children: [
                          BackButton(),
                          Text(
                            'Add Product',
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
            controller: controllerText,
            onTap: onTap,
            readOnly: label == 'Halal Status Expiry Date' ? true : false,
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
