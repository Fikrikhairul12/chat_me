import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SplashscreenController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _navigateToNextScreen();
  }

  void _navigateToNextScreen() {
    Future.delayed(Duration(seconds: 1), () {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Jika pengguna sudah login, arahkan ke halaman Home
        Get.offNamed('/home');
      } else {
        // Jika belum login, arahkan ke halaman Login
        Get.offNamed('/onboarding');
      }
    });
  }
}
