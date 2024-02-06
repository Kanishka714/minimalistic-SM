import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:socialmedia/component/mybotton.dart';
import 'package:socialmedia/component/mytextfield.dart';
import 'package:socialmedia/help/help_function.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //text controller
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  //Login method
  void Login() async{
    //show loading circle
    showDialog(
      context: context,
      builder: (context) => const Center(child: CircularProgressIndicator(),
        ),
    );

    try{
      //try sign in
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text);

      //pop loading circle
      if(context.mounted) Navigator.pop(context);
    }
    //display errors
    on FirebaseAuthException catch(e){
      //pop loading cirlce
      Navigator.pop(context);
      displayMessageToUser(e.code, context);
    }
  }

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

                  const SizedBox(height: 25),

              //appName
             const Text("M I N I M A L",
              style: TextStyle(fontSize: 20),
              ),

              const SizedBox(height: 25),

              //email textfield
              MyTextField(hintText: "Email",
                  obsecureText: false,
                  controller: emailController
              ),

              const SizedBox(height: 25),


              //password textfield
              MyTextField(hintText: "Password",
                  obsecureText: true,
                  controller: passwordController,
              ),

              const SizedBox(height: 25),

               //forgot password?
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("Forgot Password ?",
                  style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary)),
                ],
              ),

              const SizedBox(height: 25),

              //Sign in button
              MyButton(
                text: "Login",
                onTap: Login,
              ),

              const SizedBox(height: 25),

              //Don't have an account yet?
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Don\'t have an account?',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
              GestureDetector(
                onTap: widget.onTap,
                child: const Text(
                  'Register here',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ]),
      ),
      ));
  }
}
