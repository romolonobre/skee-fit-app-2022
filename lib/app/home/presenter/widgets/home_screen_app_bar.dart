import 'package:flutter/material.dart';

import '../../../core/skee_ui/skee_palette.dart';
import '../../../core/widgets/skee_text.dart';

class HomeScreenAppBar extends StatelessWidget {
  const HomeScreenAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 60,
      backgroundColor: SkeePalette.backgroudColor,
      elevation: 0,
      centerTitle: false,
      title: SkeeText.title(
        'Start Workout',
        color: Colors.white,
      ),
    );
  }

  Size get preferredSize => const Size.fromHeight(60);
}
