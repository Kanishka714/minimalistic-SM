import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:socialmedia/auth/check.dart';
import 'package:socialmedia/auth/login_or_register.dart';
import 'package:socialmedia/firebase_options.dart';
import 'package:socialmedia/pages/login_page.dart';
import 'package:socialmedia/pages/register_page.dart';
import 'package:socialmedia/themes/dark_mode.dart';
import 'package:socialmedia/themes/light_mode.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CheckPage(),
      theme: lightMode,
      darkTheme: darkMode,
    );
  }
}
