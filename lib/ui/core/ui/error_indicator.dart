import 'package:flutter/material.dart';
import 'package:planner_app/ui/core/ui/shaded_card.dart';

import '../theme/app_colors.dart';

class ErrorIndicator extends StatelessWidget {
  const ErrorIndicator({
    super.key,
    required this.title,
    required this.label,
    required this.onPressed,
  });

  final String title;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ShadedCard(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IntrinsicWidth(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Row(
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          FilledButton(
            onPressed: onPressed,
            style: const ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(AppColors.onError),
              foregroundColor: WidgetStatePropertyAll(Colors.white),
            ),
            child: Text(label),
          ),
        ],
      ),
    );
  }
}
