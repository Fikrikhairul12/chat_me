import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Function to handle Google Sign-In
  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Jika pengguna membatalkan proses login, `googleUser` akan bernilai null
      if (googleUser == null) {
        Get.snackbar(
            "Login Canceled", "You canceled the Google login process.");
        return; // Keluar dari fungsi jika login dibatalkan
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      Get.offAllNamed('/home'); // Redirect ke halaman utama jika login berhasil
    } catch (e) {
      print('Login error: $e');
      Get.snackbar("Login Error", e.toString());
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      Get.snackbar(
        'Success',
        'A password reset link has been sent to $email.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        'Error',
        e.message ?? 'An error occurred. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
