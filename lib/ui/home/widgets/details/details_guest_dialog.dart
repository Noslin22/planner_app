import 'package:flutter/material.dart';
import 'package:planner_app/domain/models/guest_model.dart';
import 'package:planner_app/ui/core/localization/app_localization.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/ui/blured_bottom_sheet.dart';
import '../../../core/ui/email_chip.dart';
import '../../viewmodel/details_viewmodel.dart';

class DetailsGuestsDialog extends StatelessWidget {
  const DetailsGuestsDialog({
    super.key,
    required this.viewModel,
    required this.localizations,
  });
  final DetailsViewModel viewModel;
  final AppLocalization localizations;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) {
        final Widget child;
        final VoidCallback? onPressed;

        if (viewModel.newGuest?.isNotEmpty ?? false) {
          onPressed = () async {
            await viewModel.addGuest.execute();
            viewModel.newGuest = null;
          };
        } else {
          onPressed = null;
        }

        if (viewModel.addGuest.running) {
          child = const Center(
            child: SizedBox.square(
              dimension: 24,
              child: CircularProgressIndicator(
                color: AppColors.textButtonColor,
              ),
            ),
          );
        } else {
          child = Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(localizations.inviteLabel),
              const SizedBox(
                width: 8,
              ),
              const Icon(Icons.add)
            ],
          );
        }

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
                    viewModel.trip.guests.length,
                    (index) {
                      final GuestModel guest = viewModel.trip.guests[index];
                      return EmailChip(
                        email: guest.email,
                        onDeleted: () =>
                            viewModel.removeGuest.execute(guest.email),
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
              onChanged: (value) => viewModel.newGuest = value,
              decoration: AppTheme.filledInputDecoration(
                Icons.alternate_email_rounded,
                localizations.emailHint,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            ElevatedButton(
              style: AppTheme.primaryButtonStyle,
              onPressed: onPressed,
              child: child,
            ),
          ],
        );
      },
    );
  }

  Widget separator() {
    if (viewModel.trip.guests.isNotEmpty) {
      return const SizedBox(
        height: 19,
      );
    } else {
      return Container();
    }
  }
}
