import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:solvodev_mobile_structure/app/core/constants/fonts_family_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/constants/get_builders_ids_constants.dart';
import 'package:solvodev_mobile_structure/app/core/styles/main_colors.dart';
import 'package:solvodev_mobile_structure/app/core/styles/text_styles.dart';
import 'package:solvodev_mobile_structure/app/data/models/gift_coupon_model.dart';
import 'package:solvodev_mobile_structure/app/data/models/pagination_model.dart';
import 'package:solvodev_mobile_structure/app/data/providers/cara_api/gift_provider.dart';
import 'package:solvodev_mobile_structure/app/data/providers/cara_api/wallet_provider.dart';
import 'package:solvodev_mobile_structure/app/modules/home/controllers/home_controller.dart';
import 'package:solvodev_mobile_structure/app/modules/send_gifts/views/send_gifts_view.dart';

import '../../../data/models/gift_model.dart';

class SendGiftsController extends GetxController {
  int giftsCurrentTabIndex = 1;
  void changeGiftsCurrentPage(int newGiftsCurrentPage) {
    giftsCurrentTabIndex = newGiftsCurrentPage;
    update([
      GetBuildersIdsConstants.sendGiftsTopBar,
      GetBuildersIdsConstants.sendGiftsList
    ]);
  }

  final ScrollController giftsListScrollController = ScrollController();

  bool getGiftsListLoading = false;
  void changeGetGiftsListLoading(bool newGetMyCarsListLoading) {
    getGiftsListLoading = newGetMyCarsListLoading;
    update([GetBuildersIdsConstants.sendGiftsList]);
  }

  PaginationModel<GiftModel>? giftsList;
  void changeGiftsList(PaginationModel<GiftModel>? newData, {bool? refresh}) {
    if (refresh == true) {
      giftsList = null;
    } else {
      if (giftsList?.data?.isNotEmpty == true) {
        giftsList?.data?.addAll(newData?.data ?? []);
        giftsList?.meta = newData?.meta;
      } else {
        giftsList = newData;
      }
    }
    update([GetBuildersIdsConstants.sendGiftsList]);
  }

  int giftsCurrentPage = 1;
  void getGifts() {
    GiftProvider()
        .getGiftsList(
      page: giftsCurrentPage,
      branchId: Get.find<HomeController>()
          .checkServiceAvailabilityResponse
          ?.branch
          ?.id,
      onLoading: () => changeGetGiftsListLoading(true),
      onFinal: () => changeGetGiftsListLoading(false),
    )
        .then(
      (value) {
        if (value != null) {
          changeGiftsList(value);
        }
      },
    );
  }

  void giftsScrollEvent() {
    giftsListScrollController.addListener(() {
      double maxScroll = giftsListScrollController.position.maxScrollExtent;
      if (giftsListScrollController.offset > maxScroll * 0.8) {
        if (!getGiftsListLoading) {
          if (giftsCurrentPage < (giftsList?.meta?.lastPage ?? 0)) {
            giftsCurrentPage++;
            getGifts();
          }
        }
      }
    });
  }

  void refreshGifts() {
    giftsCurrentPage = 1;
    changeGiftsList(null, refresh: true);
    getGifts();
  }

  final ScrollController oldGiftsListScrollController = ScrollController();

  bool getOldGiftsListLoading = false;
  void changeGetOldGiftsListLoading(bool newGetMyCarsListLoading) {
    getOldGiftsListLoading = newGetMyCarsListLoading;
    update([GetBuildersIdsConstants.sendGiftsList]);
  }

  PaginationModel<GiftCouponModel>? oldGiftsList;
  void changeOldGiftsList(PaginationModel<GiftCouponModel>? newData,
      {bool? refresh}) {
    if (refresh == true) {
      oldGiftsList = null;
    } else {
      if (oldGiftsList?.data?.isNotEmpty == true) {
        oldGiftsList?.data?.addAll(newData?.data ?? []);
        oldGiftsList?.meta = newData?.meta;
      } else {
        oldGiftsList = newData;
      }
    }
    update([GetBuildersIdsConstants.sendGiftsList]);
  }

