import 'dart:async';
import 'dart:io';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ocr_barcode_flutter/screen/home/api/homeApi.dart';
import 'package:ocr_barcode_flutter/widget/header_logo.dart';

class ScannerScreen extends StatefulWidget {
  @override
  _ScannerScreenState createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  String selectedItem = '';
  final picker = ImagePicker();
  File imageFile;
  TextEditingController comment = TextEditingController();
  bool isImageLoaded = false;

  var result = '';
  bool loading = false;

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          title: Text(
            "Add Image",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                  child: Text("Choose from gallery"),
                  onTap: () {
                    _openGallery(context);
                  },
                ),
                Divider(),
                Padding(
                  padding: EdgeInsets.all(8.0),
                ),
                GestureDetector(
                  child: Text("Take photo"),
                  onTap: () {
                    _openCamera(context);
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }

  _openCamera(BuildContext context) async {
    var pitcure =
        await picker.getImage(source: ImageSource.camera, imageQuality: 50);
    if (pitcure != null) {
      setState(() {
        comment.text = "";
        loading = true;
      });
      File imageCrop = await ImageCropper.cropImage(
        sourcePath: pitcure.path,
        compressQuality: 100,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          // CropAspectRatioPreset.ratio3x2,
          // CropAspectRatioPreset.original,
          // CropAspectRatioPreset.ratio4x3,
          // CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ),
      );
      if (mounted) {
        if (imageCrop != null) {
          this.setState(() {
            imageFile = imageCrop;
            Timer(Duration(seconds: 10), () {
              readTextFromanImage();
            });
          });
        } else {}
      }
    } else {
      setState(() {
        loading = false;
      });
    }
    Navigator.of(context).pop();
  }

  _openGallery(BuildContext context) async {
    var pitcure =
        await picker.getImage(source: ImageSource.gallery, maxWidth: 600);
    if (pitcure != null) {
      setState(() {
        comment.text = "";
        loading = true;
      });
      File imageCrop = await ImageCropper.cropImage(
          sourcePath: pitcure.path,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
            // CropAspectRatioPreset.ratio3x2,
            // CropAspectRatioPreset.original,
            // CropAspectRatioPreset.ratio4x3,
            // CropAspectRatioPreset.ratio16x9
          ],
          androidUiSettings: AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.square,
              lockAspectRatio: true),
          iosUiSettings: IOSUiSettings(
            minimumAspectRatio: 1.0,
          ));
      if (mounted) {
        if (imageCrop != null) {
          this.setState(() {
            imageFile = imageCrop;

            Timer(Duration(seconds: 10), () {
              readTextFromanImage();
            });
          });
        } else {}
      }
    } else {
      setState(() {
        loading = false;
      });
    }
    Navigator.of(context).pop();
  }

  readTextFromanImage() async {
    result = '';
    FirebaseVisionImage myImage = FirebaseVisionImage.fromFile(imageFile);
    TextRecognizer recognizeText = FirebaseVision.instance.textRecognizer();
    VisionText readText = await recognizeText.processImage(myImage);

    for (TextBlock block in readText.blocks) {
      for (TextLine line in block.lines) {
        for (TextElement word in line.elements) {
          print(word.text.length);
          print(word.text.contains('MS'));
          //* kalau jumpa ms auto tknk buat proses
          if (word.text.contains('MS')) {
            print('here');
          } else {
            //* kt sni akan ada no 11 dan 12 so dia looping by bila jumpa 2 no ni
            if (word.text.length == 11) {
              //* once dia da jumpa auto break tknk dia loop lgi dah..
              setState(() {
                result = word.text;
                comment.text = result;
                loading = false;
              });
              break;
            } else if (word.text.length == 12) {
              setState(() {
                result = word.text;
                comment.text = result.substring(1);
                loading = false;
              });
              break;
            } else {
              //* klau tk jumpa no 2 tu dia trus ke sni
              setState(() {
                comment.text = 'Cannot read the image. Please upload again.';
                loading = false;
              });
            }
          }
        }
      }
    }
    setState(() {
      isImageLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
              image: AssetImage("assets/images/backgroundhalal.png"),
              fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            'Halal Scanner',
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
                        children: [
                          HeaderLogo(),
                          SizedBox(
                            height: 70,
                          ),
                          !isImageLoaded
                              ? Text(
                                  'Example image :',
                                  style: TextStyle(color: Colors.redAccent),
                                )
                              : SizedBox(),
                          SizedBox(height: 10),
                          isImageLoaded
                              ? Center(
                                  child: Container(
                                    height: 250.0,
                                    width: 250.0,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: FileImage(imageFile),
                                        onError: (exception, stackTrace) {
                                          return SizedBox();
                                        },
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                )
                              : Center(
                                  child: Container(
                                    height: 250.0,
                                    width: 250.0,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/contoh.jpg'),
                                        onError: (exception, stackTrace) {
                                          return SizedBox();
                                        },
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                          SizedBox(
                            height: 20,
                          ),
                          !isImageLoaded && imageFile != null
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : SizedBox(),
                          isImageLoaded
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                      top: 16, left: 32, right: 32),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5),
                                      boxShadow: <BoxShadow>[
                                        BoxShadow(
                                            color: Colors.grey.withOpacity(0.8),
                                            offset: const Offset(4, 4),
                                            blurRadius: 8),
                                      ],
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: Container(
                                        padding: const EdgeInsets.all(4.0),
                                        constraints: const BoxConstraints(
                                            minHeight: 160, maxHeight: 160),
                                        color: Colors.white,
                                        child: SingleChildScrollView(
                                          padding: const EdgeInsets.only(
                                              left: 10,
                                              right: 10,
                                              top: 0,
                                              bottom: 0),
                                          child: TextField(
                                            readOnly: true,
                                            enableInteractiveSelection: true,
                                            controller: comment,
                                            maxLines: null,
                                            onChanged: (String txt) {},
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.blueGrey,
                                            ),
                                            cursorColor: Colors.blue,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: '',
                                              focusedBorder: InputBorder.none,
                                              enabledBorder: InputBorder.none,
                                              errorBorder: InputBorder.none,
                                              disabledBorder: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : SizedBox(),
                          SizedBox(height: 20),
                          isImageLoaded
                              ? SizedBox(
                                  width: 150,
                                  height: 50,
                                  child: RaisedButton(
                                    onPressed: () {
                                      setState(() {
                                        loading = true;
                                      });
                                      HomeApi.getSearchByProductFromScanner(
                                              comment.text, context)
                                          .then((value) {
                                        setState(() {
                                          loading = false;
                                        });
                                      });
                                    },
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(80.0)),
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
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(80.0)),
                                      ),
                                      child: Container(
                                        constraints: const BoxConstraints(
                                            minWidth: 88.0,
                                            minHeight:
                                                36.0), // min sizes for Material buttons
                                        alignment: Alignment.center,
                                        child: const Text(
                                          'Search Product',
                                          style: TextStyle(color: Colors.white),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : SizedBox(),
                          SizedBox(height: 20),
                          // isImageLoaded
                          //     ? loading
                          //         ? Center(
                          //             child: CircularProgressIndicator(),
                          //           )
                          //         : SizedBox(
                          //             width: 200,
                          //             height: 50,
                          //             child: RaisedButton(
                          //               onPressed: () {
                          //                 setState(() {
                          //                   loading = true;
                          //                 });
                          //                 readTextFromanImage();
                          //               },
                          //               shape: RoundedRectangleBorder(
                          //                   borderRadius:
                          //                       BorderRadius.circular(80.0)),
                          //               padding: const EdgeInsets.all(0.0),
                          //               child: Ink(
                          //                 decoration: const BoxDecoration(
                          //                   gradient: LinearGradient(
                          //                     colors: <Color>[
                          //                       Colors.blue,
                          //                       Colors.blue,
                          //                       Colors.blueAccent
                          //                     ],
                          //                   ),
                          //                   borderRadius: BorderRadius.all(
                          //                       Radius.circular(80.0)),
                          //                 ),
                          //                 child: Container(
                          //                   constraints: const BoxConstraints(
                          //                       minWidth: 88.0,
                          //                       minHeight:
                          //                           36.0), // min sizes for Material buttons
                          //                   alignment: Alignment.center,
                          //                   child: const Text(
                          //                     'Not accurate? Scan Again',
                          //                     style: TextStyle(color: Colors.white),
                          //                     textAlign: TextAlign.center,
                          //                   ),
                          //                 ),
                          //               ),
                          //             ),
                          //           )
                          //     : SizedBox(),
                          SizedBox(height: 20),
                        ],
                      ),
                      // Positioned(
                      //   left: 5,
                      //   top: 30,
                      //   child: BackButton(),
                      // ),
                      HeaderLogoHalal(),
                    ],
                  ),
                ),
              ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          onPressed: () => _showChoiceDialog(context),
          child: Icon(
            Icons.camera,
          ),
        ),
      ),
    );
  }
}
