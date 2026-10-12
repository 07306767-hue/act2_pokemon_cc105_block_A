import 'package:flutter/material.dart';

/// Atom: one small label, optionally with an icon.
class InfoChip extends StatelessWidget {
  final String label;
  final IconData? icon;
  const InfoChip({super.key, required this.label, this.icon});

  @override
  Widget build(BuildContext context) => Chip(
        avatar: icon == null ? null : Icon(icon, size: 16),
        label: Text(label),
      );
}
