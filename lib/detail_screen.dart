import 'dart:io';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class DetailScreen extends StatefulWidget {
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  String selectedItem = '';
  final picker = ImagePicker();
  File imageFile;
  TextEditingController comment = TextEditingController();
  bool isImageLoaded = false;

  var result = '';

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
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ),
      );
      if (mounted) {
        if (imageCrop != null) {
          this.setState(() {
            imageFile = imageCrop;
            isImageLoaded = true;
          });
        } else {}
      }
    }
    Navigator.of(context).pop();
  }

  _openGallery(BuildContext context) async {
    var pitcure =
        await picker.getImage(source: ImageSource.gallery, maxWidth: 600);
    if (pitcure != null) {
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
            isImageLoaded = true;
          });
        } else {}
      }
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
          setState(() {
            result = result + ' ' + word.text;
            comment.text = result;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    selectedItem = ModalRoute.of(context).settings.arguments.toString();

    return Scaffold(
      appBar: AppBar(
        title: Text(selectedItem),
        actions: [
          RaisedButton(
            onPressed: () => _showChoiceDialog(context),
            child: Icon(
              Icons.camera,
              color: Colors.white,
            ),
            color: Colors.blue,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
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
                : Container(),
            SizedBox(
              height: 30,
            ),
            isImageLoaded
                ? Padding(
                    padding:
                        const EdgeInsets.only(top: 16, left: 32, right: 32),
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
                                left: 10, right: 10, top: 0, bottom: 0),
                            child: TextField(
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
                : SizedBox()
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: readTextFromanImage,
        child: Icon(
          Icons.check,
        ),
      ),
    );
  }
}
