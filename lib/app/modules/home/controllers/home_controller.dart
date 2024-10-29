import 'package:chat_me/app/data/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/user_model.dart';

class HomeController extends GetxController {
  final AuthService _authService = AuthService();
  var contacts = <Map<String, dynamic>>[].obs;
  var isUserFound = true.obs;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void searchUser(String idUser) async {
    if (idUser.isEmpty) {
      contacts.clear();
      isUserFound.value =
          true; // Reset indikator agar tidak menampilkan pesan error
      return;
    }

    String queryIdUser = idUser.startsWith('@') ? idUser : '@$idUser';
    // print("Mencari user dengan ID: $queryIdUser");

    try {
      QuerySnapshot result = await firestore
          .collection('users')
          .where('id_user', isGreaterThanOrEqualTo: queryIdUser)
          .where('id_user', isLessThanOrEqualTo: queryIdUser + '\uf8ff')
          .get();

      // print("Jumlah dokumen ditemukan: ${result.docs.length}");

      if (result.docs.isNotEmpty) {
        contacts.value = result.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList();
        isUserFound.value = true;
      } else {
        contacts.clear();
        isUserFound.value = false;
        print("User tidak ditemukan");
      }
    } catch (e) {
      print("Error: $e");
      contacts.clear();
      isUserFound.value = false;
    }
  }

  Future<void> loginAndFetchUserData(String email, String password) async {
    User? user = await _authService.signInWithEmail(email, password);
    if (user != null) {
      var userData = await _authService.getUserData(user.uid);
      if (userData != null) {
        print("Data user ditemukan: $userData");
      } else {
        print("User tidak ditemukan");
      }
    } else {
      print("Login failed");
    }
  }

  // Fungsi untuk menambahkan user B ke dalam obrolan dengan user A
  Future<void> addUserToChat(String userBId) async {
    String userAId =
        FirebaseAuth.instance.currentUser!.uid; // ID user yang login (A)

    if (userAId == userBId) {
      print("User tidak dapat menambahkan obrolan dengan dirinya sendiri.");
      return;
    }

    //! next nambahin snackbar atau popup message kalau berhasil menambahkan obrolan

    try {
      // Cek apakah obrolan sudah ada
      QuerySnapshot chatExists = await firestore
          .collection('chats')
          .where('user1_id', isEqualTo: '@${userAId}')
          .where('user2_id', isEqualTo: '@${userBId}')
          .get();

      if (chatExists.docs.isEmpty) {
        // Jika obrolan belum ada, tambahkan obrolan baru
        await firestore.collection('chats').add({
          'user1_id': userAId,
          'user2_id': userBId,
          'createdAt': FieldValue.serverTimestamp(),
        });
        Get.defaultDialog(
          title: 'Success',
          middleText: 'Obrolan berhasil ditambahkan',
          textConfirm: 'OK',
          textCancel: 'Cancel',
          confirmTextColor: Colors.white,
          onConfirm: () {
            Get.back();
          },
          onCancel: () {
            print('cancel');
            Get.back();
          },
        );
      } else {
        print("Obrolan sudah ada.");
      }
    } catch (e) {
      print("Error saat menambahkan obrolan: $e");
    }
  }
}
