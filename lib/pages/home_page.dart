import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:socialmedia/component/mydrawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("Home")),
        backgroundColor: Colors.lime,
      ),
      drawer: MyDrawer(),
      body: Center(child: Text("Welcome in to Thougths")),
    );
  }
}
