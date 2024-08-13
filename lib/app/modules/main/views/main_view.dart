import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:solvodev_mobile_structure/app/core/constants/get_builders_ids_constants.dart';
import 'package:solvodev_mobile_structure/app/modules/main/views/components/bottom_navgation_bar_component.dart';

import '../controllers/main_controller.dart';

class MainView extends GetView<MainController> {
  const MainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text(
          'MainView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
      bottomNavigationBar: GetBuilder<MainController>(
        id: GetBuildersIdsConstants.bottomNavigationBar,
        builder: (logic) {
          return BottomNavigationBarComponent(
            selectedIndex: logic.selectedBottomNavIndex,
            onIndexSelected: (index) =>
                logic.changeSelectedBottomNavIndex(index),
          );
        },
      ),
    );
  }
}
