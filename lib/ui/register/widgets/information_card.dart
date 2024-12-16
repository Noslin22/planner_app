import 'package:flutter/material.dart';

import '../../../utils/extensions/date_range_extension.dart';
import '../../core/localization/app_localization.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../core/ui/shaded_card.dart';
import '../viewmodel/register_viewmodel.dart';
import 'guests_card.dart';
import 'search_cities_field.dart';

class InformationCard extends StatelessWidget {
  InformationCard({
    super.key,
    required this.viewModel,
  });

  final RegisterViewModel viewModel;
  final TextEditingController destinationController = TextEditingController();
  final TextEditingController dateRangeController = TextEditingController();
  final FocusNode focusDestination = FocusNode();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isPortrait = constraints.maxWidth > 780;
        final Axis direction = isPortrait ? Axis.horizontal : Axis.vertical;

        return ListenableBuilder(
          listenable: viewModel,
          builder: (context, _) {
            final localizations = AppLocalization.of(context);

            final ButtonStyle buttonStyle;
            final VoidCallback action;
            final String label;
            final Icon icon;

            switch (viewModel.state) {
              case RegisterState.initial:
                buttonStyle = AppTheme.primaryButtonStyle;
                label = localizations.continueT;
                icon = const Icon(Icons.arrow_forward);
                action = () {
                  if (viewModel.destination != null &&
                      viewModel.dateRange != null) {
                    viewModel.state = RegisterState.half;
                  }
                };
              case RegisterState.half || RegisterState.complete:
                buttonStyle = AppTheme.secondaryButtonStyle;
                label = localizations.changePlaceDate;
                icon = const Icon(Icons.tune);
                action = () {
                  viewModel.state = RegisterState.initial;
                };
            }

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ShadedCard(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 780),
                    child: Flex(
                      direction: direction,
                      children: [
                        Builder(
                          builder: (context) {
                            final child = IgnorePointer(
                              ignoring:
                                  viewModel.state != RegisterState.initial,
                              child: SearchCitiesField(viewModel: viewModel),
                            );
                            if (isPortrait) {
                              return Expanded(child: child);
                            } else {
                              return child;
                            }
                          },
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Flex(
                          direction: direction,
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: isPortrait
                              ? CrossAxisAlignment.center
                              : CrossAxisAlignment.stretch,
                          children: [
                            IgnorePointer(
                              ignoring:
                                  viewModel.state != RegisterState.initial,
                              child: SizedBox(
                                width: isPortrait
                                    ? (viewModel.dateRange == null ? 120 : 215)
                                    : double.maxFinite,
                                child: TextField(
                                  readOnly: true,
                                  controller: dateRangeController,
                                  onTap: () {
                                    showDateRangePicker(
                                      context: context,
                                      locale:
                                          AppLocalization.of(context).locale,
                                      initialDateRange: viewModel.dateRange,
                                      firstDate: DateTime(DateTime.now().year),
                                      lastDate:
                                          DateTime(DateTime.now().year, 12, 31),
                                    ).then(
                                      (dateRange) {
                                        if (dateRange == null) {
                                          return viewModel.dateRange;
                                        }
                                        viewModel.dateRange = dateRange;

                                        dateRangeController.text = viewModel
                                                .dateRange
                                                ?.longFormat(localizations) ??
                                            "";

                                        return viewModel.dateRange;
                                      },
                                    );
                                  },
                                  style: const TextStyle(fontSize: 16),
                                  decoration: InputDecoration(
                                    hintText: localizations.when,
                                    icon: const Icon(Icons.calendar_today),
                                    iconColor: AppColors.secondaryColor,
                                  ),
                                ),
                              ),
                            ),
                            isPortrait
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Container(
                                      width: 2,
                                      height: 36,
                                      color: AppColors.zinc800,
                                    ),
                                  )
                                : Container(),
                            const SizedBox(
                              height: 12,
                            ),
                            ElevatedButton(
                              style: buttonStyle,
                              onPressed: action,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(label),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  icon
                                ],
                              ),
                            ),
                          ],
                        ),
                        ...isPortrait
                            ? [Container()]
                            : [
                                GuestsCard(
                                  viewModel: viewModel,
                                  isPortrait: isPortrait,
                                )
                              ],
                      ],
                    ),
                  ),
                ),
                ...isPortrait && viewModel.state != RegisterState.initial
                    ? [
                        const SizedBox(
                          height: 16,
                        ),
                        ShadedCard(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 780),
                            child: GuestsCard(
                              viewModel: viewModel,
                              isPortrait: isPortrait,
                            ),
                          ),
                        ),
                      ]
                    : []
              ],
            );
          },
        );
      },
    );
  }
}
