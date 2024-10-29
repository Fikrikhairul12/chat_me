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
            children: [
              Text(
                "Setup Profile",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
              // Bind controller agar view bisa di-update sesuai dengan state controller
              GetBuilder<SetupprofileController>(
                builder: (controller) {
                  return GestureDetector(
                    onTap: () => controller.pickImage(), // Memilih gambar
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: controller.profileImage != null
                          ? FileImage(controller.profileImage!)
                          : NetworkImage(
                              'https://as2.ftcdn.net/v2/jpg/03/31/69/91/1000_F_331699188_lRpvqxO5QRtwOM05gR50ImaaJgBx68vi.jpg'),
                    ),
                  );
                },
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
                onPressed: () {
                  String name = nameController.text.trim();
                  String idUser = idUserController.text.trim();

                  if (name.isNotEmpty && idUser.isNotEmpty) {
                    controller.saveProfile(name, idUser);
                    Get.offAllNamed('/home'); // Redirect ke home setelah setup selesai
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
