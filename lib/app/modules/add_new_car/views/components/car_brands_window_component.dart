import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:solvodev_mobile_structure/app/core/components/buttons/icon_button_component.dart';
import 'package:solvodev_mobile_structure/app/core/components/buttons/primary_button_component.dart';
import 'package:solvodev_mobile_structure/app/core/components/cards/car_brand_card_component.dart';
import 'package:solvodev_mobile_structure/app/core/components/inputs/text_input_component.dart';
import 'package:solvodev_mobile_structure/app/core/components/others/empty_component.dart';
import 'package:solvodev_mobile_structure/app/core/constants/icons_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/constants/strings_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/styles/main_colors.dart';
import 'package:solvodev_mobile_structure/app/core/styles/text_styles.dart';
import 'package:solvodev_mobile_structure/app/data/models/car_brand_model.dart';

class CarBrandsWindowComponent extends StatelessWidget {
  const CarBrandsWindowComponent(
      {super.key,
      required this.loading,
      required this.carBrandsList,
      required this.onCarBrandSelected,
      required this.onSearch,
      required this.selectedCarBrandId,
      required this.onConfirm});

  final bool loading;
  final List<CarBrandModel> carBrandsList;
  final Function(CarBrandModel) onCarBrandSelected;
  final Function(String) onSearch;
  final int? selectedCarBrandId;
  final Function onConfirm;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding:
              EdgeInsetsDirectional.only(start: 20.w, end: 20.w, top: 20.h),
          decoration: BoxDecoration(
            color: MainColors.backgroundColor(context),
            borderRadius:
                BorderRadiusDirectional.vertical(top: Radius.circular(30.r)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Text(
                  StringsAssetsConstants.carBrand,
                  style: TextStyles.mediumLabelTextStyle(context),
                ),
              ),
              SizedBox(height: 15.h),
              TextInputComponent(
                hint: '${StringsAssetsConstants.search}...',
                onChange: (value) => onSearch(value),
                prefix: Row(
                  children: [
                    SizedBox(width: 20.w),
                    SvgPicture.asset(
                      IconsAssetsConstants.searchIcon,
                      width: 22.r,
                      color: MainColors.disableColor(context),
                    ),
                    SizedBox(width: 10.w),
                  ],
                ),
              ),
              SizedBox(height: 10.h),
              Expanded(
                child: ((carBrandsList.isNotEmpty))
                    ? Stack(
                        children: [
                          ListView.separated(
                              padding: EdgeInsetsDirectional.only(
                                  start: 10.w,
                                  end: 10.w,
                                  top: 20.h,
                                  bottom: 100.h),
                              physics: loading
                                  ? const NeverScrollableScrollPhysics()
                                  : const BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    onCarBrandSelected(carBrandsList[index]);
                                  },
                                  child: CarBrandCardComponent(
                                    carBrand: carBrandsList[index],
                                    isSelected: selectedCarBrandId ==
                                        carBrandsList[index].id,
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox(height: 15.h);
                              },
                              itemCount: ((loading && carBrandsList.isEmpty))
                                  ? 20
                                  : carBrandsList.length),
                          if (selectedCarBrandId != null)
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.w, vertical: 10.h),
                                  child: PrimaryButtonComponent(
                                    onTap: () => Get.back(),
                                    text: StringsAssetsConstants.confirm,
                                  ),
                                ),
                              ],
                            ),
                        ],
                      )
                    : SingleChildScrollView(
                        physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        child: Column(
                          children: [
                            EmptyComponent(
                                text: StringsAssetsConstants.emptyDataText),
                            SizedBox(height: 300.h),
                          ],
                        ),
                      ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(15.r),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButtonComponent(
                onTap: () => Get.back(),
                iconLink: IconsAssetsConstants.closeIcon,
                buttonWidth: 23.r,
                buttonHeight: 23.r,
                iconWidth: 15.r,
                iconHeight: 15.r,
                backgroundColor:
                    MainColors.disableColor(context)?.withOpacity(0.5),
                iconColor: MainColors.whiteColor,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
