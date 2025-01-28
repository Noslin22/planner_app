import 'package:flutter/material.dart';
import 'package:planner_app/ui/core/theme/app_colors.dart';
import 'package:planner_app/ui/core/theme/app_theme.dart';
import 'package:planner_app/ui/core/ui/show_off_screen.dart';
import 'package:planner_app/ui/home/viewmodel/details_viewmodel.dart';
import 'package:planner_app/ui/home/widgets/details/details_guest_dialog.dart';
import 'package:planner_app/ui/home/widgets/details/link_dialog.dart';
import 'package:planner_app/ui/home/widgets/details/link_tile.dart';

import '../../../core/localization/app_localization.dart';
import 'guest_tile.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({
    super.key,
    required this.localizations,
    required this.isPortrait,
    required this.viewModel,
  });

  final DetailsViewModel viewModel;
  final AppLocalization localizations;
  final bool isPortrait;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) {
        return Padding(
          padding: const EdgeInsets.only(right: 2),
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 0, 18, 20),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: isPortrait ? 340 : double.infinity,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Links importantes',
                    style: TextTheme.of(context).titleMedium,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: linksList,
                  ),
                  ElevatedButton(
                    style: AppTheme.secondaryButtonStyle,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add),
                        SizedBox(width: 8),
                        Text('Cadastrar novo link'),
                      ],
                    ),
                    onPressed: () {
                      showOffScreen(
                        dialog: LinkDialog(viewModel: viewModel),
                        isPortrait: isPortrait,
                        context: context,
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: Divider(
                      thickness: 2,
                      color: AppColors.zinc[900],
                    ),
                  ),
                  Text(
                    'Convidados',
                    style: TextTheme.of(context).titleMedium,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: viewModel.trip.guests.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 24),
                      itemBuilder: (context, i) {
                        final guest = viewModel.trip.guests[i];
                        return GuestTile(guest: guest);
                      },
                    ),
                  ),
                  ElevatedButton(
                    style: AppTheme.secondaryButtonStyle,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.settings),
                        SizedBox(width: 8),
                        Text('Gerenciar convidados'),
                      ],
                    ),
                    onPressed: () {
                      showOffScreen(
                        dialog: DetailsGuestsDialog(
                          viewModel: viewModel,
                          localizations: localizations,
                        ),
                        isPortrait: isPortrait,
                        context: context,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget get linksList {
    if (viewModel.trip.links.isEmpty) {
      return const Text('Nenhum link foi adicionando ainda');
    }
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: viewModel.trip.links.length,
      separatorBuilder: (_, __) => const SizedBox(height: 24),
      itemBuilder: (context, i) {
        final link = viewModel.trip.links[i];
        return LinkTile(
          link: link,
        );
      },
    );
  }
}
