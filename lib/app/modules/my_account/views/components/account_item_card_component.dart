import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:solvodev_mobile_structure/app/core/constants/fonts_family_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/styles/main_colors.dart';
import 'package:solvodev_mobile_structure/app/core/styles/text_styles.dart';

class AccountItemCardComponent extends StatelessWidget {
  const AccountItemCardComponent(
      {super.key,
      required this.iconPath,
      required this.title,
      required this.onTap,
      this.iconColor});

  final String iconPath;
  final String title;
  final Function onTap;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        color: MainColors.backgroundColor(context),
        child: Row(
          children: [
            SvgPicture.asset(
              iconPath,
              width: 25.r,
              height: 25.r,
              color: iconColor ?? MainColors.primaryColor,
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Text(
                title,
                style: TextStyles.largeBodyTextStyle(context).copyWith(
                  fontFamily: FontsFamilyAssetsConstants.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
