import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:logging/logging.dart';
import 'package:planner_app/config/dependencies.dart';
import 'package:planner_app/router/router.dart';
import 'package:planner_app/ui/core/localization/app_localization.dart';
import 'package:provider/provider.dart';

import 'ui/core/theme/app_theme.dart';
import 'ui/core/ui/custom_scroll_behavior.dart';

void main() {
  Logger.root.level = Level.ALL;
  runApp(
    MultiProvider(
      providers: providers,
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Plann.er',
      theme: AppTheme.appTheme,
      debugShowCheckedModeBanner: false,
      locale: const Locale("en"),
      supportedLocales: const [
        Locale("pt"),
        Locale("en"),
      ],
      localizationsDelegates: const [
        ...GlobalMaterialLocalizations.delegates,
        GlobalWidgetsLocalizations.delegate,
        AppLocalizationDelegate(),
      ],
      scrollBehavior: CustomScrollBehavior(),
      routerConfig: router(),
    );
  }
}
