import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:solvodev_mobile_structure/app/core/components/animations/animator_component.dart';
import 'package:solvodev_mobile_structure/app/core/components/buttons/primary_button_component.dart';
import 'package:solvodev_mobile_structure/app/core/components/inputs/text_input_component.dart';
import 'package:solvodev_mobile_structure/app/core/components/layouts/scrollable_body_component.dart';
import 'package:solvodev_mobile_structure/app/core/components/others/header_component.dart';
import 'package:solvodev_mobile_structure/app/core/components/pop_ups/bottom_sheet_component.dart';
import 'package:solvodev_mobile_structure/app/core/constants/get_builders_ids_constants.dart';
import 'package:solvodev_mobile_structure/app/core/constants/icons_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/constants/strings_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/styles/main_colors.dart';
import 'package:solvodev_mobile_structure/app/core/styles/text_styles.dart';
import 'package:solvodev_mobile_structure/app/core/utils/color_convertor_util.dart';
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
        child: Form(
          key: controller.addNewCarFormKey,
          child: ScrollableBodyComponent(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            children: [
              SizedBox(height: 20.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
                decoration: BoxDecoration(
                  color: MainColors.backgroundColor(context),
                  boxShadow: [
                    BoxShadow(
                      color: MainColors.shadowColor(context)!,
                      blurRadius: 10.r,
                      offset: const Offset(0, 0),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: TextInputComponent(
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
              ),
              SizedBox(height: 15.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
                decoration: BoxDecoration(
                  color: MainColors.backgroundColor(context),
                  boxShadow: [
                    BoxShadow(
                      color: MainColors.shadowColor(context)!,
                      blurRadius: 10.r,
                      offset: const Offset(0, 0),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: TextInputComponent(
                  focusNode: controller.carModelFocusNode,
                  controller: controller.carModelController,
                  label: StringsAssetsConstants.carName,
                  isLabelOutside: true,
                  hint:
                      '${StringsAssetsConstants.enter} ${StringsAssetsConstants.carName}...',
                  validate: (value) => ValidatorUtil.stringLengthValidation(
                    value,
                    3,
                    customMessage:
                        '${StringsAssetsConstants.check} ${StringsAssetsConstants.carName}',
                  ),
                ),
              ),
              SizedBox(height: 15.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
                decoration: BoxDecoration(
                  color: MainColors.backgroundColor(context),
                  boxShadow: [
                    BoxShadow(
                      color: MainColors.shadowColor(context)!,
                      blurRadius: 10.r,
                      offset: const Offset(0, 0),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Row(
                        children: [
                          Text(
                            StringsAssetsConstants.carColor,
                            style: TextStyles.mediumLabelTextStyle(context),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15.h),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: GetBuilder<AddNewCarController>(
                          id: GetBuildersIdsConstants.addNewCarColorsList,
                          builder: (logic) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: controller.colorsList
                                  .map(
                                    (color) => GestureDetector(
                                      onTap: () =>
                                          controller.changeSelectedColor(color),
                                      child: Stack(
                                        children: [
                                          AnimatedContainer(
                                            duration: const Duration(
                                                milliseconds: 300),
                                            height: 40.r,
                                            width: 40.r,
                                            margin: EdgeInsets.all(2.r),
                                            decoration: BoxDecoration(
                                              color: ColorConvertorUtil()
                                                  .stringColorCodeToColor(
                                                      color),
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color: controller
                                                            .selectedColor ==
                                                        color
                                                    ? MainColors.primaryColor
                                                    : MainColors.disableColor(
                                                            context)!
                                                        .withOpacity(0.1),
                                                width: 1.5.r,
                                              ),
                                            ),
                                          ),
                                          if (logic.selectedColor == color)
                                            AnimatorComponent(
                                              time: const Duration(
                                                  milliseconds: 50),
                                              child: Container(
                                                padding: EdgeInsets.all(4.r),
                                                decoration: BoxDecoration(
                                                  color:
                                                      MainColors.primaryColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          1000.r),
                                                ),
                                                height: 20.r,
                                                width: 20.r,
                                                child: Center(
                                                  child: SvgPicture.asset(
                                                    IconsAssetsConstants
                                                        .checkIcon,
                                                    color:
                                                        MainColors.whiteColor,
                                                    width: 20.r,
                                                  ),
                                                ),
                                              ),
                                            )
                                        ],
                                      ),
                                    ),
                                  )
                                  .toList(),
                            );
                          }),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
                decoration: BoxDecoration(
                  color: MainColors.backgroundColor(context),
                  boxShadow: [
                    BoxShadow(
                      color: MainColors.shadowColor(context)!,
                      blurRadius: 10.r,
                      offset: const Offset(0, 0),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: TextInputComponent(
                  focusNode: controller.platNumberFocusNode,
                  controller: controller.plateNumberController,
                  label:
                      '${StringsAssetsConstants.plateNumber} (${StringsAssetsConstants.optional})',
                  isLabelOutside: true,
                  hint:
                      '${StringsAssetsConstants.enter} ${StringsAssetsConstants.plateNumber}...',
                  validate: (value) => null,
                ),
              ),
              SizedBox(height: 40.h),
              GetBuilder<AddNewCarController>(
                  id: GetBuildersIdsConstants.addNewCarButton,
                  builder: (logic) {
                    return PrimaryButtonComponent(
                      onTap: () => logic.addNewCar(),
                      isLoading: logic.addNewCarLoading,
                      text: StringsAssetsConstants.confirm,
                      width: 0.4.sw,
                    );
                  }),
              SizedBox(height: 40.h),
            ],
          ),
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
