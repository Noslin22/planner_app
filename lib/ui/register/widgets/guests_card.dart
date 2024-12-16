import 'package:flutter/material.dart';
import 'package:planner_app/ui/core/localization/app_localization.dart';
import 'package:planner_app/ui/register/viewmodel/register_viewmodel.dart';
import 'package:planner_app/ui/register/widgets/guests_dialog.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../core/ui/show_off_screen.dart';

class GuestsCard extends StatelessWidget {
  const GuestsCard({
    super.key,
    required this.viewModel,
    required this.isPortrait,
  });
  final RegisterViewModel viewModel;
  final bool isPortrait;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalization.of(context);
    if (viewModel.state == RegisterState.initial) {
      return Container();
    } else {
      return Flex(
        direction: isPortrait ? Axis.horizontal : Axis.vertical,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment:
            isPortrait ? CrossAxisAlignment.center : CrossAxisAlignment.stretch,
        children: [
          !isPortrait
              ? const Padding(
                  padding: EdgeInsets.only(top: 12),
                  child: Divider(
                    color: AppColors.zinc800,
                  ),
                )
              : Container(),
          ListenableBuilder(
              listenable: viewModel,
              builder: (context, _) {
                final child = TextField(
                  readOnly: true,
                  controller: TextEditingController.fromValue(
                    TextEditingValue(
                      text: localizations.invitedGuests(
                        viewModel.guests.length,
                      ),
                    ),
                  ),
                  decoration: InputDecoration(
                    hintText: localizations.guestsHint,
                    icon: const Icon(Icons.person_add),
                    iconColor: AppColors.secondaryColor,
                  ),
                  onTap: () {
                    showOffScreen(
                      dialog: GuestsDialog(
                        viewModel: viewModel,
                      ),
                      isPortrait: isPortrait,
                      context: context,
                    );
                  },
                );
                if (isPortrait) {
                  return Expanded(
                    child: child,
                  );
                } else {
                  return child;
                }
              }),
          const SizedBox(
            height: 12,
          ),
          ElevatedButton(
            style: AppTheme.primaryButtonStyle,
            onPressed: viewModel.guests.isNotEmpty ? () {} : null,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(localizations.confirmTrip),
                const SizedBox(
                  width: 8,
                ),
                const Icon(Icons.arrow_forward)
              ],
            ),
          ),
        ],
      );
    }
  }
}