  int oldGiftsCurrentPage = 1;
  void getOldGifts() {
    GiftProvider()
        .getGiftCouponsList(
      page: oldGiftsCurrentPage,
      branchId: Get.find<HomeController>()
          .checkServiceAvailabilityResponse
          ?.branch
          ?.id,
      onLoading: () => changeGetOldGiftsListLoading(true),
      onFinal: () => changeGetOldGiftsListLoading(false),
    )
        .then(
      (value) {
        if (value != null) {
          changeOldGiftsList(value);
        }
      },
    );
  }

  void oldGiftsScrollEvent() {
    oldGiftsListScrollController.addListener(() {
      double maxScroll = oldGiftsListScrollController.position.maxScrollExtent;
      if (oldGiftsListScrollController.offset > maxScroll * 0.8) {
        if (!getOldGiftsListLoading) {
          if (oldGiftsCurrentPage < (oldGiftsList?.meta?.lastPage ?? 0)) {
            oldGiftsCurrentPage++;
            getOldGifts();
          }
        }
      }
    });
  }

  void refreshOldGifts() {
    oldGiftsCurrentPage = 1;
    changeOldGiftsList(null, refresh: true);
    getOldGifts();
  }

  //payment

  int? selectedPaymentMethod;
  void changeSelectedPaymentMethod(int? newSelectedPaymentMethod) {
    selectedPaymentMethod = newSelectedPaymentMethod;
    update([GetBuildersIdsConstants.sendGiftPaymentWindow]);
  }

  bool getWalletAmountLoading = false;
  void changeGetWalletAmountLoading(bool value) {
    getWalletAmountLoading = value;
    update([GetBuildersIdsConstants.sendGiftPaymentWindow]);
  }

  double walletAmount = 0;
  void changeWallet(double? walletAmount) {
    this.walletAmount = walletAmount ?? 0;
    update([GetBuildersIdsConstants.sendGiftPaymentWindow]);
  }

  void getWalletAmount() {
    WalletProvider()
        .getWalletAmount(
      onLoading: () => changeGetWalletAmountLoading(true),
      onFinal: () => changeGetWalletAmountLoading(false),
    )
        .then((value) {
      if (value != null) {
        changeWallet(value);
      }
    });
  }

  bool applePaymentLoading = false;
  void changeApplePaymentLoading(bool value) {
    applePaymentLoading = value;
    update([GetBuildersIdsConstants.sendGiftPaymentWindow]);
  }

  bool walletPaymentLoading = false;
  void changeWalletPaymentLoading(bool value) {
    walletPaymentLoading = value;
    update([GetBuildersIdsConstants.sendGiftPaymentWindow]);
  }

  void walletPayment(int? giftId) {
    print('wallet payment');
    GiftProvider()
        .buyGift(
      giftId: giftId,
      paymentMethod: "Wallet",
      title: '/',
      onLoading: () => changeWalletPaymentLoading(true),
      onFinal: () => changeWalletPaymentLoading(false),
    )
        .then((value) {
      if (value != null) {
        refreshOldGifts();
        const SendGiftsView().showCreateGiftStatusWindow(true, value);
      } else {
        const SendGiftsView().showCreateGiftStatusWindow(false, null);
      }
      changeSelectedPaymentMethod(null);
    });
  }

  @override
  void onInit() {
    getGifts();
    getOldGifts();
    super.onInit();
  }

