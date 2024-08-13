import 'package:flutter/material.dart';

import 'skee_palette.dart';

class SkeeLoader extends StatelessWidget {
  const SkeeLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      color: SkeePalette.primaryColor,
      strokeWidth: 3,
      backgroundColor: Colors.grey.shade200,
    );
  }
}
