import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ocr_barcode_flutter/screen/home/home_page.dart';
import 'package:ocr_barcode_flutter/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Plant',
      theme: theme(),
      home: HomePage(),
    );
  }
}
