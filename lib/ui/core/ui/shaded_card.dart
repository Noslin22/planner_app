import 'package:flutter/material.dart';

import '../../../ui/core/theme/app_colors.dart';

class ShadedCard extends StatelessWidget {
  const ShadedCard({
    super.key,
    required this.child,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.zinc[900],
        boxShadow: [
          BoxShadow(
            spreadRadius: 1,
            blurStyle: BlurStyle.inner,
            color: Colors.white.withValues(alpha: 0.03),
          ),
          BoxShadow(
            offset: const Offset(0, 1),
            blurStyle: BlurStyle.inner,
            color: Colors.white.withValues(alpha: 0.03),
          ),
          BoxShadow(
            offset: const Offset(0, 8),
            blurStyle: BlurStyle.outer,
            blurRadius: 8,
            color: Colors.black.withValues(alpha: 0.1),
          ),
          BoxShadow(
            offset: const Offset(0, 4),
            blurStyle: BlurStyle.outer,
            blurRadius: 4,
            color: Colors.black.withValues(alpha: 0.1),
          ),
          BoxShadow(
            offset: const Offset(0, 2),
            blurStyle: BlurStyle.outer,
            blurRadius: 2,
            color: Colors.black.withValues(alpha: 0.1),
          ),
          BoxShadow(
            blurStyle: BlurStyle.outer,
            spreadRadius: 1,
            color: Colors.black.withValues(alpha: 0.1),
          ),
        ],
      ),
      child: child,
    );
  }
}
