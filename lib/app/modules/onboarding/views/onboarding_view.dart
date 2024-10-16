import 'package:chat_me/app/widgets/onboarding_widget.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 188, 255, 255),
      body: Obx(
        () => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: PageView(
                controller: controller.pageController,
                onPageChanged: (index) {
                  controller.currentPage.value = index;
                },
                children: [
                  onboardingPage(
                    title: 'Selamat Datang di CHAT ME',
                    description:
                        'Aplikasi chat sederhana dan cepat yang memungkinkan Anda terhubung dengan teman, keluarga, dan kolega dengan mudah.',
                    imagePath: 'assets/images/logo-cht.png', // Ganti dengan gambar yang relevan
                  ),
                  onboardingPage(
                    title: 'Tambah Kontak dengan Mudah',
                    description:
                        'Cari teman atau kontak dengan ID unik mereka. Masukkan @id_user untuk langsung menambahkan mereka ke daftar chat Anda.',
                    imagePath: 'assets/images/logo-cht.png', // Ganti dengan gambar yang relevan
                  ),
                  onboardingPage(
                    title: 'Chat dan Berbagi File',
                    description:
                        'Kirim pesan real-time dan bagikan gambar, video, dan file dengan mudah melalui obrolan.',
                    imagePath: 'assets/images/logo-cht.png', // Ganti dengan gambar yang relevan
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                3, // Jumlah halaman onboarding
                (index) => Obx(
                  () => Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: controller.currentPage.value == index
                          ? Colors.blue
                          : Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (controller.currentPage.value == 2) {
                  controller.skipOnboarding(); // Setelah halaman terakhir, arahkan ke login
                } else {
                  controller.nextPage();
                }
              },
              child: Text(controller.currentPage.value == 2 ? 'Mulai' : 'Next'),
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: controller.skipOnboarding,
              child: Text('Lewati'),
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
