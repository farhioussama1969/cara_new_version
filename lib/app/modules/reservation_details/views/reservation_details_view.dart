import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/reservation_details_controller.dart';

class ReservationDetailsView extends GetView<ReservationDetailsController> {
  const ReservationDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ReservationDetailsView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ReservationDetailsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
