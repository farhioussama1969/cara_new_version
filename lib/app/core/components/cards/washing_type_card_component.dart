import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:solvodev_mobile_structure/app/core/components/animations/animator_component.dart';
import 'package:solvodev_mobile_structure/app/core/constants/icons_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/styles/main_colors.dart';
import 'package:solvodev_mobile_structure/app/core/styles/text_styles.dart';
import 'package:solvodev_mobile_structure/app/data/models/washing_type_model.dart';

class WashingTypeCardComponent extends StatelessWidget {
  const WashingTypeCardComponent(
      {super.key, this.washingType, required this.isSelected});

  final WashingTypeModel? washingType;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 15.h,
          ),
          decoration: BoxDecoration(
            color: MainColors.backgroundColor(context),
            borderRadius: BorderRadius.circular(10.r),
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
                spreadRadius: 0,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          child: Row(
            children: [
              SvgPicture.asset(
                IconsAssetsConstants.washingTypeIcon,
                width: 34.r,
                height: 34.r,
                color: MainColors.primaryColor,
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Text(
                  washingType?.name ?? '/',
                  style: TextStyles.largeBodyTextStyle(context),
                ),
              ),
            ],
          ),
        ),
        Positioned.fill(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.only(end: 10.w),
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
