import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:planner_app/ui/register/viewmodel/register_viewmodel.dart';
import '../../../config/assets.dart';
import '../../../utils/extensions/theme_extension.dart';
import '../../core/localization/app_localization.dart';
import '../../core/theme/app_colors.dart';

import '../../core/ui/error_indicator.dart';
import 'information_card.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({
    super.key,
    required this.viewModel,
    required this.localizations,
  });

  final RegisterViewModel viewModel;
  final AppLocalization localizations;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Assets.background),
            opacity: 1,
            scale: 0.7,
          ),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 40,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(Assets.logo),
            const SizedBox(
              height: 12,
            ),
            Text(
              AppLocalization.of(context).welcomeText,
              style: context.theme.textTheme.displayLarge,
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 32),
              child: ListenableBuilder(
                listenable: viewModel.load,
                builder: (context, child) {
                  if (viewModel.load.running) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (viewModel.load.error) {
                    return Center(
                      child: ErrorIndicator(
                        title: localizations.errorWhileLoadingCities,
                        label: localizations.tryAgain,
                        onPressed: viewModel.load.execute,
                      ),
                    );
                  }
                  return child!;
                },
                child: InformationCard(
                  viewModel: viewModel,
                  localizations: localizations,
                ),
              ),
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 460),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: AppLocalization.of(context).policiesText,
                      style: context.theme.textTheme.bodySmall,
                    ),
                    TextSpan(
                      text: AppLocalization.of(context).useTerms,
                      style: context.theme.textTheme.bodySmall!.copyWith(
                        color: AppColors.zinc[200],
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.zinc[200],
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // showOffScreen(
                          //   dialog: ConfirmRegistrationDialog(
                          //     viewModel: viewModel,
                          //   ),
                          //   isPortrait: false,
                          //   context: context,
                          // );
                        },
                    ),
                    TextSpan(
                      text: AppLocalization.of(context).and,
                      style: context.theme.textTheme.bodySmall,
                    ),
                    TextSpan(
                      text: AppLocalization.of(context).privacyPolicies,
                      style: context.theme.textTheme.bodySmall!.copyWith(
                        color: AppColors.zinc[200],
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.zinc[200],
                      ),
                    ),
                    TextSpan(
                      text: AppLocalization.of(context).dot,
                      style: context.theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
