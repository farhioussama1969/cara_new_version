import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:solvodev_mobile_structure/app/core/components/others/header_component.dart';
import 'package:solvodev_mobile_structure/app/core/constants/strings_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/styles/text_styles.dart';

import '../controllers/send_gifts_controller.dart';

class SendGiftsView extends GetView<SendGiftsController> {
  const SendGiftsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderComponent(
        actionWidget: Text(
          StringsAssetsConstants.sendGifts,
          style: TextStyles.largeLabelTextStyle(context),
        ),
      ),
      body: const Center(
        child: Text(
          'SendGiftsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
