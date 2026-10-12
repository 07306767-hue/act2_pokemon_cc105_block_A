import 'package:flutter/material.dart';

/// Atom: small grey helper text.
class CaptionText extends StatelessWidget {
  final String text;
  const CaptionText(this.text, {super.key});

  @override
  Widget build(BuildContext context) =>
      Text(text, style: Theme.of(context).textTheme.bodySmall);
}
