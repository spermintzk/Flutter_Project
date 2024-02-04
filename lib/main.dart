import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project1/controller/RequestController.dart';
import 'package:project1/screens/Homepage.dart';
import 'package:project1/screens/NewsPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // home: HomePage(),
      home: NewsPage(),
      initialBinding: InitialBinding(),
    );
  }
}

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(RequestTimeDateController());
  }
}
