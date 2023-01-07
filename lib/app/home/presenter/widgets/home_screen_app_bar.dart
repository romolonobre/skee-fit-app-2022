import 'package:flutter/material.dart';

import '../../../core/skee_ui/skee_palette.dart';
import '../../../widgets/we_text.dart';

class HomeScreenAppBar extends StatelessWidget with PreferredSizeWidget {
  const HomeScreenAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 60,
      backgroundColor: WEPalette.backgroudColor,
      elevation: 0,
      centerTitle: false,
      title: WEText.title(
        'Start Workout',
        color: Colors.white,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
