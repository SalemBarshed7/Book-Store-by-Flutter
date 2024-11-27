

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Add.dart';
import 'package:flutter_application_1/SignUp.dart';
import 'package:flutter_application_1/home2.dart';
import 'package:flutter_application_1/information.dart';
import 'package:flutter_application_1/login.dart';
import 'package:flutter_application_1/edit.dart';
import 'package:flutter_application_1/welcome.dart';
import 'package:flutter_application_1/information.dart';




void main()
{
  runApp(StoreApp());
}
class StoreApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'welcome',
    routes: {
      'signup':(context)=>SignUp(),
      'login' :(context)=>Login(),
      'Edit':(context)=>editpage(),
      'welcome':(context)=>WelcomePage(),
      'ADD': (context)=>AddPage(),
      'home22':(context)=>HomePage(username: '', email: '',),
    },
      home: SignUp(),
    );
  }
}






