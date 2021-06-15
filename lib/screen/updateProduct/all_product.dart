import 'package:flutter/material.dart';
import 'package:ocr_barcode_flutter/screen/addProduct/model/listAllCompany.dart';
import 'package:ocr_barcode_flutter/screen/home/api/homeApi.dart';
import 'package:ocr_barcode_flutter/screen/home/models/searchByProduct.dart';
import 'package:ocr_barcode_flutter/screen/updateProduct/update_product.dart';

import 'api/allProductAPI.dart';
import 'model/allProductModel.dart';

class AllProduct extends StatefulWidget {
  final String username;
  AllProduct({Key key, this.username}) : super(key: key);

  @override
  _AllProductState createState() => _AllProductState();
}

class _AllProductState extends State<AllProduct> {
  List<DatumAll> listProduct = [];
  final searchText = TextEditingController();
  bool isFromSearch = false;
  List<ProductData> listSearch = [];

  @override
  void initState() {
    super.initState();
    refreshApi();
  }

  refreshApi() {
    var jsons = {};
    UpdateProductAPi.getAllProduct(jsons).then((value) {
      setState(() {
        listProduct = value;
        isFromSearch = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 8.0, left: 8.0, right: 8.0),
                      child: Container(
                        height: 50.0,
                        width: double.infinity,
                        child: TextField(
                          controller: searchText,
                          textInputAction: TextInputAction.search,
                          decoration: InputDecoration(
                            hintText:
                                "Search product by brand, company, name & id",
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.only(left: 15.0, top: 15.0),
                            suffixIcon: IconButton(
                              icon: Icon(Icons.search),
                              iconSize: 30.0,
                              onPressed: () {},
                            ),
                          ),
                          onSubmitted: (term) {
                            if (term != "") {
                              HomeApi.getSearchByProduct(term, context, true)
                                  .then((value2) {
                                setState(() {
                                  listSearch = value2;
                                  isFromSearch = true;
                                });
                              });
                            } else {
                              refreshApi();
                            }
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isFromSearch
                              ? 'Total Product : ${listSearch.length}'
                                  .toUpperCase()
                              : 'Total Product : ${listProduct.length}'
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
                    isFromSearch
                        ? Column(
                            children: listSearch.map((item) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => UpdateProduct(
                                        productNAme: item.name,
                                        refNumber: item.noRef,
                                        expiredDate: item.expiredDate,
                                        companyNAme: item.companyName,
                                        brandName: item.brandName,
                                        companyId: item.companyId,
                                        brandId: item.brandId,
                                        createBy: item.createBy,
                                        createDate: item.createDate,
                                        updateBy: item.updateBy,
                                        idx: item.idx,
                                        username: widget.username,
                                      ),
                                    ),
                                  ).then((value) => refreshApi());
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      height: 180,
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
                                            offset: Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Container(
                                            width: 120.0,
                                            height: 120,
                                            decoration: new BoxDecoration(
                                              image: new DecorationImage(
                                                image: AssetImage(
                                                    'assets/images/susu.jpg'),
                                                fit: BoxFit.cover,
                                              ),
                                              borderRadius: new BorderRadius
                                                      .all(
                                                  new Radius.circular(15.0)),
                                              border: new Border.all(
                                                color: Colors.black,
                                                width: 1.0,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Text(
                                                  'Name : ' + item.name,
                                                  softWrap: true,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  height: 4,
                                                ),
                                                Text(
                                                  'No Ref : ' + item.noRef,
                                                  softWrap: true,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w300),
                                                ),
                                                SizedBox(
                                                  height: 4,
                                                ),
                                                Text(
                                                  'Halal Status Expiry Date : ' +
                                                      item.expiredDate,
                                                  softWrap: true,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w300),
                                                ),
                                                SizedBox(
                                                  height: 4,
                                                ),
                                                Expanded(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      Expanded(
                                                        child: SizedBox(
                                                            width: double
                                                                .infinity),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(right: 8),
                                                        child: Icon(Icons
                                                            .arrow_forward),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          )
                        : Column(
                            children: listProduct.map((item) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => UpdateProduct(
                                        productNAme: item.name,
                                        refNumber: item.noRef,
                                        expiredDate: item.expiredDate,
                                        companyNAme: item.companyName,
                                        brandName: item.brandName,
                                        companyId: item.companyId,
                                        brandId: item.brandId,
                                        createBy: item.createBy,
                                        createDate: item.createDate,
                                        updateBy: item.updateBy,
                                        idx: item.idx,
                                        username: widget.username,
                                      ),
                                    ),
                                  ).then((value) => refreshApi());
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      height: 180,
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
                                            offset: Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Container(
                                            width: 120.0,
                                            height: 120,
                                            decoration: new BoxDecoration(
                                              image: new DecorationImage(
                                                image: AssetImage(
                                                    'assets/images/susu.jpg'),
                                                fit: BoxFit.cover,
                                              ),
                                              borderRadius: new BorderRadius
                                                      .all(
                                                  new Radius.circular(15.0)),
                                              border: new Border.all(
                                                color: Colors.black,
                                                width: 1.0,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Text(
                                                  'Name : ' + item.name,
                                                  softWrap: true,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  height: 4,
                                                ),
                                                Text(
                                                  'No Ref : ' + item.noRef,
                                                  softWrap: true,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w300),
                                                ),
                                                SizedBox(
                                                  height: 4,
                                                ),
                                                Text(
                                                  'Halal Status Expiry Date : ' +
                                                      item.expiredDate,
                                                  softWrap: true,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w300),
                                                ),
                                                SizedBox(
                                                  height: 4,
                                                ),
                                                Expanded(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      Expanded(
                                                        child: SizedBox(
                                                            width: double
                                                                .infinity),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(right: 8),
                                                        child: Icon(Icons
                                                            .arrow_forward),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                  ],
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
                      'List Of Product',
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
}
