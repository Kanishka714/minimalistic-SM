import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:socialmedia/component/mydrawer.dart';
import 'package:socialmedia/component/mytextfield.dart';
import 'package:socialmedia/component/post_button.dart';
import 'package:socialmedia/database/firestore.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  //firestore access
  final FirestoreDatabase database = FirestoreDatabase();

  //text controller
  final TextEditingController newPostController = TextEditingController();

  //post the message
  void PostMessage() {
    if (newPostController.text.isNotEmpty) {
      String message = newPostController.text;
      database.addPost(message);
    }

    //clear the controller
    newPostController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Center(child: Text("W A L L")),
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      drawer: const MyDrawer(),
      body: Column(
        children: [
          //textfield for the user to type
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Row(
              children: [
                //textfield
                Expanded(
                  child: MyTextField(
                    hintText: "Say Something",
                    obsecureText: false,
                    controller: newPostController,
                  ),
                ),

                //post button
                PostButton(
                  onTap: PostMessage,
                ),
              ],
            ),
          ),

          //posts
          StreamBuilder(
            stream: database.getPostsStream(),
            builder: (context, snapshot) {
              // Check if the stream is still waiting for data
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              // Check if snapshot does not have data or data is null
              if (!snapshot.hasData || snapshot.data == null) {
                return Center(
                  child: Padding(
                    padding: EdgeInsets.all(25),
                    child: Text("No posts.. post something"),
                  ),
                );
              }

              // Extract posts from snapshot
              final posts = snapshot.data!.docs;

              // Check if posts list is empty
              if (posts.isEmpty) {
                return Center(
                  child: Padding(
                    padding: EdgeInsets.all(25),
                    child: Text("No posts.. post something"),
                  ),
                );
              }

              // Build ListView with posts
              return Expanded(
                child: ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    final post = posts[index];
                    String message = post['PostMessage'];
                    String userEmail = post['UserEmail'];
                    Timestamp timestamp = post['TimeStamp'];

                    return ListTile(
                      title: Text(message),
                      subtitle: Text(userEmail),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
