import 'package:go_router/go_router.dart';
import 'package:planner_app/data/service/local/local_service.dart';
import 'package:planner_app/ui/home/viewmodel/home_viewmodel.dart';
import 'package:planner_app/ui/home/widgets/home_page.dart';
import 'package:planner_app/ui/register/viewmodel/register_viewmodel.dart';
import 'package:planner_app/ui/register/widgets/register_page.dart';
import 'package:provider/provider.dart';

GoRouter router() => GoRouter(
      debugLogDiagnostics: true,
      redirect: (context, state) async {
        final LocalService localService = context.read();
        final tripId = await localService.getTripId();
        if (tripId != null) {
          return "/trip/$tripId";
        }
        return '/';
      },
      routes: [
        GoRoute(
          path: "/",
          builder: (context, _) => RegisterPage(
            localizations: context.read(),
            viewModel: RegisterViewModel(
              citiesRepository: context.read(),
              tripRepository: context.read(),
            ),
          ),
          routes: [
            GoRoute(
              name: "trip",
              path: "trip/:tid",
              builder: (context, state) => HomePage(
                localizations: context.read(),
                viewModel: HomeViewModel(
                  tripId: state.pathParameters['tid']!,
                  tripRepository: context.read(),
                ),
              ),
            ),
          ],
        ),
      ],
    );
