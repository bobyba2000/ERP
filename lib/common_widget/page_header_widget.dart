import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class PageHeaderWidget extends StatelessWidget {
  final String label;
  final Color? textColor;
  final IconData? rightIcon;
  final Function? onTapRightIcon;
  const PageHeaderWidget({
    Key? key,
    required this.label,
    this.textColor,
    this.rightIcon,
    this.onTapRightIcon,
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
        const Spacer(),
        Visibility(
          child: InkWell(
            onTap: () {
              onTapRightIcon?.call();
            },
            child: Icon(
              rightIcon,
              color: theme.accentColor,
              size: 30,
            ),
          ),
          visible: rightIcon != null,
        ),
      ],
    );
  }
}
