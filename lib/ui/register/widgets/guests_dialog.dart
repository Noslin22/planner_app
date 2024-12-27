import 'package:flutter/material.dart';
import 'package:planner_app/ui/core/localization/app_localization.dart';
import 'package:planner_app/ui/register/viewmodel/register_viewmodel.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../core/ui/blured_bottom_sheet.dart';
import 'email_chip.dart';

class GuestsDialog extends StatelessWidget {
  GuestsDialog({
    super.key,
    required this.viewModel,
    required this.localizations,
  });
  final RegisterViewModel viewModel;
  final AppLocalization localizations;

  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) {
        return BluredBottomSheet(
          label: localizations.selectedGuests,
          contents: [
            Text(
              localizations.guestsText,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            separator(),
            Flexible(
              child: SingleChildScrollView(
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: List.generate(
                    viewModel.guests.length,
                    (index) {
                      final String email = viewModel.guests[index];
                      return EmailChip(
                        email: email,
                        viewModel: viewModel,
                      );
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Divider(
                color: AppColors.zinc[800],
              ),
            ),
            TextField(
              controller: controller,
              decoration: AppTheme.filledInputDecoration(
                Icons.alternate_email_rounded,
                localizations.emailHint,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            ListenableBuilder(
              listenable: controller,
              builder: (context, child) {
                return ElevatedButton(
                  style: AppTheme.primaryButtonStyle,
                  onPressed: onPressed(),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(localizations.inviteLabel),
                      const SizedBox(
                        width: 8,
                      ),
                      const Icon(Icons.add)
                    ],
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  Widget separator() {
    if (viewModel.guests.isNotEmpty) {
      return const SizedBox(
        height: 19,
      );
    } else {
      return Container();
    }
  }

  VoidCallback? onPressed() {
    if (controller.text.isEmpty) {
      return null;
    } else {
      return () {
        viewModel.addGuest(controller.text);
        controller.clear();
      };
    }
  }
}
