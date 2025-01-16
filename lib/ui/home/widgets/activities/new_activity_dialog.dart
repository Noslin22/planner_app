import 'package:flutter/material.dart';
import 'package:planner_app/ui/core/localization/app_localization.dart';
import 'package:planner_app/ui/core/theme/app_colors.dart';
import 'package:planner_app/ui/core/ui/blured_bottom_sheet.dart';
import 'package:planner_app/ui/home/viewmodel/activities_viewmodel.dart';
import 'package:planner_app/utils/extensions/date_time_extension.dart';

import '../../../../domain/models/activitiy_model.dart';
import '../../../core/theme/app_theme.dart';

class NewActivityDialog extends StatelessWidget {
  const NewActivityDialog({
    super.key,
    required this.viewModel,
    required this.localizations,
  });

  final ActivitiesViewModel viewModel;
  final AppLocalization localizations;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: Listenable.merge([
        viewModel,
        viewModel.createActivity,
      ]),
      builder: (context, _) {
        return BluredBottomSheet(
          label: 'Cadastrar Atividade',
          contents: [
            const Text('Todos convidados podem visualizar as atividades.'),
            const SizedBox(height: 19),
            TextField(
              onChanged: (value) => viewModel.activityName = value,
              decoration: AppTheme.filledInputDecoration(
                Icons.sell,
                'Qual a atividade?',
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: TextEditingController(
                      text: viewModel.activityDate
                          ?.toFormattedDate(localizations),
                    ),
                    onTap: () {
                      showDatePicker(
                        context: context,
                        firstDate: viewModel.trip.dateRange.start,
                        lastDate: viewModel.trip.dateRange.end,
                        builder: (context, child) {
                          return Theme(
                            data: ThemeData(
                              colorScheme: ColorScheme.dark(
                                onPrimary: AppColors.textButtonColor,
                                onSurface: AppColors.zinc[50]!,
                                primary: AppColors.buttonColor,
                              ),
                            ),
                            child: child!,
                          );
                        },
                      ).then(
                        (value) {
                          viewModel.activityDate = value;
                        },
                      );
                    },
                    decoration: AppTheme.filledInputDecoration(
                      Icons.calendar_today,
                      'Data',
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 150),
                  child: TextField(
                    controller: TextEditingController(
                      text: viewModel.activityTime?.format(context),
                    ),
                    onTap: () {
                      showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      ).then(
                        (value) {
                          if (value == null) return;
                          viewModel.activityTime = TimeOfDay(
                            hour: value.hour,
                            minute: value.minute,
                          );
                        },
                      );
                    },
                    decoration: AppTheme.filledInputDecoration(
                      Icons.access_time,
                      'Horário',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: viewModel.canCreateActivity
                  ? () {
                      viewModel.createActivity
                          .execute(
                        ActivitiyModel(
                          name: viewModel.activityName!,
                          dateTime: viewModel.activityDate!.add(
                            Duration(
                              hours: viewModel.activityTime!.hour,
                              minutes: viewModel.activityTime!.minute,
                            ),
                          ),
                        ),
                      )
                          .then(
                        (_) {
                          if (context.mounted) {
                            Navigator.pop(context);
                          }
                        },
                      );
                    }
                  : null,
              child: viewModel.createActivity.running
                  ? const CircularProgressIndicator(
                      color: AppColors.textButtonColor,
                    )
                  : const Text('Salvar Atividade'),
            ),
          ],
        );
      },
    );
  }
}
