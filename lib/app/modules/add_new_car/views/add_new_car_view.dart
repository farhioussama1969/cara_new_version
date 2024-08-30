import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:solvodev_mobile_structure/app/core/components/inputs/text_input_component.dart';
import 'package:solvodev_mobile_structure/app/core/components/layouts/scrollable_body_component.dart';
import 'package:solvodev_mobile_structure/app/core/components/others/header_component.dart';
import 'package:solvodev_mobile_structure/app/core/components/pop_ups/bottom_sheet_component.dart';
import 'package:solvodev_mobile_structure/app/core/constants/get_builders_ids_constants.dart';
import 'package:solvodev_mobile_structure/app/core/constants/icons_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/constants/strings_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/styles/main_colors.dart';
import 'package:solvodev_mobile_structure/app/core/styles/text_styles.dart';
import 'package:solvodev_mobile_structure/app/core/utils/validator_util.dart';
import 'package:solvodev_mobile_structure/app/modules/add_new_car/views/components/car_brands_window_component.dart';

import '../controllers/add_new_car_controller.dart';

class AddNewCarView extends GetView<AddNewCarController> {
  const AddNewCarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderComponent(
        actionWidget: Text(
          StringsAssetsConstants.addCar,
          style: TextStyles.largeLabelTextStyle(context),
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: ScrollableBodyComponent(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          children: [
            SizedBox(height: 20.h),
            TextInputComponent(
              focusNode: controller.carBrandFocusNode,
              nextNode: controller.carModelFocusNode,
              controller: controller.carBrandController,
              label: StringsAssetsConstants.carBrand,
              isLabelOutside: true,
              readOnly: true,
              hint:
                  '${StringsAssetsConstants.enter} ${StringsAssetsConstants.carBrand}...',
              onTap: (context) {
                controller.getCarBrandsList();
                showCarBrandsWindow();
              },
              suffix: Row(
                children: [
                  SizedBox(width: 10.w),
                  SvgPicture.asset(
                    IconsAssetsConstants.arrowBottomIcon,
                    width: 22.r,
                    height: 22.r,
                    color: MainColors.primaryColor,
                  ),
                  SizedBox(width: 20.w),
                ],
              ),
              validate: (value) => ValidatorUtil.nullableValidation(
                controller.selectedCarBrandId,
                customMessage:
                    '${StringsAssetsConstants.check} ${StringsAssetsConstants.carBrand}',
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showCarBrandsWindow() {
    BottomSheetComponent.show(
      Get.context!,
      body: GetBuilder<AddNewCarController>(
          autoRemove: false,
          id: GetBuildersIdsConstants.addNewCarBrandsList,
          builder: (logic) {
            return CarBrandsWindowComponent(
              carBrandsList: logic.resultCarBrandsList,
              loading: logic.getCarBrandsLoading,
              onCarBrandSelected: (brand) {
                controller.carBrandController.text = brand.name ?? '';
                logic.changeSelectedCarBrandId(brand.id);
              },
              onConfirm: () => Get.back(),
              onSearch: (value) => logic.searchInCarBrandsList(value),
              selectedCarBrandId: logic.selectedCarBrandId,
            );
          }),
    );
  }
}
