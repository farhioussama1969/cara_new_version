import 'package:flutter_config/flutter_config.dart';
import 'package:moyasar/moyasar.dart';

class MoyasarPaymentService {
  static creditCardPayment({
    required String cardNumber,
    required String cardHolderName,
    required String cardExpiryMonth,
    required String cardExpiryYear,
    required String cardCvc,
  }) async {
    final paymentConfig = PaymentConfig(
      publishableApiKey: FlutterConfig.get('MOYASAR_PAYMENT_API_KEY'),
      amount: 25758, // SAR 257.58
      description: 'order #1324',
      metadata: {'size': '250g'},
      creditCard: CreditCardConfig(saveCard: true, manual: false),
      applePay: ApplePayConfig(
          merchantId: 'YOUR_MERCHANT_ID',
          label: 'YOUR_STORE_NAME',
          manual: false),
    );

    final source = CardPaymentRequestSource(
        creditCardData: CardFormModel(
          name: cardHolderName,
          number: cardNumber,
          month: cardExpiryMonth,
          year: cardExpiryYear,
        ),
        tokenizeCard: (paymentConfig.creditCard as CreditCardConfig).saveCard,
        manualPayment: (paymentConfig.creditCard as CreditCardConfig).manual);

    final paymentRequest = PaymentRequest(paymentConfig, source);

    final result = await Moyasar.pay(
        apiKey: paymentConfig.publishableApiKey,
        paymentRequest: paymentRequest);
  }
}
