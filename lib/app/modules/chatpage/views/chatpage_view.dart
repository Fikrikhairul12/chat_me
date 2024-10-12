import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/chatpage_controller.dart';

class ChatpageView extends GetView<ChatpageController> {
  const ChatpageView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ChatpageView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ChatpageView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
