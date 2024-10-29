import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  // final HomeController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              try {
                await FirebaseAuth.instance.signOut();
                Get.offAllNamed(
                    '/login'); // Arahkan ke halaman login setelah logout
              } catch (e) {
                print('Error during logout: $e');
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search by ID (e.g., joseph123)',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onChanged: (value) {
                controller.searchUser(value);
              },
            ),
          ),
          Expanded(
            child: Obx(() {
              if (!controller.isUserFound.value) {
                return Center(
                  child: Text(
                    'User tidak ditemukan',
                    style: TextStyle(fontSize: 16, color: Colors.red),
                  ),
                );
              }

              return ListView.builder(
                itemCount: controller.contacts.length,
                itemBuilder: (context, index) {
                  var contact = controller.contacts[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: contact['profile_image'] != null
                          ? NetworkImage(contact['profile_image'])
                          : AssetImage('assets/images/default.jpg'),
                    ),
                    title: Text(contact['name'] ?? 'Unknown'),
                    subtitle: Text(contact['id_user'] ?? 'No email'),
                    trailing: IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        // Panggil fungsi untuk menambahkan user ke dalam obrolan
                        controller.addUserToChat(contact['id_user']);
                      },
                    ),
                    onTap: () {
                      // Navigate to chat or profile page
                    },
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
