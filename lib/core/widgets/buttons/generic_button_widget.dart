import 'package:flutter/material.dart';
import 'package:rideme_driver/core/extensions/context_extensions.dart';
import 'package:rideme_driver/core/size/sizes.dart';
import 'package:rideme_driver/core/theme/app_colors.dart';

/// ### GenericButton Widget
///
/// The `GenericButton` widget is a customizable button.
/// It provides flexibility in customization options such as button label, onTap callback, and button activation state.
///
/// #### Notes:
/// - It adjusts the button's color and onTap callback based on the `isActive` property.
/// - The `GenericButton` widget encapsulates a `GestureDetector` and a `Container` for button styling.
/// - The button's appearance and behavior can be controlled dynamically by changing the `isActive` property.
///
/// #### Example Usage:
/// ```dart
/// GenericButton(
///  label: 'Submit',
///  isActive: true,
///  onTap: () {
///    // Handle button press
///  },
///)
/// ```
class GenericButton extends StatelessWidget {
  /// A String representing the text displayed on the button.
  final String label;

  /// A boolean indicating whether the button is active or disabled.
  final bool isActive;

  /// An optional color for the button.
  final Color? buttonColor;

  /// An optional color for the button text.
  final Color? textColor;

  final double? borderRadius;

  /// An optional callback function that is called when the button is tapped.
  final void Function()? onTap;

  /// ### Constructor for `GenericButton` Widget
  ///
  /// #### Parameters:
  /// - `label` (required): A String representing the text displayed on the button.
  /// - `onTap`: An optional callback function that is called when the button is tapped.
  /// - `buttonColor`: An optional color for the button.
  /// - `textColor`: An optional color for the button text.
  /// - `isActive` (required): A boolean indicating whether the button is active or disabled.

  const GenericButton({
    super.key,
    this.textColor,
    this.buttonColor,
    this.borderRadius,
    required this.onTap,
    required this.label,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // button functionality
      onTap: isActive ? onTap : null,
      child: Container(
        constraints: BoxConstraints(
            maxWidth: 700, minHeight: Sizes.height(context, 0.053)),
        width: double.infinity,
        decoration: BoxDecoration(
          color: isActive
              ? buttonColor ?? AppColors.rideMeBlueNormal
              : AppColors.rideMeBlackLightHover,
          borderRadius: BorderRadius.circular(
            Sizes.height(context, borderRadius ?? 0.006),
          ),
        ),
        child: Center(
          child: Text(
            //string of text for  button
            label,
            style: context.textTheme.displayMedium?.copyWith(
              color: textColor ?? AppColors.rideMeWhite400,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
