import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:solvodev_mobile_structure/app/core/components/images/network_image_component.dart';
import 'package:solvodev_mobile_structure/app/core/styles/main_colors.dart';
import 'package:solvodev_mobile_structure/app/data/models/subscription_plan_model.dart';

class SubscriptionCardComponent extends StatelessWidget {
  const SubscriptionCardComponent({super.key, this.subscription});

  final SubscriptionPlanModel? subscription;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.r),
      child: Container(
        height: 220.h,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: MainColors.primaryColor, width: 1.5.r),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: NetworkImageComponent(
          imageLink: subscription?.image ?? '',
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
