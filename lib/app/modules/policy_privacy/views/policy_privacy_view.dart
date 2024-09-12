import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/policy_privacy_controller.dart';

class PolicyPrivacyView extends GetView<PolicyPrivacyController> {
  const PolicyPrivacyView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PolicyPrivacyView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'PolicyPrivacyView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
