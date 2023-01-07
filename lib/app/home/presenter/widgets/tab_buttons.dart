// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../widgets/we_buttons.dart';
import '../../domain/models/youtube_model.dart';
import '../cubit/youtube_videos_cubit.dart';

class TabButton extends StatefulWidget {
  YoutubeModel? channel;
  int selectedIndex;
  final Function ontap;
  final String title;
  Color color;
  TabButton({
    Key? key,
    required this.channel,
    required this.selectedIndex,
    required this.ontap,
    required this.title,
    required this.color,
  }) : super(key: key);

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
            WeButtons.text(
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
