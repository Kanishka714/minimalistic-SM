import 'package:flutter/material.dart';
import 'package:socialmedia/component/mybotton.dart';
import 'package:socialmedia/component/mytextfield.dart';

class RegisterPage extends StatelessWidget {
  final void Function()? onTap;

  RegisterPage({super.key, required this.onTap});

  //text controller
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  //Register method
  void Register(){}


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
                    onTap: onTap, // Use the onTap function here
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