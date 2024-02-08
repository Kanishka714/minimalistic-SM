 import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:socialmedia/component/back_button.dart';
import 'package:socialmedia/help/help_function.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("users").snapshots(),
        builder: (context, snapshot){

          //any errors
          if(snapshot.hasError){
            displayMessageToUser("Something went wrong", context);
          }
          //show loading circle
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          //get all users
          if(snapshot.data == null){
            return Text("No data");
          }

          //get all users
          final users = snapshot.data!.docs;

          return Column(
            children: [

              // // back button
              Padding(
                padding: const EdgeInsets.only(
                  top: 50.0,
                  left: 25,
                ),
                child: //b
                Row(
                  children: [
                    MyBackButton(),
                  ],
                ),
              ),

              //list of users in the app
              Expanded(
                child: ListView.builder(
                  itemCount: users.length,
                  padding: const  EdgeInsets.all(0),
                  itemBuilder: (context, index) {
                    //get individual user
                    final user = users[index];
                
                    return ListTile(
                      title: Text(user['username']),
                      subtitle: Text(user['email']),
                
                    );
                  }
                ),
              ),
            ],
          );

        },
      ),
    );
  }
}

