import 'package:firebase_auth/firebase_auth.dart';
import 'package:chat_me/app/widgets/login_widget.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});
  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 188, 255, 255),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Center(
                child: Container(
                  width: 360,
                  height: 360,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/logo-cht.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              CustomTextFormField(
                label: 'Email',
                controller: emailController,
              ),
              CustomTextFormField(
                label: 'Password',
                controller: passwordController,
                isPassword: true,
              ),
              CustomTextFormField(
                label: 'Confirm Password',
                controller: confirmPasswordController,
                isPassword: true,
              ),
              SizedBox(
                width: 293,
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    backgroundColor: Color(0xff0098ff),
                  ),
                  onPressed: () async {
                    String email = emailController.text;
                    String password = passwordController.text;
                    String confirmPassword = confirmPasswordController.text;
                    if (password == confirmPassword) {
                      try {
                        final result = await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                          email: email,
                          password: password,
                        );
                        Get.offAllNamed('/setupprofile');
                      } on FirebaseAuthException catch (e) {
                        print('Error: $e');
                      }
                    }
                  },
                  child: Text(
                    'Sign Up',
                    style: GoogleFonts.workSans(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  )
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                    style: GoogleFonts.workSans(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    )
                  ),
                  InkWell(
                    onTap: () {
                      Get.offNamed('/login');
                    },
                    child: Text(
                      '  Login',
                      style: GoogleFonts.workSans(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
