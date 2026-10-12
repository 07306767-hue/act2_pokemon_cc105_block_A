import 'package:flutter/material.dart';

/// Template: the page layout every screen shares (app bar + body).
class ScreenTemplate extends StatelessWidget {
  final String title;
  final Widget body;
  const ScreenTemplate({super.key, required this.title, required this.body});

  @override
  Widget build(BuildContext context) =>
      Scaffold(appBar: AppBar(title: Text(title)), body: body);
}
