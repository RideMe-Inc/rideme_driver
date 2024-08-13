import 'package:flutter/material.dart';
import 'package:rideme_driver/core/extensions/context_extensions.dart';
import 'package:rideme_driver/core/theme/app_colors.dart';

class UserInitials extends StatelessWidget {
  final String name;
  final double? fontSize;
  const UserInitials({
    super.key,
    this.fontSize,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    final initials = name.split(' ').map((e) => e[0]).join();

    return Text(
      initials,
      style: context.textTheme.displayLarge?.copyWith(
        fontSize: fontSize,
        fontWeight: FontWeight.w500,
        color: AppColors.rideMeBackgroundLight,
      ),
    );
  }
}
