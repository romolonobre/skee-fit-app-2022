// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/widgets/skee_button.dart';
import '../cubit/youtube_videos_cubit.dart';

class TabButton extends StatefulWidget {
  final int selectedIndex;
  final Function ontap;
  final String title;
  final Color color;
  const TabButton({
    super.key,
    required this.selectedIndex,
    required this.ontap,
    required this.title,
    required this.color,
  });

  @override
  State<TabButton> createState() => _TabButtonState();
}

class _TabButtonState extends State<TabButton> {
  final cubit = Modular.get<YoutubeVideosCubit>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SkeeButton.text(
              widget.title,
              color: widget.color,
              ontap: (() async => widget.ontap()),
            ),
          ],
        ),
      ],
    );
  }
}
