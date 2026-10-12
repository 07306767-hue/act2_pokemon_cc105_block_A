import 'package:flutter/material.dart';

/// Atom: the Retry button.
class RetryButton extends StatelessWidget {
  final VoidCallback onPressed;
  const RetryButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) => FilledButton.icon(
        onPressed: onPressed,
        icon: const Icon(Icons.refresh),
        label: const Text('Retry'),
      );
}
