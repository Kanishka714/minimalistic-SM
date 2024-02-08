import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:socialmedia/component/mybotton.dart';
import 'package:socialmedia/component/mytextfield.dart';
import 'package:socialmedia/help/help_function.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //text controller
  TextEditingController userNameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();

  //Register method
  void Register() async {
    //show loading circle
    showDialog(context: context,
      builder: (context) =>
      const Center(child: CircularProgressIndicator(),
      ),);

    //make sure passwords match
    if (passwordController.text != confirmPasswordController.text) {
    //pop loading circle
    Navigator.pop(context);
      //show error to user
    displayMessageToUser("Password doesn't match ", context);
    } //if password doesn't match
    else{
      //create an user
      try {
        UserCredential? userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);

        //create an user document and add it to the firestore
        createUserDocument(userCredential);

        //pop loading cirlcle
        if(context.mounted)Navigator.pop(context);
      }on FirebaseAuthException catch(e){
        //pop loading cirlce
        Navigator.pop(context);

        //display error
        displayMessageToUser(e.code, context);
      }
    }
  }

  //create user document and collect them in firestore
  Future<void> createUserDocument(UserCredential? userCredential) async{
    if(userCredential != null && userCredential.user != null){
      await FirebaseFirestore.instance
          .collection("users")
          .doc(userCredential.user!.email)
          .set({
        'email': userCredential.user!.email,
        'username': userNameController.text,
      });
    }
  }


  //make sure passwords match
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //logo
              Icon(
                Icons.person,
                size: 80,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),

              const SizedBox(height: 20),

              //appName
              const Text("M I N I M A L",
                style: TextStyle(fontSize: 20),
              ),

              const SizedBox(height: 20),

              //email textfield
              MyTextField(hintText: "Username",
                  obsecureText: false,
                  controller: userNameController
              ),

              const SizedBox(height: 25),

              //email textfield
              MyTextField(hintText: "Email",
                  obsecureText: false,
                  controller: emailController
              ),

              const SizedBox(height: 25),

              //email textfield
              MyTextField(hintText: "Password",
                  obsecureText: true,
                  controller: passwordController,
              ),
              const SizedBox(height: 25),


              //password textfield
              MyTextField(hintText: "Confirm Password",
                obsecureText: true,
                controller: confirmPasswordController,
              ),

              const SizedBox(height: 25),


              const SizedBox(height: 25),

              //Register in button
              MyButton(
                text: "Register",
                onTap:Register,
              ),

              const SizedBox(height: 25),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Already have an account?',
                      style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary)),
                  GestureDetector(
                    onTap: widget.onTap, // Use the onTap function here
                    child: const Text(
                      'Login here',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}