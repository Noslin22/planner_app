import 'package:flutter/material.dart';
import 'package:planner_app/domain/models/activitiy_model.dart';
import 'package:planner_app/ui/core/localization/app_localization.dart';
import 'package:planner_app/ui/core/theme/app_colors.dart';
import 'package:planner_app/ui/home/widgets/activities/activity_tile.dart';
import 'package:planner_app/utils/extensions/date_time_extension.dart';

class DayTile extends StatelessWidget {
  const DayTile({
    super.key,
    required this.activities,
    required this.index,
    required this.date,
    required this.localizations,
  });

  final List<ActivitiyModel> activities;
  final DateTime date;
  final AppLocalization localizations;
  final int index;

  bool get hasPassed {
    final now = DateTime.now();

    return now.difference(date).inMilliseconds > 0 && !now.isSameDay(date);
  }

  @override
  Widget build(BuildContext context) {
    double opacity = hasPassed ? 0.5 : 1;
    return Opacity(
      opacity: opacity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Dia ${date.day.toString().padLeft(2, '0')}',
                style: TextTheme.of(context).titleMedium,
              ),
              const SizedBox(width: 8),
              Text(
                date.localizedWeekday(localizations),
                style: TextTheme.of(context).labelSmall,
              ),
            ],
          ),
          const SizedBox(height: 10),
          activitiesList(),
        ],
      ),
    );
  }

  Widget activitiesList() {
    if (activities.isEmpty) {
      return Text(
        'Nenhuma atividade cadastrada nessa data',
        style: TextStyle(
          color: AppColors.zinc[500],
          fontSize: 14,
        ),
      );
    }

    return ListView.separated(
      itemCount: activities.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (context, index) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final activity = activities[index];
        return ActivityTile(activity: activity);
      },
    );
  }
}
