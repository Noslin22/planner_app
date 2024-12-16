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
  });
  final RegisterViewModel viewModel;
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalization.of(context);
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
              viewModel.guests.isNotEmpty
                  ? const SizedBox(
                      height: 19,
                    )
                  : Container(),
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
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Divider(
                  color: AppColors.zinc800,
                ),
              ),
              TextField(
                controller: controller,
                decoration: InputDecoration(
                  filled: true,
                  contentPadding: const EdgeInsets.symmetric(vertical: 20),
                  prefixIcon: const Padding(
                    padding: EdgeInsets.only(left: 16, right: 8),
                    child: Icon(
                      Icons.alternate_email_rounded,
                      color: AppColors.secondaryColor,
                    ),
                  ),
                  hintText: localizations.emailHint,
                  fillColor: AppColors.zinc950,
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.zinc800,
                    ),
                  ),
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
                    onPressed: controller.text.isEmpty
                        ? null
                        : () {
                            viewModel.addGuest(controller.text);
                            controller.clear();
                          },
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
        });
  }
}
