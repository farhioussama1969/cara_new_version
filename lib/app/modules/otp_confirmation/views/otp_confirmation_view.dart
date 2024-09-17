import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/otp_confirmation_controller.dart';

class OtpConfirmationView extends GetView<OtpConfirmationController> {
  const OtpConfirmationView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OtpConfirmationView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'OtpConfirmationView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
