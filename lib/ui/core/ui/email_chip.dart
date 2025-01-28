import 'package:flutter/material.dart';
import 'package:planner_app/ui/core/theme/app_colors.dart';

class EmailChip extends StatelessWidget {
  const EmailChip({
    super.key,
    required this.email,
    required this.onDeleted,
  });
  final String email;
  final VoidCallback onDeleted;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        email,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      onDeleted: onDeleted,
      elevation: 1,
      side: BorderSide.none,
      deleteIcon: const Icon(Icons.close),
      backgroundColor: AppColors.zinc[800],
    );
  }
}
