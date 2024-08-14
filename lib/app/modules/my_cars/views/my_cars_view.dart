import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/my_cars_controller.dart';

class MyCarsView extends GetView<MyCarsController> {
  const MyCarsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyCarsView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'MyCarsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
