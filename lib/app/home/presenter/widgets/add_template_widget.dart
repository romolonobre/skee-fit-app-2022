import 'package:flutter/material.dart';

import '../../../widgets/skee_text.dart';

class AddTemplateWidget extends StatelessWidget {
  const AddTemplateWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border(
          left: BorderSide(width: 0.2, color: Colors.grey.shade800),
          right: BorderSide(width: 0.2, color: Colors.grey.shade800),
          top: BorderSide(width: 0.2, color: Colors.grey.shade800),
          bottom: BorderSide(width: 0.2, color: Colors.grey.shade800),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            WEText.title(
              'New template',
              fontsize: 18,
            ),
            const SizedBox(height: 12),
            WEText.custom(
              'ab Wheel',
              color: Colors.grey,
            )
          ],
        ),
      ),
    );
  }
}
