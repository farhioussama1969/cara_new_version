import 'package:flutter_config/flutter_config.dart';
import 'package:get/get.dart';
import 'package:solvodev_mobile_structure/app/core/components/pop_ups/toast_component.dart';
import 'package:solvodev_mobile_structure/app/core/constants/get_builders_ids_constants.dart';
import 'package:solvodev_mobile_structure/app/core/constants/strings_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/services/moyasar_payment_service.dart';
import 'package:solvodev_mobile_structure/app/data/models/subscription_plan_model.dart';
import 'package:solvodev_mobile_structure/app/data/providers/cara_api/subscription_provider.dart';
import 'package:solvodev_mobile_structure/app/data/providers/cara_api/wallet_provider.dart';
import 'package:solvodev_mobile_structure/app/modules/home/controllers/home_controller.dart';
import 'package:solvodev_mobile_structure/app/modules/subscriptions/views/subscriptions_view.dart';

class SubscriptionsController extends GetxController {
  List<SubscriptionPlanModel> subscriptions = [];
  void changeSubscriptions(List<SubscriptionPlanModel> newWashingTypes) {
    subscriptions = newWashingTypes;
    update([GetBuildersIdsConstants.subscriptionsList]);
  }

  bool getSubscriptionsLoading = false;
  void changeGetSubscriptionsLoading(bool newGetWashingTypesLoading) {
    getSubscriptionsLoading = newGetWashingTypesLoading;
    update([GetBuildersIdsConstants.subscriptionsList]);
  }

  void getSubscriptions() {
    changeSubscriptions([]);
    SubscriptionProvider()
        .getSubscriptionsPlansList(
      branchId: Get.find<HomeController>()
          .checkServiceAvailabilityResponse
          ?.branch
          ?.id,
      onLoading: () => changeGetSubscriptionsLoading(true),
      onFinal: () => changeGetSubscriptionsLoading(false),
    )
        .then((value) {
      if (value != null) {
        changeSubscriptions(value);
      }
    });
  }

  //payment

  //payment

  int? selectedPaymentMethod;
  void changeSelectedPaymentMethod(int? newSelectedPaymentMethod) {
    selectedPaymentMethod = newSelectedPaymentMethod;
    update([GetBuildersIdsConstants.subscriptionsPaymentWindow]);
  }

  bool getWalletAmountLoading = false;
  void changeGetWalletAmountLoading(bool value) {
    getWalletAmountLoading = value;
    update([GetBuildersIdsConstants.subscriptionsPaymentWindow]);
  }

  double walletAmount = 0;
  void changeWallet(double? walletAmount) {
    this.walletAmount = walletAmount ?? 0;
    update([GetBuildersIdsConstants.subscriptionsPaymentWindow]);
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
    update([GetBuildersIdsConstants.subscriptionsPaymentWindow]);
  }

  void applePayment(SubscriptionPlanModel? gift) {
    MoyasarPaymentService.applePayPayment(
      coupon: null,
      orderDescription: '',
      price: gift?.price ?? 0,
      publishableKey: Get.find<HomeController>()
              .checkServiceAvailabilityResponse
              ?.branch
              ?.moyasarPublishableApiKey ??
          FlutterConfig.get('MOYASAR_PAYMENT_API_KEY'),
      merchantId: Get.find<HomeController>()
              .checkServiceAvailabilityResponse
              ?.branch
              ?.moyasarMerchantId ??
          FlutterConfig.get('MOYASAR_PAYMENT_MERCHANET_ID'),
      onLoading: () => changeApplePaymentLoading(true),
      onFinal: () => changeApplePaymentLoading(false),
      onError: () {},
    ).then((paymentRes) {
      if (paymentRes != null) {
        SubscriptionProvider()
            .subscription(
          branchId: Get.find<HomeController>()
              .checkServiceAvailabilityResponse
              ?.branch
              ?.id,
          subscriptionId: gift?.id,
          paymentMethod: "Apple pay",
          paymentId: paymentRes.id,
          onLoading: () => changeApplePaymentLoading(true),
          onFinal: () => changeApplePaymentLoading(false),
        )
            .then((value) {
          if (value != null) {
            const SubscriptionsView().showCreateGiftStatusWindow(true);
          } else {
            const SubscriptionsView().showCreateGiftStatusWindow(false);
          }
        });
      }
    });
  }

  bool walletPaymentLoading = false;
  void changeWalletPaymentLoading(bool value) {
    walletPaymentLoading = value;
    update([GetBuildersIdsConstants.subscriptionsPaymentWindow]);
  }

  void walletPayment(int? id) {
    print('wallet payment');
    SubscriptionProvider()
        .subscription(
      subscriptionId: id,
      paymentMethod: "Wallet",
      paymentId: null,
      branchId: Get.find<HomeController>()
          .checkServiceAvailabilityResponse
          ?.branch
          ?.id,
      onLoading: () => changeWalletPaymentLoading(true),
      onFinal: () => changeWalletPaymentLoading(false),
    )
        .then((value) {
      if (value != null) {
        const SubscriptionsView().showCreateGiftStatusWindow(true);
      } else {
        const SubscriptionsView().showCreateGiftStatusWindow(false);
      }
      changeSelectedPaymentMethod(null);
    });
  }

  //credit card payment

  bool creditCardPaymentLoading = false;
  void changeCreditCardPaymentLoading(bool value) {
    creditCardPaymentLoading = value;
    update([GetBuildersIdsConstants.subscriptionsCreditCardWindow]);
  }

  void creditCardPayment(String number, String expiredDate, String cvv,
      String? holderName, SubscriptionPlanModel? gift) {
    if (creditCardPaymentLoading) return;
    SubscriptionProvider()
        .subscription(
      paymentMethod: 'Credit card',
      onLoading: () => changeCreditCardPaymentLoading(true),
      onFinal: () => changeCreditCardPaymentLoading(false),
      subscriptionId: gift?.id,
      branchId: Get.find<HomeController>()
          .checkServiceAvailabilityResponse
          ?.branch
          ?.id,
    )
        .then((value) {
      if (value != null) {
        MoyasarPaymentService.creditCardPayment(
          cardHolderName: holderName ?? '',
          cardNumber: number,
          expiryDate: expiredDate,
          cvvCode: cvv,
          orderDescription: 'description',
          price: gift?.price ?? 0,
          publishableKey: Get.find<HomeController>()
                  .checkServiceAvailabilityResponse
                  ?.branch
                  ?.moyasarPublishableApiKey ??
              FlutterConfig.get('MOYASAR_PAYMENT_API_KEY'),
          callBackUrl:
              "http://demo.cara-wash.com/subscriptions/userSubscriptions/${value.id}/payment/callback",
          onLoading: () => changeCreditCardPaymentLoading(true),
          onFinal: () => changeCreditCardPaymentLoading(false),
          onError: () {
            ToastComponent.showErrorToast(Get.context!,
                text: StringsAssetsConstants.paymentError);
          },
        ).then((paymentRes) {
          if (paymentRes != null) {
            const SubscriptionsView().showCreditCardPaymentWebView(
                paymentRes.transactionUrl ?? '', value);
          }
        });
      } else {
        ToastComponent.showErrorToast(Get.context!,
            text: StringsAssetsConstants.createOrderError);
      }
    });
  }

  @override
  void onInit() {
    getSubscriptions();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
