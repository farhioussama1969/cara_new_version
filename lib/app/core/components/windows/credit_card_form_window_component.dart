import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:solvodev_mobile_structure/app/core/components/buttons/icon_button_component.dart';
import 'package:solvodev_mobile_structure/app/core/components/buttons/primary_button_component.dart';
import 'package:solvodev_mobile_structure/app/core/constants/icons_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/constants/images_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/styles/main_colors.dart';
import 'package:solvodev_mobile_structure/app/core/utils/validator_util.dart';

import '../../constants/strings_assets_constants.dart';
import '../../styles/text_styles.dart';

class CreditCardFormWindowComponent extends StatefulWidget {
  const CreditCardFormWindowComponent({
    super.key,
    required this.loading,
    required this.onConfirm,
    required this.totalPrice,
  });

  final bool loading;
  final Function(
          String number, String expiredDate, String cvv, String? holderName)
      onConfirm;
  final double totalPrice;

  @override
  State<CreditCardFormWindowComponent> createState() =>
      _CreditCardFormWindowComponentState();
}

class _CreditCardFormWindowComponentState
    extends State<CreditCardFormWindowComponent> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState<String>> cardNumberKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> cvvCodeKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> expiryDateKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> cardHolderKey =
      GlobalKey<FormFieldState<String>>();

  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool showBackView = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding:
              EdgeInsetsDirectional.only(start: 20.w, end: 20.w, top: 15.h),
          decoration: BoxDecoration(
            color: MainColors.backgroundColor(context),
            borderRadius: BorderRadiusDirectional.vertical(
              top: Radius.circular(30.r),
            ),
          ),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Text(
                    StringsAssetsConstants.paymentByCreditCard,
                    style: TextStyles.mediumLabelTextStyle(context),
                  ),
                ),
                SizedBox(height: 10.h),
                Flexible(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.w,
                            vertical: 15.h,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  '${StringsAssetsConstants.totalPrice}:',
                                  style:
                                      TextStyles.mediumLabelTextStyle(context),
                                ),
                              ),
                              SizedBox(width: 10.w),
                              Text(
                                  '${widget.totalPrice.floor()} ${StringsAssetsConstants.currency}',
                                  style:
                                      TextStyles.mediumLabelTextStyle(context)
                                          .copyWith(
                                    color: MainColors.primaryColor,
                                  )),
                            ],
                          )
                              .animate(delay: (100).ms)
                              .fadeIn(duration: 900.ms, delay: 300.ms)
                              .move(
                                begin: const Offset(-200, 0),
                                duration: 500.ms,
                              ),
                        ),
                        CreditCardWidget(
                          cardNumber: cardNumber,
                          expiryDate: expiryDate,
                          cardHolderName: cardHolderName ?? '',
                          cvvCode: cvvCode,
                          showBackView: showBackView,
                          onCreditCardWidgetChange: (CreditCardBrand brand) {},
                          backgroundImage:
                              ImagesAssetsConstants.cardBackgroundImage,
                          enableFloatingCard: true,
                          isHolderNameVisible: true,
                          glassmorphismConfig: Glassmorphism(
                            blurX: 2.0,
                            blurY: 2.0,
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: <Color>[
                                Colors.grey.withAlpha(20),
                                Colors.white.withAlpha(20),
                              ],
                              stops: const <double>[
                                0.3,
                                0,
                              ],
                            ),
                          ),
                        )
                            .animate(delay: (100).ms)
                            .fadeIn(duration: 900.ms, delay: 300.ms)
                            .move(
                              begin: const Offset(0, 200),
                              duration: 500.ms,
                            ),
                        CreditCardForm(
                          formKey: formKey, // Required
                          cardNumber: cardNumber,
                          expiryDate: expiryDate,
                          cardHolderName: cardHolderName,
                          cvvCode: cvvCode,
                          cardNumberKey: cardNumberKey,
                          cvvCodeKey: cvvCodeKey,
                          expiryDateKey: expiryDateKey,
                          cardHolderKey: cardHolderKey,
                          onCreditCardModelChange: (CreditCardModel data) {
                            setState(() {
                              cardNumber = data.cardNumber;
                              expiryDate = data.expiryDate;
                              cardHolderName = data.cardHolderName;
                              cvvCode = data.cvvCode;
                              showBackView = data.isCvvFocused;
                            });
                          }, // Required
                          obscureCvv: true,
                          obscureNumber: false,
                          isHolderNameVisible: true,
                          isCardNumberVisible: true,
                          isExpiryDateVisible: true,
                          enableCvv: true,
                          cvvValidationMessage:
                              '${StringsAssetsConstants.check} ${StringsAssetsConstants.cvv}',
                          dateValidationMessage:
                              '${StringsAssetsConstants.check} ${StringsAssetsConstants.expiryDate}',
                          numberValidationMessage:
                              '${StringsAssetsConstants.check} ${StringsAssetsConstants.cardNumber}',
                          cardNumberValidator: (String? cardNumber) {
                            return ValidatorUtil.creditCardNumberValidation(
                                cardNumber ?? '',
                                customMessage:
                                    '${StringsAssetsConstants.check} ${StringsAssetsConstants.cardNumber}');
                          },
                          expiryDateValidator: (String? expiryDate) {
                            return ValidatorUtil.creditCardExpiredDateValidation(
                                expiryDate ?? '',
                                customMessage:
                                    '${StringsAssetsConstants.check} ${StringsAssetsConstants.expiryDate}');
                          },
                          cvvValidator: (String? cvv) {
                            return ValidatorUtil.creditCardCvvValidation(
                                cvv ?? '', cardNumber,
                                customMessage:
                                    '${StringsAssetsConstants.check} ${StringsAssetsConstants.cvv}');
                          },
                          cardHolderValidator: (String? cardHolderName) {},
                          onFormComplete: () {
                            print('form complete');
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          disableCardNumberAutoFillHints: false,
                          inputConfiguration: InputConfiguration(
                            cardNumberDecoration: InputDecoration(
                              counterText: '',
                              hintStyle: TextStyles.mediumBodyTextStyle(context)
                                  .copyWith(
                                color: MainColors.disableColor(context),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20.w, vertical: 18.h),
                              errorStyle: TextStyles.smallBodyTextStyle(context)
                                  .copyWith(
                                color: MainColors.errorColor(context),
                                fontSize: 13.sp,
                                overflow: TextOverflow.fade,
                              ),
                              errorMaxLines: 2,
                              fillColor: MainColors.inputColor(context),
                              filled: true,
                              hintText:
                                  '${StringsAssetsConstants.enter} ${StringsAssetsConstants.cardNumber}...',
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(1000.r),
                                borderSide: BorderSide(
                                  color: MainColors.errorColor(context)!,
                                  width: 1,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(1000.r),
                                borderSide: const BorderSide(
                                  color: MainColors.primaryColor,
                                  width: 1,
                                ),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(1000.r),
                                borderSide: BorderSide(
                                  color: MainColors.disableColor(context)!
                                      .withOpacity(0.2),
                                  width: 1,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(1000.r),
                                borderSide: const BorderSide(
                                  color: MainColors.primaryColor,
                                  width: 1,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(1000.r),
                                borderSide: const BorderSide(
                                  color: MainColors.transparentColor,
                                  width: 1,
                                ),
                              ),
                              suffixIconConstraints: BoxConstraints(
                                minWidth: 25.w,
                                minHeight: 25.w,
                              ),
                            ),
                            expiryDateDecoration: InputDecoration(
                              counterText: '',
                              hintStyle: TextStyles.mediumBodyTextStyle(context)
                                  .copyWith(
                                color: MainColors.disableColor(context),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20.w, vertical: 18.h),
                              errorStyle: TextStyles.smallBodyTextStyle(context)
                                  .copyWith(
                                color: MainColors.errorColor(context),
                                fontSize: 13.sp,
                                overflow: TextOverflow.fade,
                              ),
                              errorMaxLines: 2,
                              fillColor: MainColors.inputColor(context),
                              filled: true,
                              hintText:
                                  '${StringsAssetsConstants.enter} ${StringsAssetsConstants.expiryDate}...',
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(1000.r),
                                borderSide: BorderSide(
                                  color: MainColors.errorColor(context)!,
                                  width: 1,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(1000.r),
                                borderSide: const BorderSide(
                                  color: MainColors.primaryColor,
                                  width: 1,
                                ),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(1000.r),
                                borderSide: BorderSide(
                                  color: MainColors.disableColor(context)!
                                      .withOpacity(0.2),
                                  width: 1,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(1000.r),
                                borderSide: const BorderSide(
                                  color: MainColors.primaryColor,
                                  width: 1,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(1000.r),
                                borderSide: const BorderSide(
                                  color: MainColors.transparentColor,
                                  width: 1,
                                ),
                              ),
                              suffixIconConstraints: BoxConstraints(
                                minWidth: 25.w,
                                minHeight: 25.w,
                              ),
                            ),
                            cvvCodeDecoration: InputDecoration(
                              counterText: '',
                              hintStyle: TextStyles.mediumBodyTextStyle(context)
                                  .copyWith(
                                color: MainColors.disableColor(context),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20.w, vertical: 18.h),
                              errorStyle: TextStyles.smallBodyTextStyle(context)
                                  .copyWith(
                                color: MainColors.errorColor(context),
                                fontSize: 13.sp,
                                overflow: TextOverflow.fade,
                              ),
                              errorMaxLines: 2,
                              fillColor: MainColors.inputColor(context),
                              filled: true,
                              hintText:
                                  '${StringsAssetsConstants.enter} ${StringsAssetsConstants.cvv}...',
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(1000.r),
                                borderSide: BorderSide(
                                  color: MainColors.errorColor(context)!,
                                  width: 1,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(1000.r),
                                borderSide: const BorderSide(
                                  color: MainColors.primaryColor,
                                  width: 1,
                                ),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(1000.r),
                                borderSide: BorderSide(
                                  color: MainColors.disableColor(context)!
                                      .withOpacity(0.2),
                                  width: 1,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(1000.r),
                                borderSide: const BorderSide(
                                  color: MainColors.primaryColor,
                                  width: 1,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(1000.r),
                                borderSide: const BorderSide(
                                  color: MainColors.transparentColor,
                                  width: 1,
                                ),
                              ),
                              suffixIconConstraints: BoxConstraints(
                                minWidth: 25.w,
                                minHeight: 25.w,
                              ),
                            ),
                            cardHolderDecoration: InputDecoration(
                              counterText: '',
                              hintStyle: TextStyles.mediumBodyTextStyle(context)
                                  .copyWith(
                                color: MainColors.disableColor(context),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20.w, vertical: 18.h),
                              errorStyle: TextStyles.smallBodyTextStyle(context)
                                  .copyWith(
                                color: MainColors.errorColor(context),
                                fontSize: 13.sp,
                                overflow: TextOverflow.fade,
                              ),
                              errorMaxLines: 2,
                              fillColor: MainColors.inputColor(context),
                              filled: true,
                              hintText:
                                  '${StringsAssetsConstants.enter} ${StringsAssetsConstants.cardHolderName}...',
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(1000.r),
                                borderSide: BorderSide(
                                  color: MainColors.errorColor(context)!,
                                  width: 1,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(1000.r),
                                borderSide: const BorderSide(
                                  color: MainColors.primaryColor,
                                  width: 1,
                                ),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(1000.r),
                                borderSide: BorderSide(
                                  color: MainColors.disableColor(context)!
                                      .withOpacity(0.2),
                                  width: 1,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(1000.r),
                                borderSide: const BorderSide(
                                  color: MainColors.primaryColor,
                                  width: 1,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(1000.r),
                                borderSide: const BorderSide(
                                  color: MainColors.transparentColor,
                                  width: 1,
                                ),
                              ),
                              suffixIconConstraints: BoxConstraints(
                                minWidth: 25.w,
                                minHeight: 25.w,
                              ),
                            ),
                            cardNumberTextStyle:
                                TextStyles.largeBodyTextStyle(context),
                            cardHolderTextStyle:
                                TextStyles.largeBodyTextStyle(context),
                            expiryDateTextStyle:
                                TextStyles.largeBodyTextStyle(context),
                            cvvCodeTextStyle:
                                TextStyles.largeBodyTextStyle(context),
                          ),
                        )
                            .animate(delay: (150).ms)
                            .fadeIn(duration: 900.ms, delay: 300.ms)
                            .move(
                              begin: const Offset(0, 200),
                              duration: 500.ms,
                            ),
                        SizedBox(height: 30.h),
                        PrimaryButtonComponent(
                          onTap: () {
                            if (!formKey.currentState!.validate()) return;
                            widget.onConfirm(
                              cardNumber,
                              expiryDate,
                              cvvCode,
                              cardHolderName,
                            );
                          },
                          text: StringsAssetsConstants.confirm,
                          width: 0.7.sw,
                        )
                            .animate(delay: (200).ms)
                            .fadeIn(duration: 900.ms, delay: 300.ms)
                            .move(
                              begin: const Offset(0, 200),
                              duration: 500.ms,
                            ),
                        SizedBox(height: 30.h),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(15.r),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButtonComponent(
                onTap: () => Get.back(),
                iconLink: IconsAssetsConstants.closeIcon,
                buttonWidth: 23.r,
                buttonHeight: 23.r,
                iconWidth: 15.r,
                iconHeight: 15.r,
                backgroundColor:
                    MainColors.disableColor(context)?.withOpacity(0.5),
                iconColor: MainColors.whiteColor,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
