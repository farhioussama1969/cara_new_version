import 'package:flutter/cupertino.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:solvodev_mobile_structure/app/core/components/buttons/icon_button_component.dart';
import 'package:solvodev_mobile_structure/app/core/components/buttons/primary_button_component.dart';
import 'package:solvodev_mobile_structure/app/core/components/cards/my_car_card_component.dart';
import 'package:solvodev_mobile_structure/app/core/components/cards/tag_component.dart';
import 'package:solvodev_mobile_structure/app/core/components/others/empty_component.dart';
import 'package:solvodev_mobile_structure/app/core/constants/icons_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/constants/strings_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/styles/main_colors.dart';
import 'package:solvodev_mobile_structure/app/core/styles/text_styles.dart';
import 'package:solvodev_mobile_structure/app/data/models/car_brand_model.dart';
import 'package:solvodev_mobile_structure/app/data/models/car_model.dart';

import '../../../../core/components/animations/loading_component.dart';

class MyCarsWindowComponent extends StatelessWidget {
  const MyCarsWindowComponent(
      {super.key,
      required this.carsList,
      this.selectedCardId,
      required this.onCarSelected,
      required this.loading,
      required this.onConfirm,
      required this.scrollController});

  final List<CarModel> carsList;
  final int? selectedCardId;
  final Function(CarModel) onCarSelected;
  final bool loading;
  final Function onConfirm;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding:
              EdgeInsetsDirectional.only(start: 20.w, end: 20.w, top: 15.h),
          decoration: BoxDecoration(
            color: MainColors.backgroundColor(context),
            borderRadius: BorderRadiusDirectional.vertical(
              top: Radius.circular(30.r),
            ),
          ),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Text(
                    StringsAssetsConstants.selectYourCar,
                    style: TextStyles.mediumLabelTextStyle(context),
                  ),
                ),
                SizedBox(height: 15.h),
                Flexible(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    controller: scrollController,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 10.h),
                        SizedBox(
                          child: ((carsList.isEmpty) && !loading)
                              ? Column(
                                  children: [
                                    const EmptyComponent(
                                      text: '',
                                    ),
                                    SizedBox(height: 20.h),
                                  ],
                                )
                              : (loading)
                                  ? Padding(
                                      padding: EdgeInsetsDirectional.only(
                                          top: 10.h, bottom: 50.h),
                                      child: const Center(
                                        child: LoadingComponent(),
                                      ),
                                    )
                                  : Stack(
                                      children: [
                                        ListView.separated(
                                          padding: EdgeInsetsDirectional.only(
                                            start: 20.w,
                                            end: 20.w,
                                            top: 5.h,
                                            bottom: (selectedCardId != null)
                                                ? 100.h
                                                : 30.h,
                                          ),
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                              onTap: () => onCarSelected(
                                                  carsList[index]),
                                              child: MyCarCardComponent(
                                                car: carsList[index],
                                                isSelected: selectedCardId ==
                                                    carsList[index].id,
                                              ),
                                            )
                                                .animate(delay: (index * 50).ms)
                                                .fadeIn(
                                                    duration: 900.ms,
                                                    delay: 300.ms)
                                                .move(
                                                  begin: const Offset(200, 0),
                                                  duration: 500.ms,
                                                );
                                          },
                                          separatorBuilder: (context, index) {
                                            return SizedBox(height: 10.h);
                                          },
                                          itemCount: carsList.length,
                                        ),
                                      ],
                                    ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (selectedCardId != null)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      PrimaryButtonComponent(
                        onTap: () => onConfirm(),
                        text: StringsAssetsConstants.confirm,
                        width: 0.7.sw,
                      )
                          .animate(delay: (150).ms)
                          .fadeIn(duration: 900.ms, delay: 300.ms)
                          .move(
                            begin: const Offset(200, 0),
                            duration: 500.ms,
                          ),
                      SizedBox(height: 15.h),
                    ],
                  ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(15.r),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TagComponent(
                title: StringsAssetsConstants.addCar,
              ),
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
