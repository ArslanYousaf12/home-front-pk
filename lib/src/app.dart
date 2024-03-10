import 'package:flutter/material.dart';
import 'package:home_front_pk/src/localization/string_hardcoded.dart';
import 'package:home_front_pk/src/routing/app_router.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      restorationScopeId: 'app',
      routerConfig: goRouter,
      onGenerateTitle: (context) => 'Home Front Pk'.hardcoded,
      theme: ThemeData(
          useMaterial3: true,
          primarySwatch: Colors.green,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.black87,
            foregroundColor: Colors.white,
            elevation: 0,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.green,
          ))),
    );
  }
}
