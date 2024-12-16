import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:planner_app/ui/register/viewmodel/register_viewmodel.dart';
import 'package:planner_app/ui/register/widgets/register_page.dart';
import 'package:provider/provider.dart';

GoRouter router() => GoRouter(
      initialLocation: "/",
      debugLogDiagnostics: true,
      routes: [
        GoRoute(
          path: "/",
          builder: (context, _) => RegisterPage(
            viewModel: RegisterViewModel(
              citiesRepository: context.read(),
            ),
          ),
          routes: [
            GoRoute(
              name: "trip",
              path: "trip/:tid",
              builder: (context, state) => Container(),
            ),
          ],
        ),
      ],
    );
