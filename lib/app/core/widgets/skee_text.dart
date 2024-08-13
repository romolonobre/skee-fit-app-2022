import 'package:flutter/material.dart';

class SkeeText {
  static Widget custom(
    String label, {
    double fontsize = 15,
    Color? color,
    TextAlign? textAlign,
    FontWeight? fontWeight,
  }) {
    return Text(
      label,
      textAlign: textAlign ?? TextAlign.left,
      style: TextStyle(
        fontSize: fontsize,
        color: color ?? Colors.black,
        fontWeight: fontWeight ?? FontWeight.w400,
      ),
    );
  }

  static Widget title(
    String label, {
    double fontsize = 25,
    Color? color,
    FontWeight? fontWeight,
    TextAlign? textAlign,
  }) {
    return Text(
      label,
      textAlign: textAlign ?? TextAlign.left,
      style: TextStyle(
        fontSize: fontsize,
        color: color ?? Colors.black,
        fontWeight: fontWeight ?? FontWeight.w700,
      ),
    );
  }
}
