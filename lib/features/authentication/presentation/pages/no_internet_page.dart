import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rideme_driver/core/extensions/context_extensions.dart';
import 'package:rideme_driver/core/size/sizes.dart';
import 'package:rideme_driver/core/spacing/whitspacing.dart';
import 'package:rideme_driver/core/widgets/buttons/generic_button_widget.dart';

class NoInternetPage extends StatelessWidget {
  const NoInternetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(Sizes.height(context, 0.02)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              context.appLocalizations.noInternetConnection,
              style: context.textTheme.headlineSmall,
            ),
            Space.height(context, 0.01),
            Text(
              context.appLocalizations.noInternetConnectionDesc,
              style: context.textTheme.displayMedium,
            ),
            Space.height(context, 0.05),
            GenericButton(
              onTap: () => context.goNamed('root'),
              label: context.appLocalizations.retry,
              isActive: true,
            )
          ],
        ),
      ),
    );
  }
}
