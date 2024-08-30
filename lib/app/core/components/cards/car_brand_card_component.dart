import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:solvodev_mobile_structure/app/core/components/animations/animator_component.dart';
import 'package:solvodev_mobile_structure/app/core/components/images/network_image_component.dart';
import 'package:solvodev_mobile_structure/app/core/constants/fonts_family_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/constants/icons_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/styles/main_colors.dart';
import 'package:solvodev_mobile_structure/app/core/styles/text_styles.dart';
import 'package:solvodev_mobile_structure/app/data/models/car_brand_model.dart';

class CarBrandCardComponent extends StatelessWidget {
  const CarBrandCardComponent(
      {super.key, required this.carBrand, required this.isSelected});

  final CarBrandModel carBrand;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
          decoration: BoxDecoration(
            color: MainColors.backgroundColor(context),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: isSelected
                  ? MainColors.primaryColor
                  : MainColors.transparentColor,
              width: 2.r,
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
              ClipRRect(
                borderRadius: BorderRadius.circular(1000.r),
                child: Container(
                  padding: EdgeInsets.all(4.r),
                  height: 40.r,
                  width: 40.r,
                  child: NetworkImageComponent(
                    imageLink: '${carBrand.logo}',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Text(
                  carBrand?.name ?? '',
                  style: TextStyles.largeBodyTextStyle(context).copyWith(
                    color: isSelected
                        ? MainColors.primaryColor
                        : MainColors.textColor(context),
                    fontFamily: isSelected
                        ? FontsFamilyAssetsConstants.bold
                        : FontsFamilyAssetsConstants.regular,
                  ),
                ),
              ),
            ],
          ),
        ),
        if (isSelected)
          Positioned.fill(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.only(end: 20.w),
                  child: AnimatorComponent(
                    time: const Duration(microseconds: 100),
                    child: SvgPicture.asset(
                      IconsAssetsConstants.checkedIcon,
                      width: 22.r,
                      height: 22.r,
                      color: MainColors.primaryColor,
                    ),
                  ),
                )
              ],
            ),
          ),
      ],
    );
  }
}
