import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:solvodev_mobile_structure/app/core/styles/main_colors.dart';
import 'package:solvodev_mobile_structure/app/core/styles/text_styles.dart';

class BottomNavigationCarItemComponent extends StatelessWidget {
  const BottomNavigationCarItemComponent(
      {super.key,
      required this.enabledIconPath,
      required this.disabledIconPath,
      required this.isEnabled,
      required this.onTap,
      required this.title});

  final String enabledIconPath;
  final String disabledIconPath;
  final String title;
  final bool isEnabled;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SvgPicture.asset(
          isEnabled ? enabledIconPath : disabledIconPath,
          width: 24.r,
          height: 24.r,
          color: isEnabled
              ? MainColors.primaryColor
              : MainColors.textColor(context)!.withOpacity(0.6),
        ),
        SizedBox(height: 5.h),
        Center(
          child: Text(
            title,
            style: TextStyles.mediumBodyTextStyle(context).copyWith(
              color: isEnabled
                  ? MainColors.primaryColor
                  : MainColors.textColor(context)!.withOpacity(0.6),
            ),
          ),
        ),
      ],
    );
  }
}
