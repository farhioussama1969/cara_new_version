import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/check_location_service_controller.dart';

class CheckLocationServiceView extends GetView<CheckLocationServiceController> {
  const CheckLocationServiceView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CheckLocationServiceView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'CheckLocationServiceView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
