import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/remind_password_controller.dart';

class RemindPasswordView extends GetView<RemindPasswordController> {
  const RemindPasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RemindPasswordView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'RemindPasswordView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
