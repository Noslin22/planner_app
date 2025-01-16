import 'package:flutter/material.dart';
import 'package:planner_app/ui/home/viewmodel/details_viewmodel.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/ui/blured_bottom_sheet.dart';

class LinkDialog extends StatelessWidget {
  const LinkDialog({
    super.key,
    required this.viewModel,
  });

  final DetailsViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: Listenable.merge([
        viewModel,
        viewModel.addLink,
      ]),
      builder: (context, _) {
        return BluredBottomSheet(
          label: 'Cadastrar Link',
          contents: [
            const Text(
                'Todos convidados podem visualizar os links importantes.'),
            const SizedBox(height: 19),
            TextField(
              onChanged: (value) => viewModel.linkName = value,
              decoration: AppTheme.filledInputDecoration(
                Icons.sell,
                'Título do link',
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              onChanged: (value) => viewModel.linkUrl = value,
              decoration: AppTheme.filledInputDecoration(
                Icons.link,
                'URL',
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: viewModel.canAddLink
                  ? () {
                      viewModel.addLink
                          .execute(viewModel.linkName!, viewModel.linkUrl!)
                          .then(
                        (_) {
                          if (context.mounted) {
                            Navigator.pop(context);
                          }
                        },
                      );
                    }
                  : null,
              child: viewModel.addLink.running
                  ? const CircularProgressIndicator(
                      color: AppColors.textButtonColor,
                    )
                  : const Text('Salvar Link'),
            ),
          ],
        );
      },
    );
  }
}
