import 'package:flutter/material.dart';
import 'package:rideme_driver/core/extensions/context_extensions.dart';
import 'package:rideme_driver/core/size/sizes.dart';
import 'package:rideme_driver/core/spacing/whitspacing.dart';
import 'package:rideme_driver/core/theme/app_colors.dart';
import 'package:rideme_driver/features/trips/presentation/widgets/payment/payment_type_selection.dart';

class PaymentMethodSectionWidget extends StatelessWidget {
  final PaymentTypes paymentTypes;

  final num amount;
  const PaymentMethodSectionWidget({
    super.key,
    required this.paymentTypes,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //header
        Text(
          context.appLocalizations.paymentMethod,
          style: context.textTheme.displaySmall?.copyWith(
            fontWeight: FontWeight.w500,
            color: AppColors.rideMeGreyDarkActive,
          ),
        ),

        Space.height(context, 0.02),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //indicator
            Row(
              children: [
                Image.asset(
                  paymentTypes.imagePath,
                  height: Sizes.height(context, 0.028),
                ),
                Space.width(context, 0.032),
                Text(
                  paymentTypes.type,
                  style: context.textTheme.displayMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),

            //amount

            Text(
              context.appLocalizations.amountAndCurrency(amount.toString()),
              style: context.textTheme.displayMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),

        Space.height(context, 0.014),

        const Divider(
          color: AppColors.rideMeGreyLightActive,
        ),
      ],
    );
  }
}
