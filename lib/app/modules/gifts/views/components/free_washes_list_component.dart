import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:solvodev_mobile_structure/app/core/constants/animations_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/constants/icons_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/constants/logos_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/styles/main_colors.dart';

class FreeWashingListComponent extends StatelessWidget {
  const FreeWashingListComponent(
      {super.key,
      required this.maxOrdersNumber,
      required this.currentOrderNumber});

  final int maxOrdersNumber;
  final int currentOrderNumber;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: maxOrdersNumber,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
          ),
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          itemBuilder: (context, index) {
            return Stack(
              children: [
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  padding: index + 1 != maxOrdersNumber
                      ? EdgeInsets.all(10.r)
                      : null,
                  margin: EdgeInsets.all(10.r),
                  decoration: BoxDecoration(
                    border: Border.all(color: MainColors.primaryColor),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: index + 1 != maxOrdersNumber
                      ? SvgPicture.asset(
                          LogosAssetsConstants.appLogoVector,
                          color: !(index >= currentOrderNumber)
                              ? MainColors.primaryColor
                              : Colors.grey,
                        )
                      : Lottie.asset(
                          AnimationsAssetsConstants.giftAnimation,
                          fit: BoxFit.contain,
                          width: 50.r,
                          height: 50.r,
                        ),
                ),
                Container(
                  padding: EdgeInsets.all(3.r),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(1000),
                    border: Border.all(color: MainColors.primaryColor),
                  ),
                  child: SvgPicture.asset(
                    !(index >= currentOrderNumber)
                        ? IconsAssetsConstants.checked2Icon
                        : IconsAssetsConstants.waitingIcon,
                    color: !(index >= currentOrderNumber)
                        ? MainColors.successColor(context)
                        : MainColors.warningColor(context),
                    width: 22.r,
                    height: 22.r,
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
