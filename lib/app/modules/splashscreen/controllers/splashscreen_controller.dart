import 'package:get/get.dart';

class SplashscreenController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _navigateToNextScreen();
  }

  void _navigateToNextScreen() {
    Future.delayed(Duration(seconds: 1), () {
      Get.offNamed('/login');  // Navigasi ke halaman selanjutnya
    });
  }
}
