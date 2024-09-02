import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/send_gifts_controller.dart';

class SendGiftsView extends GetView<SendGiftsController> {
  const SendGiftsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SendGiftsView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'SendGiftsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
