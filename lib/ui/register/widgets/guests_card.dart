import 'package:flutter/material.dart';
import 'package:planner_app/ui/core/localization/app_localization.dart';
import 'package:planner_app/ui/register/viewmodel/register_viewmodel.dart';
import 'package:planner_app/ui/register/widgets/guests_dialog.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../core/ui/show_off_screen.dart';
import 'confirm_registration_dialog.dart';

class GuestsCard extends StatelessWidget {
  const GuestsCard({
    super.key,
    required this.viewModel,
    required this.isPortrait,
    required this.localizations,
  });

  final RegisterViewModel viewModel;
  final bool isPortrait;
  final AppLocalization localizations;

  @override
  Widget build(BuildContext context) {
    if (viewModel.state == RegisterState.initial) {
      return Container();
    } else {
      final Axis direction;
      final CrossAxisAlignment alignment;
      final Widget divider;

      if (isPortrait) {
        direction = Axis.horizontal;
        alignment = CrossAxisAlignment.center;
        divider = Container();
      } else {
        direction = Axis.vertical;
        alignment = CrossAxisAlignment.stretch;
        divider = Padding(
          padding: const EdgeInsets.only(top: 12),
          child: Divider(
            color: AppColors.zinc[800],
          ),
        );
      }
      return Flex(
        direction: direction,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: alignment,
        children: [
          divider,
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
                  iconColor: AppColors.zinc,
                ),
                onTap: () {
                  showOffScreen(
                    dialog: GuestsDialog(
                      viewModel: viewModel,
                      localizations: localizations,
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
            },
          ),
          const SizedBox(
            height: 12,
          ),
          ElevatedButton(
            style: AppTheme.primaryButtonStyle,
            onPressed: onPressed(
              isPortrait: isPortrait,
              context: context,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(localizations.confirmTrip),
                const SizedBox(
                  width: 8,
                ),
                const Icon(
                  Icons.arrow_forward,
                )
              ],
            ),
          ),
        ],
      );
    }
  }

  VoidCallback? onPressed({
    required bool isPortrait,
    required BuildContext context,
  }) {
    if (viewModel.guests.isNotEmpty) {
      return () {
        showOffScreen(
          dialog: ConfirmRegistrationDialog(
            viewModel: viewModel,
            localizations: localizations,
          ),
          isPortrait: isPortrait,
          context: context,
        );
      };
    } else {
      return null;
    }
  }
}
