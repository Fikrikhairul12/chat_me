import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class OnboardingController extends GetxController {
  var currentPage = 0.obs;
  PageController pageController = PageController();

  // Fungsi untuk berpindah ke halaman berikutnya
  void nextPage() {
    if (currentPage.value < 2) {
      pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.ease);
    }
  }

  // Fungsi untuk melompati onboarding dan langsung ke halaman login
  void skipOnboarding() {
    // Arahkan ke halaman login
    Get.offNamed('/splashscreen'); // Ganti dengan nama route login sesuai dengan kebutuhan Anda
  }

  // Dispose PageController untuk menghindari memory leak
  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
