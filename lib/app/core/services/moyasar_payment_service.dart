import 'package:flutter_config/flutter_config.dart';
import 'package:moyasar/moyasar.dart';
import 'package:rive/math.dart';

class MoyasarPaymentService {
  static creditCardPayment({
    required String cardNumber,
    required String cardHolderName,
    required String cardExpiryMonth,
    required String cardExpiryYear,
    required String cardCvc,
    required double amount,
  }) async {
    final paymentConfig = PaymentConfig(
      publishableApiKey: FlutterConfig.get('MOYASAR_PAYMENT_API_KEY'),
      amount: (amount * 100).toInt(), // SAR 257.58
      description: 'order #1324',
      metadata: {'size': '250g'},
      creditCard: CreditCardConfig(saveCard: true, manual: false),
      currency: 'SAR',
    );

    final source = CardPaymentRequestSource(
      creditCardData: CardFormModel(
        name: cardHolderName,
        number: cardNumber,
        month: cardExpiryMonth,
        year: cardExpiryYear,
        cvc: cardCvc,
      ),
      tokenizeCard: (paymentConfig.creditCard as CreditCardConfig).saveCard,
      manualPayment: (paymentConfig.creditCard as CreditCardConfig).manual,
    );

    final paymentRequest = PaymentRequest(paymentConfig, source);

    final result = await Moyasar.pay(
        apiKey: paymentConfig.publishableApiKey,
        paymentRequest: paymentRequest);

    print('Payment result::: ${result}');

    if (result is PaymentResponse) {
      switch (result.status) {
        case PaymentStatus.initiated:
          print('Payment initiated::: ${result.callbackUrl}');
          break;
        case PaymentStatus.paid:
          // handle success.
          break;
        case PaymentStatus.failed:
          // handle failure.
          break;
        case PaymentStatus.authorized:
        // TODO: Handle this case.
        case PaymentStatus.captured:
        // TODO: Handle this case.
      }
    }
  }
}
