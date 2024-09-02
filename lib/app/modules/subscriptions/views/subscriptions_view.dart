import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/subscriptions_controller.dart';

class SubscriptionsView extends GetView<SubscriptionsController> {
  const SubscriptionsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SubscriptionsView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'SubscriptionsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
