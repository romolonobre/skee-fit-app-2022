import 'package:flutter/material.dart';

import 'skee_palette.dart';

class WELoader extends StatelessWidget {
  const WELoader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      color: WEPalette.primaryColor,
      strokeWidth: 3,
      backgroundColor: Colors.grey.shade200,
    );
  }
}
