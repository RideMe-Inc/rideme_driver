import 'package:rideme_driver/features/trips/domain/entities/payment_info.dart';

class PaymentInfoModel extends PaymentInfo {
  const PaymentInfoModel(
      {required super.paymentToken, required super.checkoutUrl});

//fromJson
  factory PaymentInfoModel.fromJson(Map<String, dynamic> json) =>
      PaymentInfoModel(
        paymentToken: json['payment_token'],
        checkoutUrl: json['checkout_url'],
      );
}
