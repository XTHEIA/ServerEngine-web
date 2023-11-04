import 'package:flutter/material.dart';

class FontBlock extends StatelessWidget {
  final String fontName, fontFamilly, url;
  final Color color;

  const FontBlock({
    required this.fontName,
    required this.fontFamilly,
    required this.url,
    required this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 600,
      decoration: BoxDecoration(
          color: color.withOpacity(0.15),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: Colors.transparent,
          )),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            fontName,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              fontFamily: fontFamilly,
            ),
          ),
          const SizedBox(height: 3),
          SelectableText(
            url,
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontFamily: fontFamilly,
            ),
          ),
        ],
      ),
    );
  }
}
