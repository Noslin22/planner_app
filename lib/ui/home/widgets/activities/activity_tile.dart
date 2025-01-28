import 'package:flutter/material.dart';
import 'package:planner_app/domain/models/activitiy_model.dart';
import 'package:planner_app/ui/core/ui/shaded_card.dart';
import 'package:planner_app/utils/extensions/date_time_extension.dart';

import '../../../core/theme/app_colors.dart';

class ActivityTile extends StatelessWidget {
  const ActivityTile({
    super.key,
    required this.activity,
  });
  final ActivitiyModel activity;

  bool hasPassed() {
    final now = DateTime.now();
    return now.isAfter(activity.dateTime);
  }

  Widget get checkBox {
    final Border border;
    final Widget icon;

    if (hasPassed()) {
      border = Border.all(
        color: AppColors.buttonColor,
        width: 1,
      );

      icon = const Icon(
        Icons.check,
        color: AppColors.buttonColor,
        size: 10,
      );
    } else {
      border = Border.all(
        color: AppColors.zinc,
        width: 1,
      );

      icon = Container();
    }

    return Container(
      width: 20,
      height: 20,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: border,
      ),
      child: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ShadedCard(
      child: Row(
        children: [
          checkBox,
          const SizedBox(width: 12),
          Text(
            activity.name,
            style: TextTheme.of(context).labelMedium,
          ),
          const Spacer(),
          Text(
            activity.dateTime.toFormattedTime(),
            style: TextTheme.of(context).bodySmall,
          ),
        ],
      ),
    );
  }
}
