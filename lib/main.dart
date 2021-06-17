import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ocr_barcode_flutter/screen/admin/admin_screen.dart';
import 'package:ocr_barcode_flutter/screen/home/home_page.dart';
import 'package:ocr_barcode_flutter/screen/login/login_screen.dart';
import 'package:ocr_barcode_flutter/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String idx = prefs.getString('idx');
  String role = prefs.getString('userRole');
  print(role);
  runApp(MyApp(
    idx: idx,
    role: role,
  ));
}

class MyApp extends StatelessWidget {
  final String idx;
  final String role;
  MyApp({this.idx, this.role});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Halal Scanner',
      theme: theme(),
      home: idx == null
          ? LoginScreen()
          : role == "admin"
              ? AdminScreen()
              : HomePage(),
    );
  }
}
