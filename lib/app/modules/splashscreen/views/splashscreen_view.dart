import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/splashscreen_controller.dart';

class SplashscreenView extends GetView<SplashscreenController> {
  const SplashscreenView({super.key});
  @override
  Widget build(BuildContext context) {
    final SplashscreenController controller = Get.find<SplashscreenController>();
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 188, 255, 255),
      body: SafeArea(
        child: Center(
          child: Container(
            width: 390,
            height: 390,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/logo-cht.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
