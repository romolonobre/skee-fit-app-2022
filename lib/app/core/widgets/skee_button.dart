import 'package:flutter/material.dart';

import '../skee_ui/skee_palette.dart';
import 'flutter_widgets.dart';

class SkeeButton {
  static Widget filled(
    String label, {
    Color? color,
    double? width,
    double? height,
    double? fontsize,
    FontWeight? fontWeight,
    TextAlign? textAlign,
    required VoidCallback ontap,
  }) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: height ?? 50,
        width: width ?? double.infinity,
        decoration: BoxDecoration(
          color: color ?? SkeePalette.primaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            label,
            textAlign: textAlign ?? TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: fontsize ?? 17,
              fontWeight: fontWeight ?? FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }

  static Widget text(
    String label, {
    Color? color,
    double? fontsize,
    TextAlign? textAlign,
    required VoidCallback ontap,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: ontap,
        child: SkeeText.custom(
          label,
          color: color ?? SkeePalette.primaryColor,
          fontWeight: FontWeight.bold,
          fontsize: fontsize ?? 18,
        ),
      ),
    );
  }

  static iconButton({
    required IconData icon,
    required VoidCallback ontap,
    Color? backGroundColor,
    Color? iconColor,
    double? height,
    double? width,
    double? iconSize,
  }) {
    return InkWell(
      onTap: ontap,
      child: Container(
          height: height ?? 33,
          width: width ?? 33,
          decoration: BoxDecoration(
            color: backGroundColor ?? SkeePalette.primaryColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Icon(
            icon,
            size: iconSize ?? 20,
            color: iconColor ?? SkeePalette.primaryColor,
          )),
    );
  }
}
