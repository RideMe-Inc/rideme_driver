import 'package:flutter/material.dart';
import 'package:rideme_driver/core/extensions/context_extensions.dart';
import 'package:rideme_driver/core/size/sizes.dart';
import 'package:rideme_driver/core/spacing/whitspacing.dart';
import 'package:rideme_driver/core/theme/app_colors.dart';
import 'package:rideme_driver/core/widgets/buttons/generic_button_widget.dart';
import 'package:rideme_driver/core/widgets/textfield/generic_textfield_widget.dart';

class MoreInfoAdditionPage extends StatefulWidget {
  final String token, email;
  const MoreInfoAdditionPage({
    super.key,
    required this.token,
    required this.email,
  });

  @override
  State<MoreInfoAdditionPage> createState() => _MoreInfoAdditionPageState();
}

class _MoreInfoAdditionPageState extends State<MoreInfoAdditionPage> {
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: Sizes.height(context, 0.02)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.appLocalizations.enterFullName,
                style: context.textTheme.displayLarge?.copyWith(
                  color: AppColors.rideMeBlackNormalActive,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Space.height(context, 0.012),
              Text(
                context.appLocalizations.enterFullNameInfo,
                style: context.textTheme.displaySmall,
              ),
              Space.height(context, 0.031),
              GenericTextField(
                keyboardType: TextInputType.text,
                label: context.appLocalizations.firstName,
                hint: context.appLocalizations.enterYourFirstName,
                controller: firstName,
                onChanged: (p0) => setState(() {}),
              ),
              Space.height(context, 0.016),
              GenericTextField(
                keyboardType: TextInputType.text,
                label: context.appLocalizations.lastName,
                hint: context.appLocalizations.enterYourLastName,
                controller: lastName,
                onChanged: (p0) => setState(() {}),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        padding: EdgeInsets.symmetric(
            horizontal: Sizes.height(context, 0.02),
            vertical: Sizes.height(context, 0.02)),
        color: context.theme.scaffoldBackgroundColor,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GenericButton(
              onTap: () {},
              label: context.appLocalizations.continues,
              isActive: firstName.text.length > 1 && lastName.text.length > 1,
            ),
          ],
        ),
      ),
    );
  }
}
