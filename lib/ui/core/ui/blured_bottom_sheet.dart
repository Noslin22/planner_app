import 'dart:ui';

import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class BluredBottomSheet extends StatelessWidget {
  const BluredBottomSheet({
    super.key,
    required this.label,
    required this.contents,
    this.canClose = true,
  });
  final String label;
  final bool canClose;
  final List<Widget> contents;

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
      child: Container(
        padding: const EdgeInsets.fromLTRB(24, 12, 10, 20),
        constraints: const BoxConstraints(maxWidth: 720),
        color: AppColors.zinc[900],
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                canClose
                    ? IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      )
                    : Container(),
              ],
            ),
            const SizedBox(height: 8),
            ...contents,
          ],
        ),
      ),
    );
  }
}
