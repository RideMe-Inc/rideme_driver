import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:rideme_driver/core/extensions/context_extensions.dart';
import 'package:rideme_driver/core/size/sizes.dart';
import 'package:rideme_driver/core/spacing/whitspacing.dart';
import 'package:rideme_driver/core/theme/app_colors.dart';
import 'package:rideme_driver/core/widgets/buttons/generic_button_widget.dart';
import 'package:rideme_driver/core/widgets/textfield/date_form_field.dart';

import 'package:rideme_driver/core/widgets/textfield/text_form_field.dart';

class EnterPersonalDetailsPage extends StatefulWidget {
  const EnterPersonalDetailsPage({super.key});

  @override
  State<EnterPersonalDetailsPage> createState() =>
      _EnterPersonalDetailsPageState();
}

class _EnterPersonalDetailsPageState extends State<EnterPersonalDetailsPage> {
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController ssn = TextEditingController();
  String? dateOfBirth;
  final formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(Sizes.height(context, 0.02)),
          child: FormBuilder(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.appLocalizations.enterPersonalDetails,
                  style: context.textTheme.displayLarge?.copyWith(
                    color: AppColors.rideMeBlackNormalActive,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Space.height(context, 0.012),
                Text(
                  context.appLocalizations.enterPersonalDetailsInfo,
                  style: context.textTheme.displaySmall,
                ),
                Space.height(context, 0.031),
                TextFormBuilderField(
                  name: 'first_name',
                  validator: (p0) {
                    if ((p0?.length ?? 0) < 2) {
                      return context.appLocalizations.mustBeAtLeast(2);
                    }
                    return null;
                  },
                  keyboardType: TextInputType.name,
                  label: context.appLocalizations.firstName,
                  hint: context.appLocalizations.firstNameHint,
                  controller: firstName,
                  onChanged: (p0) => setState(() {}),
                ),
                TextFormBuilderField(
                  name: 'last_name',
                  validator: (p0) {
                    if ((p0?.length ?? 0) < 2) {
                      return context.appLocalizations.mustBeAtLeast(2);
                    }
                    return null;
                  },
                  keyboardType: TextInputType.name,
                  label: context.appLocalizations.lastName,
                  hint: context.appLocalizations.lastNameHInt,
                  controller: lastName,
                  onChanged: (p0) => setState(() {}),
                ),
                DateFormBuilderField(
                  fieldName: 'dob',
                  label: context.appLocalizations.dob,
                  validator: (p0) {
                    if (p0 == null) {
                      return context.appLocalizations.fieldIsRequired;
                    }
                    return null;
                  },
                  onChanged: (p0) {
                    if (p0 != null) {
                      setState(
                        () {
                          dob.text = p0.toIso8601String();
                          dateOfBirth = p0.toIso8601String();
                        },
                      );
                    }
                  },
                  controller: dob,
                ),
                TextFormBuilderField(
                  name: 'address',
                  validator: (p0) {
                    if ((p0?.length ?? 0) < 2) {
                      return 'required field';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.name,
                  label: context.appLocalizations.addressLocation,
                  hint: 'Enter address',
                  controller: address,
                  onChanged: (p0) => setState(() {}),
                ),
                TextFormBuilderField(
                  name: 'ssn',
                  validator: (p0) {
                    if ((p0?.length ?? 0) < 2) {
                      return 'required field';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.name,
                  label: context.appLocalizations.socialSecurityNumber,
                  hint: 'Enter social security number',
                  controller: ssn,
                  onChanged: (p0) => setState(() {}),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: Container(
        padding: EdgeInsets.all(Sizes.height(context, 0.02)),
        color: AppColors.rideMeBackgroundLight,
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GenericButton(
              onTap: () {},
              label: context.appLocalizations.continues,
              isActive: true,
            ),
          ],
        ),
      ),
    );
  }
}
