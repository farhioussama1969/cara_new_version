import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:solvodev_mobile_structure/app/core/constants/get_builders_ids_constants.dart';
import 'package:solvodev_mobile_structure/app/modules/gifts/views/gifts_view.dart';
import 'package:solvodev_mobile_structure/app/modules/home/views/home_view.dart';
import 'package:solvodev_mobile_structure/app/modules/main/views/components/bottom_navgation_bar_component.dart';
import 'package:solvodev_mobile_structure/app/modules/my_account/views/my_account_view.dart';
import 'package:solvodev_mobile_structure/app/modules/my_cars/views/my_cars_view.dart';
import 'package:solvodev_mobile_structure/app/modules/my_reservations/views/my_reservations_view.dart';

import '../controllers/main_controller.dart';

class MainView extends GetView<MainController> {
  const MainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<MainController>(
          id: GetBuildersIdsConstants.bottomNavigationBar,
          builder: (logic) {
            return IndexedStack(
              index: logic.selectedBottomNavIndex,
              children: [
                HomeView(),
                MyCarsView(),
                GiftsView(),
                MyReservationsView(),
                MyAccountView(),
              ],
            );
          }),
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
