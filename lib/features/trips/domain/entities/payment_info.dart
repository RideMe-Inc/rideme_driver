import 'package:equatable/equatable.dart';

class PaymentInfo extends Equatable {
  final String? paymentToken, checkoutUrl;

  const PaymentInfo({required this.paymentToken, required this.checkoutUrl});

  @override
  List<Object?> get props => [paymentToken, checkoutUrl];

  Map<String, dynamic> toMap() => {
        'payment_token': paymentToken,
        'checkout_url': checkoutUrl,
      };
}
