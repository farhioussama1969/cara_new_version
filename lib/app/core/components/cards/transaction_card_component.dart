import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:solvodev_mobile_structure/app/core/constants/strings_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/styles/main_colors.dart';
import 'package:solvodev_mobile_structure/app/core/styles/text_styles.dart';
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
                    text: TextSpan(
                  children: [
                    TextSpan(
                      text:
                          '${DateTime.parse(transactions?.date ?? '').toString().substring(0, 16)}',
                      style: TextStyles.mediumBodyTextStyle(context).copyWith(
                        color: MainColors.primaryColor,
                      ),
                    ),
                  ],
                )),
              ),
              Text(
                '${transactions?.debit != 0 ? '-${transactions?.debit ?? 0}' : '+${transactions?.credit ?? 0}'} ${StringsAssetsConstants.currency}',
                style: TextStyles.mediumLabelTextStyle(context).copyWith(
                  color: transactions?.debit != 0
                      ? MainColors.errorColor(context)
                      : MainColors.successColor(context),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
