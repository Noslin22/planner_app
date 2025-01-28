import 'package:flutter/material.dart';
import 'package:planner_app/ui/core/theme/app_colors.dart';
import 'package:planner_app/ui/core/theme/app_theme.dart';
import 'package:planner_app/ui/core/ui/blured_bottom_sheet.dart';
import 'package:planner_app/utils/extensions/date_range_extension.dart';

import '../../core/localization/app_localization.dart';
import '../viewmodel/register_viewmodel.dart';

class ConfirmRegistrationDialog extends StatelessWidget {
  ConfirmRegistrationDialog({
    super.key,
    required this.viewModel,
    required this.localizations,
  });
  final RegisterViewModel viewModel;
  final AppLocalization localizations;

  final nameController = TextEditingController();
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BluredBottomSheet(
      label: localizations.confirmLabel,
      contents: [
        RichText(
          text: TextSpan(
            text: localizations.forConfirmTrip,
            style: const TextStyle(
              color: AppColors.zinc,
              fontSize: 16,
            ),
            children: [
              TextSpan(
                text: viewModel.destination!.destinationFormat,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextSpan(text: localizations.inTheDatesOf),
              TextSpan(
                text: viewModel.dateRange!.formatBySize(
                  localization: AppLocalization.of(context),
                ),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextSpan(text: localizations.fillYourData),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        TextField(
          controller: nameController,
          decoration: AppTheme.filledInputDecoration(
            Icons.person_outline,
            localizations.yourName,
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        TextField(
          controller: emailController,
          decoration: AppTheme.filledInputDecoration(
            Icons.email_outlined,
            localizations.yourEmail,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        ListenableBuilder(
          listenable: Listenable.merge([
            nameController,
            emailController,
            viewModel.createTrip,
          ]),
          builder: (context, _) {
            final isComplete = nameController.text.isNotEmpty &&
                emailController.text.isNotEmpty;

            final Widget buttonChild;

            if (viewModel.createTrip.running) {
              buttonChild = const Center(
                child: SizedBox.square(
                  dimension: 24,
                  child: CircularProgressIndicator(
                    color: AppColors.textButtonColor,
                  ),
                ),
              );
            } else {
              buttonChild = Text(localizations.confirmTripButton);
            }

            final VoidCallback? onPressed;

            if (isComplete) {
              onPressed = () async {
                await viewModel.createTrip.execute(
                  nameController.text,
                  emailController.text,
                );
              };
            } else {
              onPressed = null;
            }

            return ElevatedButton(
              onPressed: onPressed,
              child: buttonChild,
            );
          },
        ),
      ],
    );
  }
}
