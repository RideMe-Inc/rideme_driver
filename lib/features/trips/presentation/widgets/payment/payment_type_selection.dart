import 'package:flutter/material.dart';
import 'package:rideme_driver/assets/images/image_name_constants.dart';
import 'package:rideme_driver/core/extensions/context_extensions.dart';
import 'package:rideme_driver/core/size/sizes.dart';
import 'package:rideme_driver/core/spacing/whitspacing.dart';
import 'package:rideme_driver/core/theme/app_colors.dart';

class PaymentTypeSelectionWidget extends StatelessWidget {
  final VoidCallback onTap;
  final PaymentTypes? paymentType;
  const PaymentTypeSelectionWidget({
    super.key,
    required this.onTap,
    required this.paymentType,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: AppColors.rideMeBackgroundLight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            paymentType != null
                ? Row(
                    children: [
                      Image.asset(
                        paymentType!.imagePath,
                        height: Sizes.height(context, 0.028),
                      ),
                      Space.width(context, 0.032),
                      Text(
                        paymentType!.type,
                        style: context.textTheme.displayMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  )
                : Text(
                    context.appLocalizations.choosePaymentMethod,
                    style: context.textTheme.displayMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
            Icon(
              Icons.arrow_forward_ios,
              color: AppColors.rideMeBlackNormal,
              size: Sizes.height(context, 0.021),
            )
          ],
        ),
      ),
    );
  }
}

enum PaymentTypes {
  cash(imagePath: ImageNameConstants.cashIMG, type: 'Cash'),
  card(imagePath: ImageNameConstants.cardIMG, type: 'Credit Card');

  final String imagePath, type;
  const PaymentTypes({required this.imagePath, required this.type});
}
