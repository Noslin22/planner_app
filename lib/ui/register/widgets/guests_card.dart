import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:planner_app/ui/core/localization/app_localization.dart';
import 'package:planner_app/ui/register/viewmodel/register_viewmodel.dart';
import 'package:planner_app/ui/register/widgets/register_guests_dialog.dart';

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
                    dialog: RegisterGuestsDialog(
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
          ListenableBuilder(
            listenable: viewModel.updateTrip,
            builder: (context, _) {
              final String label;
              final VoidCallback? onPressed;
              final Widget child;

              if (viewModel.trip != null) {
                label = "Editar Viagem";
                onPressed = () async {
                  await viewModel.updateTrip.execute();
                  if (context.mounted) {
                    context.pop();
                  }
                };
              } else {
                label = localizations.confirmTrip;
                onPressed = createTrip(
                  isPortrait: isPortrait,
                  context: context,
                );
              }

              if (viewModel.updateTrip.running) {
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
                    Text(label),
                    const SizedBox(
                      width: 8,
                    ),
                    const Icon(
                      Icons.arrow_forward,
                    )
                  ],
                );
              }

              return ElevatedButton(
                style: AppTheme.primaryButtonStyle,
                onPressed: onPressed,
                child: child,
              );
            },
          ),
        ],
      );
    }
  }

  VoidCallback? createTrip({
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
