import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/gifts_controller.dart';

class GiftsView extends GetView<GiftsController> {
  const GiftsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GiftsView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'GiftsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
