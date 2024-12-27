import 'package:flutter/material.dart';
import 'package:planner_app/ui/core/localization/app_localization.dart';
import 'package:planner_app/ui/home/viewmodel/activities_viewmodel.dart';
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
            final isPortrait = constraints.maxWidth >= 720;

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
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 800,
                    ),
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TopBar(
                              viewModel: viewModel,
                              isPortrait: isPortrait,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Expanded(
                              child: bodyWidget(
                                isPortrait,
                                context,
                              ),
                            ),
                            const SizedBox(
                              height: 78,
                            ),
                          ],
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: bottomBar(isPortrait),
                        ),
                      ],
                    ),
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
    final ActivitiesViewModel activitiesViewModel = ActivitiesViewModel(
      activitiesRepository: context.read(),
      trip: viewModel.trip!,
    );

    if (isPortrait) {
      return Row(
        children: [
          Expanded(
            child: ActivitiesScreen(
              viewModel: activitiesViewModel,
              localizations: localizations,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          const DetailsScreen(),
        ],
      );
    }
    if (viewModel.isActivities) {
      return ActivitiesScreen(
        viewModel: activitiesViewModel,
        localizations: localizations,
      );
    }
    return const DetailsScreen();
  }
}
