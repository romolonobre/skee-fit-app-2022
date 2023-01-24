import 'package:flutter/material.dart';

class CustomDimissibleWidget extends StatelessWidget {
  final Widget child;
  Function(DismissDirection) onDismissed;

  CustomDimissibleWidget({
    Key? key,
    required this.child,
    required this.onDismissed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      background: Container(
        width: 20,
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 15,
        ),
        margin: const EdgeInsets.only(top: 8),
        decoration: BoxDecoration(
          color: Colors.red.shade400,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            Icon(
              Icons.delete_outline_outlined,
              size: 50,
              color: Colors.grey,
            ),
          ],
        ),
      ),
      child: child,
      onDismissed: (direction) => onDismissed(direction),
    );
  }
}
