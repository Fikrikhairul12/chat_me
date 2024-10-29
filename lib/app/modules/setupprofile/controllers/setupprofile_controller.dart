import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SetupprofileController extends GetxController {
  final ImagePicker _picker = ImagePicker();
  File? profileImage;

  // Fungsi untuk memilih gambar dari galeri
  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      update(); // Update view setelah gambar dipilih
    }
  }

  // Fungsi untuk mengunggah gambar ke Firebase Storage dan mendapatkan URL-nya
  Future<String> uploadImage(String userId) async {
    if (profileImage != null) {
      Reference ref = FirebaseStorage.instance
          .ref()
          .child('profile_images')
          .child('$userId.png');
      await ref.putFile(profileImage!);
      return await ref.getDownloadURL();
    } else {
      return 'https://as2.ftcdn.net/v2/jpg/03/31/69/91/1000_F_331699188_lRpvqxO5QRtwOM05gR50ImaaJgBx68vi.jpg'; // Gambar default jika tidak ada
    }
  }

  // Fungsi untuk menyimpan data profil ke Firestore
  Future<void> saveProfile(String name, String idUser) async {
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      // Unggah gambar dan dapatkan URL-nya
      String imageUrl = await uploadImage(currentUser.uid);

      // Simpan data ke Firestore
      await FirebaseFirestore.instance.collection('users').doc(currentUser.uid).set({
        'name': name,
        'id_user': '@$idUser',
        'email': currentUser.email,
        'profile_image': imageUrl,
      });
    }
  }
}
