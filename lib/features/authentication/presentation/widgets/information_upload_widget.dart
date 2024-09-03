import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:rideme_driver/core/extensions/context_extensions.dart';
import 'package:rideme_driver/core/size/sizes.dart';
import 'package:rideme_driver/core/spacing/whitspacing.dart';
import 'package:rideme_driver/core/theme/app_colors.dart';

class TakePhotoContainer extends StatelessWidget {
  final String label;
  final File? image;
  final String? networkImage;
  final void Function()? onTap;
  const TakePhotoContainer({
    super.key,
    required this.label,
    required this.onTap,
    required this.image,
    this.networkImage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: Sizes.height(context, 0.02)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //label
          //label
          Padding(
            padding: EdgeInsets.only(
              bottom: Sizes.height(context, 0.008),
            ),
            child: Text(
              label,
              style: context.textTheme.displaySmall?.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          GestureDetector(
            onTap: onTap,
            child: Container(
              height: Sizes.height(context, 0.13),
              width: Sizes.width(context, 0.4),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.rideMeBlack20),
                image: image != null
                    ? DecorationImage(
                        image: FileImage(image!),
                        fit: BoxFit.cover,
                      )
                    : networkImage != null
                        ? DecorationImage(
                            image: CachedNetworkImageProvider(
                              networkImage!,
                            ),
                            fit: BoxFit.cover)
                        : null,
                color: AppColors.rideMeBackgroundLight,
                borderRadius: BorderRadius.circular(
                  Sizes.height(context, 0.008),
                ),
              ),
              child: image == null && networkImage == null
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.camera_alt,
                            size: Sizes.height(context, 0.037),
                            color: AppColors.rideMeGreyDark,
                          ),
                          Space.height(context, 0.01),
                          Text(
                            context.appLocalizations.takePhoto,
                            style: context.textTheme.headlineSmall!.copyWith(
                              fontSize: 15,
                              color: AppColors.rideMeGreyDark,
                            ),
                          ),
                        ],
                      ),
                    )
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
