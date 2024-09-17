import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:solvodev_mobile_structure/app/core/styles/main_colors.dart';
import 'package:solvodev_mobile_structure/app/core/styles/text_styles.dart';

class OtpInputComponent extends StatelessWidget {
  const OtpInputComponent({Key? key, this.controller, required this.length})
      : super(key: key);

  final TextEditingController? controller;
  final int length;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: PinCodeTextField(
        autoDisposeControllers: false,
        scrollPadding: EdgeInsets.zero,
        length: length,
        obscureText: false,
        animationType: AnimationType.fade,
        hintCharacter: '-',
        pinTheme: PinTheme(
          fieldOuterPadding: EdgeInsets.symmetric(horizontal: 5.w),
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(8.r),
          fieldHeight: 75.h,
          fieldWidth: 50.w,
          borderWidth: 1,
          activeColor: MainColors.textColor(context),
          disabledColor: MainColors.disableColor(context),
          selectedFillColor: MainColors.inputColor(context),
          activeFillColor: MainColors.backgroundColor(context),
          errorBorderColor: MainColors.errorColor(context),
          inactiveColor: MainColors.disableColor(context),
          inactiveFillColor: MainColors.inputColor(context),
          selectedColor: MainColors.primaryColor,
        ),
        animationDuration: const Duration(milliseconds: 300),
        backgroundColor: MainColors.transparentColor,
        cursorColor: MainColors.primaryColor,
        enableActiveFill: true,
        textStyle: TextStyles.mediumLabelTextStyle(context),
        keyboardType: TextInputType.number,
        enablePinAutofill: true,
        controller: controller,
        onCompleted: (v) {},
        onChanged: (value) {},
        beforeTextPaste: (text) => true,
        appContext: context,
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
  }
}
