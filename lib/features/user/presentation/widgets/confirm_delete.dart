import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rideme_driver/core/extensions/context_extensions.dart';
import 'package:rideme_driver/core/size/sizes.dart';
import 'package:rideme_driver/core/spacing/whitspacing.dart';
import 'package:rideme_driver/core/widgets/buttons/generic_button_widget.dart';

class ConfirmDeleteDialog extends StatefulWidget {
  final VoidCallback confirmDeleteOnTap;

  const ConfirmDeleteDialog({
    super.key,
    required this.confirmDeleteOnTap,
  });

  @override
  State<ConfirmDeleteDialog> createState() => _ConfirmDeleteDialogState();
}

class _ConfirmDeleteDialogState extends State<ConfirmDeleteDialog> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(Sizes.height(context, 0.02)),
        width: Sizes.height(context, 0.343),
        decoration: BoxDecoration(
          color: context.theme.scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () => context.pop(),
                child: const Icon(
                  Icons.close,
                ),
              ),
            ),
            Text(
              context.appLocalizations.confirmDelete,
              textAlign: TextAlign.center,
              style: context.textTheme.displayLarge?.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            Space.height(context, 0.016),
            Text(
              context.appLocalizations.confirmDeleteDesc,
              style: context.textTheme.displaySmall?.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
            Space.height(context, 0.024),
            GenericButton(
              onTap: () => context.pop(),
              label: context.appLocalizations.cancel,
              isActive: true,
            ),
            Space.height(context, 0.02),
            GestureDetector(
              onTap: widget.confirmDeleteOnTap,
              child: Text(
                context.appLocalizations.confirmDeleteConfirmation,
                style: context.textTheme.displayMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
