import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:solvodev_mobile_structure/app/core/constants/icons_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/constants/strings_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/styles/main_colors.dart';
import 'package:solvodev_mobile_structure/app/modules/main/views/components/bottom_navigation_car_item_component.dart';

class BottomNavigationBarComponent extends StatelessWidget {
  const BottomNavigationBarComponent(
      {super.key, required this.onIndexSelected, required this.selectedIndex});

  final Function(int index) onIndexSelected;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        //height: 70.h,
        decoration: BoxDecoration(
          color: MainColors.backgroundColor(context),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BottomNavigationCarItemComponent(
              enabledIconPath: IconsAssetsConstants.homeEnabledIcon,
              disabledIconPath: IconsAssetsConstants.homeDisabledIcon,
              onTap: () => onIndexSelected(0),
              title: StringsAssetsConstants.home,
              isEnabled: selectedIndex == 0,
            ),
            BottomNavigationCarItemComponent(
              enabledIconPath: IconsAssetsConstants.myCarsEnabledIcon,
              disabledIconPath: IconsAssetsConstants.myCarsDisabledIcon,
              onTap: () => onIndexSelected(1),
              title: StringsAssetsConstants.myCars,
              isEnabled: selectedIndex == 1,
            ),
            BottomNavigationCarItemComponent(
              enabledIconPath: IconsAssetsConstants.giftEnabledIcon,
              disabledIconPath: IconsAssetsConstants.giftDisabledIcon,
              onTap: () => onIndexSelected(2),
              title: StringsAssetsConstants.gifts,
              isEnabled: selectedIndex == 2,
            ),
            BottomNavigationCarItemComponent(
              enabledIconPath: IconsAssetsConstants.myReservationsEnabledIcon,
              disabledIconPath: IconsAssetsConstants.myReservationsDisableIcon,
              onTap: () => onIndexSelected(3),
              title: StringsAssetsConstants.myReservations,
              isEnabled: selectedIndex == 3,
            ),
            BottomNavigationCarItemComponent(
              enabledIconPath: IconsAssetsConstants.profileEnabledIcon,
              disabledIconPath: IconsAssetsConstants.profileDisabledIcon,
              onTap: () => onIndexSelected(4),
              title: StringsAssetsConstants.myAccount,
              isEnabled: selectedIndex == 4,
            ),
          ],
        ),
      ),
    );
  }
}
