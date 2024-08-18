import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:solvodev_mobile_structure/app/core/constants/fonts_family_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/styles/main_colors.dart';
import 'package:solvodev_mobile_structure/app/core/styles/text_styles.dart';
import 'package:solvodev_mobile_structure/app/core/utils/relative_date_util.dart';
import 'package:solvodev_mobile_structure/app/data/models/working_time_model.dart';

class WorkingHourTimeCardComponent extends StatelessWidget {
  const WorkingHourTimeCardComponent(
      {super.key, required this.isSelected, required this.time});

  final bool isSelected;
  final TimeModel time;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: 100.w,
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: isSelected
            ? MainColors.primaryColor
            : MainColors.backgroundColor(context),
        boxShadow: [
          BoxShadow(
            color: MainColors.shadowColor(context)!.withOpacity(0.7),
            blurRadius: 10,
            offset: const Offset(0, 0),
          ),
        ],
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${time?.value}',
            style: TextStyles.mediumBodyTextStyle(context).copyWith(
              fontFamily: FontsFamilyAssetsConstants.bold,
              color: isSelected
                  ? MainColors.whiteColor
                  : MainColors.textColor(context),
            ),
          ),
          Divider(
            color: isSelected
                ? MainColors.whiteColor
                : MainColors.textColor(context)!.withOpacity(0.2),
          ),
          Text(
            '${RelativeDateUtil.changeHourFormat(time.value).substring(0, 5)}',
            style: TextStyles.largeBodyTextStyle(context).copyWith(
              color: isSelected
                  ? MainColors.whiteColor
                  : MainColors.textColor(context),
            ),
          ),
        ],
      ),
    );
  }
}
