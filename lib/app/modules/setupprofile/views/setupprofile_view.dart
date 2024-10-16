import 'package:chat_me/app/widgets/login_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:get/get.dart';

import '../controllers/setupprofile_controller.dart';

class SetupprofileView extends GetView<SetupprofileController> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController idUserController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 188, 255, 255),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            // crossAxisAlignment: CrossAxisAlignment.center,
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
              SizedBox(height: 20),
              Text(
                "Setup Profile",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
              CustomTextFormField(
                label: 'Name',
                controller: nameController,
              ),
              CustomTextFormField(
                label: 'User ID (@id_user)',
                controller: idUserController,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  String name = nameController.text.trim();
                  String idUser = idUserController.text.trim();

                  if (name.isNotEmpty && idUser.isNotEmpty) {
                    User? currentUser = FirebaseAuth.instance.currentUser;
                    if (currentUser != null) {
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(currentUser.uid)
                          .set({
                        'name': name,
                        'id_user': '@$idUser',
                        'email': currentUser.email,
                      });

                      Get.offAllNamed('/home'); // redirect to home page after profile setup
                    }
                  } else {
                    Get.snackbar(
                      'Error',
                      'Name and User ID cannot be empty',
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  }
                },
                child: Text("Save"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
