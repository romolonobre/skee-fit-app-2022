import 'package:flutter/material.dart';

class WeLogo extends StatelessWidget {
  const WeLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.network(
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTSaYQPRu2eI6gJCxpTIpHFTwCR9ekTmgQy0g&usqp=CAU',
        height: 120,
      ),
    );
  }
}
