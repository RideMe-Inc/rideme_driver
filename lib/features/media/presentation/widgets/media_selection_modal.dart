import 'package:flutter/material.dart';
import 'package:rideme_driver/core/size/sizes.dart';
import 'package:rideme_driver/core/theme/app_colors.dart';

buildMediaSelectionModal({
  required BuildContext context,
  required void Function()? cameraOnTap,
  required void Function()? galleryOnTap,
}) {
  final theme = Theme.of(context);
  return showModalBottomSheet(
    backgroundColor: theme.scaffoldBackgroundColor,
    context: context,
    builder: (context) => Container(
      padding: EdgeInsets.only(top: Sizes.height(context, 0.02)),
      height: Sizes.height(context, 0.2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //gallery
          ListTile(
            onTap: galleryOnTap,
            title: Text(
              'Gallery',
              style: theme.textTheme.displaySmall,
            ),
            leading: Icon(
              Icons.photo,
              color: theme.brightness == Brightness.light
                  ? AppColors.rideMeBlackNormal
                  : AppColors.rideMeGreyNormal,
            ),
          ),

          //camera
          ListTile(
            onTap: cameraOnTap,
            title: Text(
              'Camera',
              style: theme.textTheme.displaySmall,
            ),
            leading: Icon(
              Icons.camera,
              color: theme.brightness == Brightness.light
                  ? AppColors.rideMeBlackNormal
                  : AppColors.rideMeGreyNormal,
            ),
          ),
        ],
      ),
    ),
  );
}
