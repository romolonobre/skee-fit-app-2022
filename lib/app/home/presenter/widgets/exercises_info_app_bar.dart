import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../skee_ui/skee_palette.dart';
import '../../../widgets/flutter_widgets.dart';

class ExercicesInfoAppBar extends StatelessWidget with PreferredSizeWidget {
  const ExercicesInfoAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios_new,
          size: 22,
          color: Colors.grey.shade400,
        ),
        onPressed: () => Modular.to.pop(),
      ),
      automaticallyImplyLeading: false,
      backgroundColor: WEPalette.backgroudColor,
      elevation: 0,
      title: WEText.title(
        'Select Exercises',
        fontsize: 28,
        color: Colors.white,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
