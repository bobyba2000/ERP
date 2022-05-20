import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class PageHeaderWidget extends StatelessWidget {
  final String label;
  final Color? textColor;
  const PageHeaderWidget({
    Key? key,
    required this.label,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        InkWell(
          child: Icon(
            Iconsax.arrow_left,
            color: theme.accentColor,
          ),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
        const SizedBox(width: 16),
        Text(
          label,
          style: TextStyle(
            color: textColor ?? theme.primaryColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
