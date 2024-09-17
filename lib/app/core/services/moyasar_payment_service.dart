import 'package:moyasar_payment/model/paymodel.dart';
import 'package:moyasar_payment/moyasar_payment.dart';
import 'package:solvodev_mobile_structure/app/data/models/coupon_model.dart';

class MoyasarPaymentService {
  Future<void> creditCardPayment({
    required String cardHolderName,
    required String cardNumber,
    required String expiryDate,
    required String cvvCode,
    required String orderDescription,
    required CouponModel? coupon,
    required double price,
    required String publishableKey,
    required String callBackUrl,
  }) async {
    PayModel res = await MoyasarPayment().creditCard(
      description: "Order #$orderDescription",
      amount: coupon?.actualTotal ?? price,
      publishableKey: publishableKey,
      cardHolderName: cardHolderName == '' ? "without name" : cardHolderName,
      cardNumber: "${cardNumber.replaceAll(' ', '')}",
      cvv: "${cvvCode}",
      expiryMonth: expiryDate.substring(0, 2),
      expiryYear: expiryDate.substring(3, 5),
      callbackUrl: callBackUrl,
    );
  }
}
