import 'package:moyasar_payment/model/paymodel.dart';
import 'package:moyasar_payment/model/source/applepaymodel.dart';
import 'package:moyasar_payment/model/source/creditcardmodel.dart';
import 'package:moyasar_payment/moyasar_payment.dart';

import '../../data/models/coupon_model.dart';

class MoyasarPaymentService {
  static Future<CreditcardModel?> creditCardPayment({
    required String cardHolderName,
    required String cardNumber,
    required String expiryDate,
    required String cvvCode,
    required String orderDescription,
    required CouponModel? coupon,
    required double price,
    required String publishableKey,
    required String callBackUrl,
    required Function onLoading,
    required Function onFinal,
    required Function onError,
  }) async {
    try {
      onLoading();
      PayModel res = await MoyasarPayment().creditCard(
        description: "Order #$orderDescription",
        amount: coupon?.actualTotal ?? price,
        publishableKey: publishableKey,
        cardHolderName: cardHolderName == '' ? "without name" : cardHolderName,
        cardNumber: cardNumber.replaceAll(' ', ''),
        cvv: cvvCode,
        expiryMonth: expiryDate.substring(0, 2),
        expiryYear: expiryDate.substring(3, 5),
        callbackUrl: callBackUrl,
      );
      print('payemnt res: ${res.toJson()}');
      onFinal();
      if (res.message !=
          'M074: Credit card is not originated from allowed country banks.') {
        CreditcardModel creditCardModel = CreditcardModel.fromJson(res.source);
        if (creditCardModel.transactionUrl != null) {
          return creditCardModel;
        } else {
          onError();
        }
      } else {
        onError();
      }
    } catch (e) {
      onFinal();
      onError();
    }
    return null;
  }

  static Future<PayModel?> applePayPayment({
    required CouponModel? coupon,
    required String orderDescription,
    required double price,
    required String publishableKey,
    required String merchantId,
    required Function onLoading,
    required Function onFinal,
    required Function onError,
  }) async {
    try {
      onLoading();
      var items = <String, double>{
        orderDescription: price,
        'كارا': coupon?.actualTotal ?? price,
      };
      PayModel res = await MoyasarPayment().applePay(
          amount: coupon?.actualTotal ?? price,
          publishableKey: publishableKey,
          applepayMerchantId: merchantId,
          paymentItems: items,
          currencyCode: 'SAR',
          countryCode: 'SA',
          description: orderDescription);

      if (res.id == null) {
        onError();
        onFinal();
      } else {
        onFinal();
        //ApplePayModel applePayModel = ApplePayModel.fromJson(res.source);
        return res;
      }
    } catch (e) {
      onFinal();
      onError();
    }
    return null;
  }
}
