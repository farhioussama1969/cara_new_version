import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:solvodev_mobile_structure/app/core/components/images/network_image_component.dart';
import 'package:solvodev_mobile_structure/app/core/constants/fonts_family_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/constants/strings_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/styles/main_colors.dart';
import 'package:solvodev_mobile_structure/app/core/styles/text_styles.dart';
import 'package:solvodev_mobile_structure/app/core/utils/color_convertor_util.dart';
import 'package:solvodev_mobile_structure/app/data/models/car_model.dart';

class MyCarCardComponent extends StatelessWidget {
  const MyCarCardComponent(
      {super.key, required this.car, required this.isSelected});

  final CarModel? car;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
      decoration: BoxDecoration(
        color: MainColors.backgroundColor(context),
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(
          color: isSelected
              ? MainColors.primaryColor
              : MainColors.transparentColor,
          width: 3.r,
        ),
        boxShadow: [
          BoxShadow(
            color: MainColors.shadowColor(context)!,
            blurRadius: 10.r,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        '${car?.brand?.name}',
                        style: TextStyles.largeBodyTextStyle(context).copyWith(
                          fontFamily: FontsFamilyAssetsConstants.bold,
                          color: isSelected
                              ? MainColors.primaryColor
                              : MainColors.textColor(context),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5.h),
                Row(
                  children: [
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          text: '${StringsAssetsConstants.carName}: ',
                          style:
                              TextStyles.mediumBodyTextStyle(context).copyWith(
                            color:
                                MainColors.textColor(context)!.withOpacity(0.7),
                          ),
                          children: [
                            TextSpan(
                              text: '${car?.model}',
                              style: TextStyles.mediumBodyTextStyle(context)
                                  .copyWith(
                                fontFamily: FontsFamilyAssetsConstants.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          text: '${StringsAssetsConstants.plateNumber}: ',
                          style:
                              TextStyles.mediumBodyTextStyle(context).copyWith(
                            color:
                                MainColors.textColor(context)!.withOpacity(0.7),
                          ),
                          children: [
                            TextSpan(
                              text: '${car?.numberPlate ?? '/'}',
                              style: TextStyles.mediumBodyTextStyle(context)
                                  .copyWith(
                                fontFamily: FontsFamilyAssetsConstants.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    RichText(
                      text: TextSpan(
                        text: '${StringsAssetsConstants.color}:  ',
                        style: TextStyles.mediumBodyTextStyle(context).copyWith(
                          color:
                              MainColors.textColor(context)!.withOpacity(0.7),
                        ),
                      ),
                    ),
                    Container(
                      height: 22.r,
                      width: 22.r,
                      decoration: BoxDecoration(
                        color: ColorConvertorUtil()
                            .stringColorCodeToColor("#${car?.color}"),
                        borderRadius: BorderRadius.circular(1000.r),
                        border: Border.all(
                          color:
                              MainColors.textColor(context)!.withOpacity(0.3),
                          width: 1.r,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(1000.r),
            child: Container(
              padding: EdgeInsets.all(8.r),
              height: 80.r,
              width: 80.r,
              child: NetworkImageComponent(
                imageLink: '${car?.brand?.logo}',
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
