import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:socialmedia/auth/login_or_register.dart';
import 'package:socialmedia/pages/home_page.dart';

class CheckPage extends StatelessWidget {
  const CheckPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          //if the user logged in
          if(snapshot.hasData){
            return HomePage();
            //if the user isn't logged in
        }else{
            return const AuthPage();
          }
        }
      ),
    );
  }
}
