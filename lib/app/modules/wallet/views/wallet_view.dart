import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:solvodev_mobile_structure/app/core/components/animations/loading_component.dart';
import 'package:solvodev_mobile_structure/app/core/components/buttons/icon_button_component.dart';
import 'package:solvodev_mobile_structure/app/core/components/cards/transaction_card_component.dart';
import 'package:solvodev_mobile_structure/app/core/components/others/empty_component.dart';
import 'package:solvodev_mobile_structure/app/core/components/others/header_component.dart';
import 'package:solvodev_mobile_structure/app/core/constants/get_builders_ids_constants.dart';
import 'package:solvodev_mobile_structure/app/core/constants/strings_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/styles/main_colors.dart';
import 'package:solvodev_mobile_structure/app/core/styles/text_styles.dart';

import '../controllers/wallet_controller.dart';

class WalletView extends GetView<WalletController> {
  const WalletView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderComponent(
        isBack: true,
        actionWidget: Text(
          StringsAssetsConstants.myWallet,
          style: TextStyles.largeLabelTextStyle(context),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async => Future.delayed(
            const Duration(milliseconds: 1500),
            () => controller.refreshTransactions()),
        backgroundColor: MainColors.backgroundColor(context),
        color: MainColors.primaryColor,
        child: SizedBox(
          height: 1.sh,
          child: GetBuilder<WalletController>(
              id: GetBuildersIdsConstants.transactionsList,
              builder: (logic) {
                return Column(
                  children: [
                    if (!logic.getTransactionsListLoading)
                      Column(
                        children: [
                          SizedBox(height: 15.h),
                          Center(
                            child: Text(
                              StringsAssetsConstants.walletBalance,
                              style: TextStyles.largeBodyTextStyle(context)
                                  .copyWith(
                                fontSize: 20.sp,
                              ),
                            ),
                          ),
                          SizedBox(height: 5.h),
                          Center(
                            child: Text(
                              '${logic.transactionsList?.amount ?? 0} ${StringsAssetsConstants.currency}',
                              style: TextStyles.largeLabelTextStyle(context)
                                  .copyWith(
                                color: MainColors.primaryColor,
                              ),
                            ),
                          ),
                        ],
                      )
                          .animate(delay: (100).ms)
                          .fadeIn(duration: 900.ms, delay: 300.ms)
                          .move(
                            begin: const Offset(0, 200),
                            duration: 500.ms,
                          ),
                    Expanded(
                      child: Stack(
                        children: [
                          SingleChildScrollView(
                            physics: const BouncingScrollPhysics(
                                parent: AlwaysScrollableScrollPhysics()),
                            controller: logic.transactionsListScrollController,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(height: 10.h),
                                SizedBox(
                                  child: ((logic.transactionsList?.transactions
                                                  ?.data?.isEmpty ==
                                              true) &&
                                          !logic.getTransactionsListLoading)
                                      ? Column(
                                          children: [
                                            EmptyComponent(
                                              text: StringsAssetsConstants
                                                  .emptyDataText,
                                            ),
                                            SizedBox(height: 20.h),
                                          ],
                                        )
                                      : (logic.getTransactionsListLoading &&
                                              (logic
                                                              .transactionsList
                                                              ?.transactions
                                                              ?.data ??
                                                          [])
                                                      .isEmpty ==
                                                  true)
                                          ? Padding(
                                              padding:
                                                  EdgeInsetsDirectional.only(
                                                      top: 50.h, bottom: 50.h),
                                              child: const Center(
                                                child: LoadingComponent(),
                                              ),
                                            )
                                          : Stack(
                                              children: [
                                                ListView.separated(
                                                  padding: EdgeInsetsDirectional
                                                      .only(
                                                    start: 20.w,
                                                    end: 20.w,
                                                    top: 5.h,
                                                    bottom: 30.h,
                                                  ),
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  shrinkWrap: true,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return TransactionCardComponent(
                                                      transactions: logic
                                                          .transactionsList
                                                          ?.transactions
                                                          ?.data?[index],
                                                    )
                                                        .animate(
                                                            delay:
                                                                (index * 50).ms)
                                                        .fadeIn(
                                                            duration: 900.ms,
                                                            delay: 300.ms)
                                                        .move(
                                                          begin: const Offset(
                                                              200, 0),
                                                          duration: 500.ms,
                                                        );
                                                  },
                                                  separatorBuilder:
                                                      (context, index) {
                                                    return SizedBox(
                                                        height: 10.h);
                                                  },
                                                  itemCount: logic
                                                          .transactionsList
                                                          ?.transactions
                                                          ?.data
                                                          ?.length ??
                                                      0,
                                                ),
                                              ],
                                            ),
                                ),
                              ],
                            ),
                          ),
                          if (logic.getTransactionsListLoading &&
                              logic.transactionsList?.transactions?.data
                                      ?.isNotEmpty ==
                                  true)
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsetsDirectional.only(bottom: 20.h),
                                  child: const Center(
                                    child: LoadingComponent(),
                                  ),
                                ),
                              ],
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
