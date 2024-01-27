import 'package:flutter/material.dart';
import 'package:seo/seo.dart';

class SeoText extends StatelessWidget {
  final String text;
  final TextStyle? style;

  const SeoText(
    this.text, {
    super.key,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Seo.text(
      text: text,
      child: Text(
        text,
        style: style,
      ),
    );
  }
}