  @override
  void onReady() {
    giftsScrollEvent();
    oldGiftsScrollEvent();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  //render gift card image
  final TextEditingController noteController = TextEditingController();

  String? finalImagePath = '';
  void shareTextInvitationCode(
    String? extraTextMessage,
    String? imageText,
    String? numberOfWashing,
    String? coupon,
    String? backgroundImageAssetPath,
  ) async {
    await _renderTextOnImage(
        text: imageText,
        text2: numberOfWashing,
        text3: coupon,
        backgroundImageAssetPath: backgroundImageAssetPath);
    await Share.shareXFiles([XFile(finalImagePath!)]);
  }

  Future<void> _renderTextOnImage(
      {String? text,
      String? text2,
      String? text3,
      String? backgroundImageAssetPath}) async {
    Image image = Image.asset(
      backgroundImageAssetPath ?? "",
      fit: BoxFit.cover,
    );
    // Render text on the image
    late ui.Image renderedImage;

    // Convert Image widget to ImageStream
    ImageStream imageStream = image.image.resolve(ImageConfiguration.empty);

    // Create a Completer to wait for image loading
    Completer<void> completer = Completer<void>();

    // Add a listener to the ImageStreamCompleter
    imageStream.addListener(
      ImageStreamListener((info, synchronousCall) async {
        renderedImage = info.image;
        completer.complete(); // Complete the Completer when image is loaded
      }),
    );

    await completer.future; // Wait for the image to load

    // Create a new canvas to draw text on the image
    ui.PictureRecorder recorder = ui.PictureRecorder();
    Canvas canvas = Canvas(recorder);
    canvas.drawImage(renderedImage, Offset(0, 0), Paint());

    // Create a TextSpan to hold the text style and content
    TextSpan textSpan = TextSpan(
      text: text ?? '',
      style: TextStyles.largeBodyTextStyle(Get.context!).copyWith(
        fontSize: 25,
        color: MainColors.whiteColor,
      ),
    );

    TextSpan textSpan2 = TextSpan(
      text: ' $text2 ' ?? '',
      style: TextStyles.largeBodyTextStyle(Get.context!).copyWith(
        fontSize: 40,
        color: MainColors.whiteColor,
        fontFamily: FontsFamilyAssetsConstants.bold,
      ),
    );

    TextSpan textSpan3 = TextSpan(
      text: text3 ?? '',
      style: TextStyles.largeBodyTextStyle(Get.context!).copyWith(
        fontSize: 16,
        color: MainColors.whiteColor,
        fontFamily: FontsFamilyAssetsConstants.bold,
      ),
    );

    // Use a TextPainter to layout the text on the canvas
    TextPainter textPainter = TextPainter(
      textAlign: TextAlign.right,
      text: textSpan,
      //check the language for the text direction

      textDirection: (Get.locale!.languageCode == 'ar')
          ? TextDirection.rtl
          : TextDirection.ltr,
    );

    TextPainter textPainter2 = TextPainter(
      textAlign: TextAlign.right,
      text: textSpan2,
      //check the language for the text direction

      textDirection: (Get.locale!.languageCode == 'ar')
          ? TextDirection.rtl
          : TextDirection.ltr,
    );

    TextPainter textPainter3 = TextPainter(
      textAlign: TextAlign.right,
      text: textSpan3,
      //check the language for the text direction

      textDirection: (Get.locale!.languageCode == 'ar')
          ? TextDirection.rtl
          : TextDirection.ltr,
    );
    textPainter.layout(maxWidth: renderedImage.width.toDouble() * 0.8);
    textPainter2.layout(maxWidth: renderedImage.width.toDouble() * 0.4);
    textPainter3.layout(maxWidth: renderedImage.width.toDouble() * 0.4);

    // Specify the position to draw the text on the canvas
    Offset textOffset = Offset(renderedImage.width.toDouble() * 0.05,
        renderedImage.height.toDouble() * 0.28);
    Offset textOffset2 = Offset(renderedImage.width.toDouble() * 0.26,
        renderedImage.height.toDouble() * 0.415);
    Offset textOffset3 = Offset(renderedImage.width.toDouble() * 0.22,
        renderedImage.height.toDouble() * 0.505);
    textPainter.paint(canvas, textOffset);
    textPainter2.paint(canvas, textOffset2);
    textPainter3.paint(canvas, textOffset3);

    // Convert the canvas to an Image
    ui.Image resultImage = await recorder
        .endRecording()
        .toImage(renderedImage.width, renderedImage.height);

    // Save the resulting image to file
    ByteData? byteData =
        await resultImage.toByteData(format: ui.ImageByteFormat.png);
    List<int> encodedImage = byteData?.buffer.asUint8List() as List<int>;

    final tempDir = await getTemporaryDirectory();
    String imagePath = '${tempDir.path}/result_image.png';
    File resultImageFile = File(imagePath);
    await resultImageFile.writeAsBytes(encodedImage);
    finalImagePath = imagePath;
  }

  openGiftFile(
    String? extraTextMessage,
    String? imageText,
    String? numberOfWashing,
    String? coupon,
    String? backgroundImageAssetPath,
  ) async {
    await _renderTextOnImage(
        text: imageText,
        text2: numberOfWashing,
        text3: coupon,
        backgroundImageAssetPath: backgroundImageAssetPath);
    OpenFile.open(finalImagePath);
  }
}
