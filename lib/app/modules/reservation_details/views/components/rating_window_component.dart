import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_pannable_rating_bar/flutter_pannable_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:solvodev_mobile_structure/app/core/components/buttons/icon_button_component.dart';
import 'package:solvodev_mobile_structure/app/core/components/buttons/primary_button_component.dart';
import 'package:solvodev_mobile_structure/app/core/components/inputs/text_input_component.dart';
import 'package:solvodev_mobile_structure/app/core/constants/icons_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/constants/strings_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/styles/main_colors.dart';
import 'package:solvodev_mobile_structure/app/core/styles/text_styles.dart';

class RatingWindowComponent extends StatelessWidget {
  const RatingWindowComponent(
      {super.key,
      required this.onConfirm,
      required this.ratingValue,
      required this.ratingNoteController,
      required this.changeRatingValue,
      required this.loading});

  final Function onConfirm;
  final double? ratingValue;
  final TextEditingController ratingNoteController;
  final Function(double value) changeRatingValue;
  final bool loading;

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
                    StringsAssetsConstants.serviceRating,
                    style: TextStyles.mediumLabelTextStyle(context),
                  ),
                ),
                SizedBox(height: 40.h),
                Container(
                  width: double.infinity,
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
                  decoration: BoxDecoration(
                    color: MainColors.backgroundColor(context),
                    boxShadow: [
                      BoxShadow(
                        color: MainColors.shadowColor(context)!,
                        blurRadius: 10.r,
                        offset: Offset(0, 0),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Column(
                    children: [
                      PannableRatingBar(
                        rate: ratingValue ?? 0.0,
                        items: List.generate(
                          5,
                          (index) => RatingWidget(
                            selectedColor: MainColors.primaryColor,
                            unSelectedColor: MainColors.disableColor(context),
                            child: SvgPicture.asset(
                              IconsAssetsConstants.starIcon,
                              width: 40.r,
                            ),
                          ),
                        ),
                        onChanged: (value) => changeRatingValue(value),
                      ),
                      SizedBox(height: 30.h),
                      TextInputComponent(
                        controller: ratingNoteController,
                        hint:
                            '${StringsAssetsConstants.ratingNoteHint} (${StringsAssetsConstants.optional})',
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 70.h),
                if (ratingValue != null)
                  PrimaryButtonComponent(
                    onTap: () => onConfirm(),
                    text: StringsAssetsConstants.confirm,
                    isLoading: loading,
                    width: 0.7.sw,
                  )
                      .animate(delay: (150).ms)
                      .fadeIn(duration: 900.ms, delay: 300.ms)
                      .move(
                        begin: const Offset(0, 200),
                        duration: 500.ms,
                      ),
                SizedBox(height: 30.h),
              ],
            ),
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
