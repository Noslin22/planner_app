import 'package:flutter/material.dart';
import 'package:planner_app/domain/models/guest_model.dart';

import '../../../core/theme/app_colors.dart';

class GuestTile extends StatelessWidget {
  const GuestTile({
    super.key,
    required this.guest,
  });
  final GuestModel guest;

  Widget get checkBox {
    final Border border;
    final Widget icon;

    if (guest.confirmed) {
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

  String get name {
    if (guest.name.isEmpty) {
      return 'Convidado';
    }
    return guest.name;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  color: AppColors.zinc[100],
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                guest.email,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppColors.zinc,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        checkBox
      ],
    );
  }
}
