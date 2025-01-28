import 'package:flutter/material.dart';
import 'package:planner_app/domain/models/activitiy_model.dart';
import 'package:planner_app/ui/core/localization/app_localization.dart';
import 'package:planner_app/ui/core/ui/show_off_screen.dart';
import 'package:planner_app/ui/home/widgets/activities/day_tile.dart';
import 'package:planner_app/ui/home/widgets/activities/new_activity_dialog.dart';
import 'package:planner_app/utils/extensions/date_range_extension.dart';
import 'package:planner_app/utils/extensions/date_time_extension.dart';

import '../../viewmodel/activities_viewmodel.dart';

class ActivitiesScreen extends StatelessWidget {
  const ActivitiesScreen({
    super.key,
    required this.viewModel,
    required this.localizations,
    required this.isPortrait,
  });

  final ActivitiesViewModel viewModel;
  final AppLocalization localizations;
  final bool isPortrait;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                localizations.activitiesLabel,
                style: TextTheme.of(context).titleLarge,
              ),
              ElevatedButton(
                child: Row(
                  children: [
                    const Icon(Icons.add),
                    const SizedBox(width: 8),
                    Text(localizations.newActivity),
                  ],
                ),
                onPressed: () {
                  showOffScreen(
                    dialog: NewActivityDialog(
                      viewModel: viewModel,
                      localizations: localizations,
                    ),
                    isPortrait: isPortrait,
                    context: context,
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 2),
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 0, 18, 20),
              child: ListenableBuilder(
                listenable: viewModel,
                builder: (context, _) {
                  int compareActivities(ActivitiyModel a, ActivitiyModel b) {
                    return a.dateTime.compareTo(b.dateTime);
                  }

                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: viewModel.trip.dateRange.duration.inDays + 1,
                    separatorBuilder: (_, __) => const SizedBox(height: 24),
                    itemBuilder: (context, index) {
                      final day = viewModel.trip.dateRange.dayByIndex(index);
                      final dayActivities = viewModel.trip.activities //
                          .where(day.isSameDay)
                          .toList();

                      dayActivities.sort(compareActivities);

                      return DayTile(
                        activities: dayActivities,
                        index: index,
                        date: day,
                        localizations: localizations,
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
