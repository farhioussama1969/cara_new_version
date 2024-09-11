import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:solvodev_mobile_structure/app/core/components/animations/loading_component.dart';
import 'package:solvodev_mobile_structure/app/core/components/cards/subscription_card_component.dart';
import 'package:solvodev_mobile_structure/app/core/components/others/empty_component.dart';
import 'package:solvodev_mobile_structure/app/core/components/others/header_component.dart';
import 'package:solvodev_mobile_structure/app/core/constants/get_builders_ids_constants.dart';
import 'package:solvodev_mobile_structure/app/core/constants/strings_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/styles/main_colors.dart';
import 'package:solvodev_mobile_structure/app/core/styles/text_styles.dart';

import '../controllers/subscriptions_controller.dart';

class SubscriptionsView extends GetView<SubscriptionsController> {
  const SubscriptionsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderComponent(
        isBack: true,
        actionWidget: Text(
          StringsAssetsConstants.subscriptions,
          style: TextStyles.largeLabelTextStyle(context),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async =>
            Future.delayed(const Duration(milliseconds: 1500), () {
          controller.changeSubscriptions([]);
          controller.getSubscriptions();
        }),
        backgroundColor: MainColors.backgroundColor(context),
        color: MainColors.primaryColor,
        child: SizedBox(
          height: 1.sh,
          child: GetBuilder<SubscriptionsController>(
              id: GetBuildersIdsConstants.subscriptionsList,
              builder: (logic) {
                return Stack(
                  children: [
                    SingleChildScrollView(
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(height: 10.h),
                          SizedBox(
                            child: ((logic.subscriptions.isEmpty == true) &&
                                    !logic.getSubscriptionsLoading)
                                ? Column(
                                    children: [
                                      EmptyComponent(
                                        text: StringsAssetsConstants.emptyCars,
                                      ),
                                      SizedBox(height: 20.h),
                                    ],
                                  )
                                : (logic.getSubscriptionsLoading &&
                                        (logic.subscriptions ?? []).isEmpty ==
                                            true)
                                    ? Padding(
                                        padding: EdgeInsetsDirectional.only(
                                            top: 50.h, bottom: 50.h),
                                        child: const Center(
                                          child: LoadingComponent(),
                                        ),
                                      )
                                    : Stack(
                                        children: [
                                          ListView.separated(
                                            padding: EdgeInsetsDirectional.only(
                                              start: 20.w,
                                              end: 20.w,
                                              top: 5.h,
                                              bottom: 30.h,
                                            ),
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              return GestureDetector(
                                                onTap: () {},
                                                child:
                                                    SubscriptionCardComponent(
                                                  subscription: logic
                                                      .subscriptions[index],
                                                ),
                                              )
                                                  .animate(
                                                      delay: (index * 50).ms)
                                                  .fadeIn(
                                                      duration: 900.ms,
                                                      delay: 300.ms)
                                                  .move(
                                                    begin: const Offset(200, 0),
                                                    duration: 500.ms,
                                                  );
                                            },
                                            separatorBuilder: (context, index) {
                                              return SizedBox(height: 10.h);
                                            },
                                            itemCount:
                                                logic.subscriptions.length ?? 0,
                                          ),
                                        ],
                                      ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }
}
