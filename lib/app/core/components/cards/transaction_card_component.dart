import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:solvodev_mobile_structure/app/core/constants/fonts_family_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/constants/strings_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/styles/main_colors.dart';
import 'package:solvodev_mobile_structure/app/core/styles/text_styles.dart';
import 'package:solvodev_mobile_structure/app/core/utils/relative_date_util.dart';
import 'package:solvodev_mobile_structure/app/data/models/transaction_model.dart';

class TransactionCardComponent extends StatelessWidget {
  const TransactionCardComponent({super.key, this.transactions});

  final TransactionsModel? transactions;

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
                child: RichText(
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    text:
                        '${RelativeDateUtil.numToDay(DateTime.parse(transactions?.date ?? '').weekday)} ',
                    style: TextStyles.mediumBodyTextStyle(context),
                    children: [
                      TextSpan(
                        text:
                            '${DateTime.parse(transactions?.date ?? '').day} ',
                        style: TextStyles.mediumBodyTextStyle(context).copyWith(
                          color: MainColors.primaryColor,
                          fontFamily: FontsFamilyAssetsConstants.bold,
                        ),
                      ),
                      TextSpan(
                        text:
                            '${RelativeDateUtil.numToMonth(DateTime.parse(transactions?.date ?? '').month)} ',
                        style: TextStyles.mediumBodyTextStyle(context),
                      ),
                      TextSpan(
                        text:
                            '${DateTime.parse(transactions?.date ?? '').year} ',
                        style: TextStyles.mediumBodyTextStyle(context).copyWith(
                          color: MainColors.primaryColor,
                          fontFamily: FontsFamilyAssetsConstants.bold,
                        ),
                      ),
                      TextSpan(
                        text: ' | ',
                        style: TextStyles.mediumBodyTextStyle(context),
                      ),
                      TextSpan(
                        text:
                            '${RelativeDateUtil.changeHourFormat(DateTime.parse(transactions?.date ?? '').toString().substring(10, 16))} ',
                        style: TextStyles.mediumBodyTextStyle(context).copyWith(
                          color: MainColors.primaryColor,
                          fontFamily: FontsFamilyAssetsConstants.bold,
                        ),
                      ),
                      TextSpan(
                        text:
                            '${RelativeDateUtil.getAmPmFromTime(DateTime.parse(transactions?.date ?? '').toString().substring(10, 16)).substring(0, 5)} ',
                        style: TextStyles.mediumBodyTextStyle(context),
                      ),
                    ],
                  ),
                ),
              ),
              Text(
                '${transactions?.debit != 0 ? '${transactions?.debit ?? 0}-' : '${transactions?.credit ?? 0}+'} ${StringsAssetsConstants.currency}',
                style: TextStyles.mediumLabelTextStyle(context).copyWith(
                  color: transactions?.debit != 0
                      ? MainColors.errorColor(context)
                      : MainColors.successColor(context),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Row(
            children: [
              // Expanded(
              //   child: Text(
              //     transactions?.transactionTypeAr ?? '',
              //     style: TextStyles.mediumLabelTextStyle(context),
              //   ),
              // ),
              Expanded(
                  child: RichText(
                text: TextSpan(
                  text: '${StringsAssetsConstants.transactionType}: ',
                  style: TextStyles.largeBodyTextStyle(context),
                  children: [
                    TextSpan(
                      text: transactions?.transactionTypeAr ?? '',
                      style: TextStyles.mediumLabelTextStyle(context),
                    ),
                  ],
                ),
              )),
            ],
          ),
        ],
      ),
    );
  }
}
