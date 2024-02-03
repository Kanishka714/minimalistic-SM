import 'package:flutter/material.dart';
import 'package:socialmedia/pages/login_page.dart';
import 'package:socialmedia/pages/register_page.dart';
import 'package:socialmedia/themes/dark_mode.dart';
import 'package:socialmedia/themes/light_mode.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(onTap: () {  },),
      theme: lightMode,
      darkTheme: darkMode,
    );
  }
}
