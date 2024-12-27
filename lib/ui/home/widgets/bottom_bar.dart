import 'package:flutter/material.dart';
import 'package:planner_app/ui/home/viewmodel/home_viewmodel.dart';

import '../../core/theme/app_theme.dart';
import '../../core/ui/shaded_card.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({
    super.key,
    required this.viewModel,
  });
  final HomeViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return ShadedCard(
      child: Row(
        children: [
          Flexible(
            child: ElevatedButton(
              style: viewModel.isActivities
                  ? AppTheme.primaryButtonStyle
                  : AppTheme.secondaryButtonStyle,
              onPressed: () {
                viewModel.isActivities = true;
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.calendar_month),
                  SizedBox(
                    width: 8,
                  ),
                  Text("Atividades")
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Flexible(
            child: ElevatedButton(
              style: viewModel.isActivities
                  ? AppTheme.secondaryButtonStyle
                  : AppTheme.primaryButtonStyle,
              onPressed: () {
                viewModel.isActivities = false;
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.info_outline),
                  SizedBox(
                    width: 8,
                  ),
                  Text("Detalhes")
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
