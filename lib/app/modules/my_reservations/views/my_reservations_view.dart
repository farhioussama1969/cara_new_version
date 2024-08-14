import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/my_reservations_controller.dart';

class MyReservationsView extends GetView<MyReservationsController> {
  const MyReservationsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyReservationsView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'MyReservationsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
