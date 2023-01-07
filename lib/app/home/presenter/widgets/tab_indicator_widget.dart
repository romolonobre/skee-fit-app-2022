// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../core/skee_ui/skee_palette.dart';

class TabIndicatorWidget extends StatelessWidget {
  int selectedIndex;

  TabIndicatorWidget({
    Key? key,
    this.selectedIndex = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedAlign(
      duration: const Duration(milliseconds: 200),
      alignment: selectedIndex == 0 ? Alignment.centerLeft : Alignment.centerRight,
      child: Padding(
        padding: EdgeInsets.only(left: selectedIndex == 0 ? 80 : 0, right: selectedIndex == 1 ? 60 : 0),
        child: Container(
          height: 1.4,
          width: selectedIndex == 0 ? 45 : 45,
          decoration: const BoxDecoration(
            color: WEPalette.primaryColor,
          ),
        ),
      ),
    );
  }
}
