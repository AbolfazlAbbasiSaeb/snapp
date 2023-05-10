import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snapp/Pages/LoginPage.dart';
import 'package:snapp/Pages/home.dart';

void main() => runApp(RunApp());

class RunApp extends StatefulWidget {
  const RunApp({super.key});

  @override
  State<RunApp> createState() => _RunAppState();
}

class _RunAppState extends State<RunApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: LoginPage(),
      // debugShowCheckedModeBanner: false,
    );
  }
}
