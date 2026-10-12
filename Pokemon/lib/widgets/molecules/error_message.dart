import 'package:flutter/material.dart';

import '../atoms/retry_button.dart';

/// Molecule: icon + message + optional Retry button + optional footer line.
class ErrorMessage extends StatelessWidget {
  final IconData icon;
  final String message;
  final VoidCallback? onRetry;
  final String? footer;

  const ErrorMessage({
    super.key,
    required this.icon,
    required this.message,
    this.onRetry,
    this.footer,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 48),
            const SizedBox(height: 12),
            Text(message, textAlign: TextAlign.center),
            if (onRetry != null) ...[
              const SizedBox(height: 16),
              RetryButton(onPressed: onRetry!),
            ],
            if (footer != null) ...[
              const SizedBox(height: 8),
              Text(footer!),
            ],
          ],
        ),
      ),
    );
  }
}
