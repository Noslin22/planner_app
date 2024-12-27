import 'package:flutter/material.dart';
import 'package:planner_app/ui/core/localization/app_localization.dart';
import 'package:planner_app/ui/core/theme/app_theme.dart';
import 'package:planner_app/ui/core/ui/shaded_card.dart';
import 'package:planner_app/ui/home/viewmodel/home_viewmodel.dart';
import 'package:planner_app/utils/extensions/date_range_extension.dart';

import '../../core/theme/app_colors.dart';

class TopBar extends StatelessWidget {
  const TopBar({
    super.key,
    required this.viewModel,
    required this.isPortrait,
  });

  final HomeViewModel viewModel;
  final bool isPortrait;

  @override
  Widget build(BuildContext context) {
    return ShadedCard(
      child: Row(
        children: [
          const Icon(Icons.place),
          const SizedBox(
            width: 8,
          ),
          Text(viewModel.trip!.city.destinationFormat),
          const Spacer(),
          ...isPortrait
              ? [
                  const Icon(Icons.calendar_today),
                  const SizedBox(
                    width: 8,
                  ),
                ]
              : [],
          Text(
            viewModel.trip!.dateRange.longFormat(
              AppLocalization.of(context),
            ),
          ),
          isPortrait
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    width: 2,
                    height: 36,
                    color: AppColors.zinc[800],
                  ),
                )
              : const SizedBox(
                  width: 12,
                ),
          ElevatedButton(
            onPressed: () {},
            style: AppTheme.secondaryButtonStyle.copyWith(
              padding: WidgetStateProperty.all(
                const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
              ),
            ),
            child: Row(
              children: [
                ...isPortrait
                    ? [
                        Text(AppLocalization.of(context).changePlaceDate),
                        const SizedBox(
                          width: 8,
                        ),
                      ]
                    : [],
                const Icon(
                  Icons.tune,
                  size: 22,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
