import 'package:flutter/material.dart';
import 'package:planner_app/domain/models/link_model.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../core/theme/app_colors.dart';

class LinkTile extends StatelessWidget {
  const LinkTile({super.key, required this.link});
  final LinkModel link;

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
                link.name,
                style: TextStyle(
                  color: AppColors.zinc[100],
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                width: 240,
                child: Text(
                  link.url,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.zinc,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: () async {
            await launchUrlString(link.url);
          },
          icon: const Icon(
            Icons.link,
            size: 24,
          ),
        ),
      ],
    );
  }
}
