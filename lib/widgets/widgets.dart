import 'package:flutter/material.dart';

class IconText extends StatelessWidget {
  final String? tooltip;
  final String text;
  final IconData iconData;
  final Color? color;

  const IconText(
    this.iconData,
    this.text, {
    this.color,
    this.tooltip,
    double size = 15,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip ?? '',
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            iconData,
            color: color,
            size: 16,
          ),
          const SizedBox(width: 3),
          Padding(
            padding: const EdgeInsets.only(top: 1.8),
            child: Text(
              text,
              style: TextStyle(color: color),
            ),
          ),
        ],
      ),
    );
  }
}
