import 'package:flutter/material.dart';
import 'package:planner_app/ui/core/localization/app_localization.dart';
import 'package:planner_app/ui/home/viewmodel/activities_viewmodel.dart';
import 'package:planner_app/ui/home/viewmodel/details_viewmodel.dart';
import 'package:planner_app/ui/home/viewmodel/home_viewmodel.dart';
import 'package:planner_app/ui/home/widgets/activities/activities_screen.dart';
import 'package:planner_app/ui/home/widgets/bottom_bar.dart';
import 'package:planner_app/ui/home/widgets/details/details_screen.dart';
import 'package:planner_app/ui/home/widgets/top_bar.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
    required this.viewModel,
    required this.localizations,
  });

  final HomeViewModel viewModel;
  final AppLocalization localizations;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: Listenable.merge([
        viewModel,
        viewModel.load,
      ]),
      builder: (context, _) {
        return LayoutBuilder(
          builder: (context, constraints) {
            final isPortrait = constraints.maxWidth >= 780;

            if (viewModel.load.running) {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }

            if (viewModel.load.error) {
              return Scaffold(
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Erro ao carregar dados',
                        style: TextTheme.of(context).titleLarge,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: viewModel.load.execute,
                        child: const Text('Tentar novamente'),
                      ),
                    ],
                  ),
                ),
              );
            }

            return Scaffold(
              body: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 1100,
                  ),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: TopBar(
                              viewModel: viewModel,
                              isPortrait: isPortrait,
                            ),
                          ),
                          Expanded(
                            child: bodyWidget(
                              isPortrait,
                              context,
                            ),
                          ),
                          isPortrait
                              ? Container()
                              : const SizedBox(
                                  height: 80,
                                ),
                        ],
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: bottomBar(isPortrait),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget bottomBar(bool isPortrait) {
    if (isPortrait) {
      return Container();
    }
    return BottomBar(
      viewModel: viewModel,
    );
  }

  Widget bodyWidget(bool isPortrait, BuildContext context) {
    final activities = ActivitiesScreen(
      viewModel: ActivitiesViewModel(
        activitiesRepository: context.read(),
        trip: viewModel.trip!,
      ),
      localizations: localizations,
      isPortrait: isPortrait,
    );

    final details = DetailsScreen(
      viewModel: DetailsViewModel(
        guestsRepository: context.read(),
        linksRepository: context.read(),
        trip: viewModel.trip!,
      ),
      localizations: localizations,
      isPortrait: isPortrait,
    );

    if (isPortrait) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: activities,
          ),
          const SizedBox(
            width: 64,
          ),
          details,
        ],
      );
    }
    if (viewModel.isActivities) {
      return activities;
    }
    return details;
  }
}
