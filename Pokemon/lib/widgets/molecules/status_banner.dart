import 'package:flutter/material.dart';

/// Molecule: red banner shown when a refresh fails but old data is on screen.
class StatusBanner extends StatelessWidget {
  final String title;
  final String subtitle;
  const StatusBanner({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) => Card(
        color: Colors.red.shade900,
        child: ListTile(
          leading: const Icon(Icons.wifi_off),
          title: Text(title),
          subtitle: Text(subtitle),
        ),
      );
}
