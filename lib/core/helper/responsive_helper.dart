import 'package:flutter/material.dart';

class ResponsiveHelper {
  static double width(BuildContext context) => MediaQuery.sizeOf(context).width;

  static bool isSmallMobile(BuildContext context) => width(context) < 360;

  static double horizontalPadding(BuildContext context) =>
      isSmallMobile(context) ? 16 : 24;
}
