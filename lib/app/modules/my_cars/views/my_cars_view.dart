import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:solvodev_mobile_structure/app/core/components/animations/loading_component.dart';
import 'package:solvodev_mobile_structure/app/core/components/buttons/icon_button_component.dart';
import 'package:solvodev_mobile_structure/app/core/components/cards/my_car_card_component.dart';
import 'package:solvodev_mobile_structure/app/core/components/others/empty_component.dart';
import 'package:solvodev_mobile_structure/app/core/components/others/header_component.dart';
import 'package:solvodev_mobile_structure/app/core/constants/icons_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/constants/strings_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/styles/main_colors.dart';
import 'package:solvodev_mobile_structure/app/core/styles/text_styles.dart';

import '../../../core/constants/get_builders_ids_constants.dart';
import '../controllers/my_cars_controller.dart';

class MyCarsView extends GetView<MyCarsController> {
  const MyCarsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderComponent(
        isBack: false,
        prefixWidget: Text(
          StringsAssetsConstants.myCars,
          style: TextStyles.largeLabelTextStyle(context),
        ),
        actionWidget: IconButtonComponent(
          iconLink: IconsAssetsConstants.addIcon,
          iconColor: MainColors.primaryColor,
          onTap: () {},
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async => Future.delayed(
            const Duration(milliseconds: 1500),
            () => controller.refreshMyCars()),
        backgroundColor: MainColors.backgroundColor(context),
        color: MainColors.primaryColor,
        child: SizedBox(
          height: 1.sh,
          child: GetBuilder<MyCarsController>(
              id: GetBuildersIdsConstants.myCarsList,
              builder: (logic) {
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  controller: logic.myCarsListScrollController,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 10.h),
                      SizedBox(
                        child: ((logic.myCarsList?.data?.isEmpty == true) &&
                                !logic.getMyCarsListLoading)
                            ? Column(
                                children: [
                                  EmptyComponent(
                                    text: StringsAssetsConstants.emptyCars,
                                  ),
                                  SizedBox(height: 20.h),
                                ],
                              )
                            : (logic.getMyCarsListLoading)
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
                                            child: MyCarCardComponent(
                                              car: logic
                                                  .myCarsList?.data?[index],
                                              isSelected: false,
                                            ),
                                          )
                                              .animate(delay: (index * 50).ms)
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
                                            logic.myCarsList?.data?.length ?? 0,
                                      ),
                                    ],
                                  ),
                      ),
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}
