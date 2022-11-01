// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_ui_toolkit/flutter_ui_toolkit.dart';

class SkeeContainer extends StatelessWidget {
  const SkeeContainer({
    Key? key,
    required this.child,
    this.color = Colors.white,
    this.padding,
  }) : super(key: key);
  final Widget child;
  final Color color;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return UIContainer(
      as: defaultContainer,
      color: color,
      padding: padding,
      child: child,
    );
  }
}

final defaultContainer = UIContainerDefaults(
    borderRadius: 12.0,
    color: Colors.white,
    shadow: const BoxShadow(
      color: Color.fromRGBO(214, 214, 214, 0.45),
      blurRadius: 10,
      offset: Offset(0, 3),
    ));
