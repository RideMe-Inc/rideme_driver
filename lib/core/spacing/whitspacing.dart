import 'package:flutter/material.dart';
import 'package:rideme_driver/core/size/sizes.dart';

class Space {
  Space._();

  //custom spacing height
  static height(BuildContext context, double size) {
    return SizedBox(
      height: Sizes.height(context, size),
    );
  }

  //custom spacing width

  static width(BuildContext context, double size) {
    return SizedBox(
      width: Sizes.width(context, size),
    );
  }
}
