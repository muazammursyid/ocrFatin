import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ocr_barcode_flutter/screen/addProduct/api/addProductAPI.dart';
import 'package:ocr_barcode_flutter/screen/addProduct/model/allBrandedmodel.dart';
import 'package:ocr_barcode_flutter/screen/addProduct/model/listAllCompany.dart';
import 'package:ocr_barcode_flutter/screen/updateProduct/api/allProductAPI.dart';

class UpdateProduct extends StatefulWidget {
  final String productNAme;
  final String expiredDate;
  final String brandName;
  final String refNumber;
  final String companyNAme;
  final String companyId;
  final String brandId;
  final String createBy;
  final String createDate;
  final String updateBy;
  final String updateDate;
  final String idx;
  final String username;
  final String imageProduct;
  UpdateProduct({
    this.productNAme,
    this.expiredDate,
    this.brandName,
    this.refNumber,
    this.companyNAme,
    this.companyId,
    this.brandId,
    this.createBy,
    this.createDate,
    this.updateBy,
    this.updateDate,
    this.idx,
    this.username,
    this.imageProduct,
  });

  @override
  _UpdateProductState createState() => _UpdateProductState();
}

class _UpdateProductState extends State<UpdateProduct> {
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

  bool productNameValidate = false;
  bool expiredDateValidate = false;
  bool brandValidate = false;
  bool referenceValidate = false;
  bool companyValidate = false;
  bool idxCompanyValidate = false;
  bool idxBrandedValidate = false;

  @override
  void initState() {
    super.initState();
    productNameText.text = widget.productNAme;
    expiredDateText.text = widget.expiredDate;
    brandText.text = widget.brandName;
    referenceNumberText.text = widget.refNumber;
    companyNameText.text = widget.companyNAme;
    setState(() {
      loading = true;
    });
    AddProductAPI.getAllCompanyName().then((value) {
      AddProductAPI.getAlbrand().then((value2) {
        setState(() {
          listCompany = value;
          listbranded = value2;
          idxCompany = widget.companyId;
          idxBranded = widget.brandId;
          setState(() {
            loading = false;
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Update Product',
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
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 30,
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
                                    image: widget.imageProduct != ""
                                        ? NetworkImage(
                                            'https://hayyshop.xyz/image/' +
                                                widget.imageProduct)
                                        : AssetImage(
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
                        productNameValidate
                            ? errorEmpty('Product Name can\'t be blank')
                            : SizedBox(),
                        SizedBox(
                          height: 30,
                        ),
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
                                    DateFormat('yyyy-MM-dd').format(pickedDate);
                              });
                            }),
                        expiredDateValidate
                            ? errorEmpty(
                                'Halal Status Expiry Date can\'t be blank')
                            : SizedBox(),
                        SizedBox(
                          height: 30,
                        ),
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
                        brandValidate
                            ? errorEmpty('Brand can\'t be blank')
                            : SizedBox(),
                        SizedBox(
                          height: 30,
                        ),
                        makeInput(
                            label: "Reference Number",
                            controllerText: referenceNumberText),
                        referenceValidate
                            ? errorEmpty('Reference Number can\'t be blank')
                            : SizedBox(),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                          ],
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
                        companyValidate
                            ? errorEmpty('Company Name can\'t be blank')
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
                                validationCheck();
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
                                    'Update Product',
                                    style: TextStyle(color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
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
                    // Positioned(
                    //   left: 5,
                    //   top: 5,
                    //   child: Row(
                    //     children: [
                    //       BackButton(),
                    //       Text(
                    //         'Add Product',
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

  passValidation() {
    if (!productNameValidate &&
        !expiredDateValidate &&
        !brandValidate &&
        !referenceValidate &&
        !companyValidate) {
      setState(() {
        loading = true;
      });
      DateTime now = DateTime.now();
      String updateDateNow = DateFormat('yyyy-MM-dd').format(now);
      var jsons = {
        "idx": widget.idx,
        "name": productNameText.text,
        "expired_date": expiredDateText.text,
        "no_ref": referenceNumberText.text,
        "company_id": idxCompany,
        "brand_id": idxBranded,
        "create_by": widget.createBy,
        "create_date": widget.createDate,
        "update_by": widget.username,
        "update_date": updateDateNow,
        "imagebinary": "",
        "filename": "",
        "filetype": "",
      };
      UpdateProductAPi.getApiUpdateProduct(jsons, context).then((value) {
        loading = false;
      });
    }
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

  validationCheck() {
    setState(() {
      productNameText.text.isEmpty
          ? productNameValidate = true
          : productNameValidate = false;
      expiredDateText.text.isEmpty
          ? expiredDateValidate = true
          : expiredDateValidate = false;
      idxBranded == null ? brandValidate = true : brandValidate = false;
      referenceNumberText.text.isEmpty
          ? referenceValidate = true
          : referenceValidate = false;
      idxCompany == null ? companyValidate = true : companyValidate = false;
    });
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
            readOnly: label == "Halal Status Expiry Date" ? true : false,
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
