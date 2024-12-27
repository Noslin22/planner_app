import 'package:flutter/material.dart';
import 'package:planner_app/ui/core/theme/app_colors.dart';
import 'package:planner_app/ui/register/viewmodel/register_viewmodel.dart';

class EmailChip extends StatelessWidget {
  const EmailChip({
    super.key,
    required this.email,
    required this.viewModel,
  });
  final String email;
  final RegisterViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        email,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      onDeleted: () {
        viewModel.removeGuest(email);
      },
      elevation: 1,
      side: BorderSide.none,
      deleteIcon: const Icon(Icons.close),
      backgroundColor: AppColors.zinc[800],
    );
  }
}
