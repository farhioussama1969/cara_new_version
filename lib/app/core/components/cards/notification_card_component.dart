import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:solvodev_mobile_structure/app/core/styles/main_colors.dart';
import 'package:solvodev_mobile_structure/app/core/styles/text_styles.dart';
import 'package:solvodev_mobile_structure/app/core/utils/relative_date_util.dart';
import 'package:solvodev_mobile_structure/app/data/models/notification_model.dart';

class NotificationCardComponent extends StatelessWidget {
  const NotificationCardComponent({super.key, this.notification});

  final NotificationModel? notification;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
      decoration: BoxDecoration(
        color: MainColors.backgroundColor(context),
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: MainColors.shadowColor(context)!,
            blurRadius: 10.r,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  notification?.title ?? '',
                  style: TextStyles.mediumLabelTextStyle(context),
                ),
              ),
              Text(
                '${notification?.createdAt?.substring(0, 8).replaceAll('-', '/')} | ${notification?.createdAt?.substring(8, 14)}',
                style: TextStyles.mediumBodyTextStyle(context).copyWith(
                  color: MainColors.primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Row(
            children: [
              Expanded(
                child: Text(
                  notification?.message ?? '',
                  style: TextStyles.mediumBodyTextStyle(context),
                  textAlign: TextAlign.justify,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
