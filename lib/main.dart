import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:logging/logging.dart';
import 'package:planner_app/config/dependencies.dart';
import 'package:planner_app/data/service/local/local_service.dart';
import 'package:planner_app/router/router.dart';
import 'package:planner_app/ui/core/localization/app_localization.dart';
import 'package:provider/provider.dart';

import 'ui/core/theme/app_theme.dart';
import 'ui/core/ui/custom_scroll_behavior.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  Logger.root.level = Level.ALL;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const MainApp(),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: Builder(builder: (context) {
        context.read<LocalService>().tripId.addListener(() => router.refresh());

        return MaterialApp.router(
          title: 'Plann.er',
          theme: AppTheme.appTheme,
          debugShowCheckedModeBanner: false,
          locale: const Locale("pt"),
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
          routerConfig: router,
        );
      }),
    );
  }
}
