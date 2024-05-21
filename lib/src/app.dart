import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home_front_pk/src/localization/string_hardcoded.dart';
import 'package:home_front_pk/src/routing/app_router.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final goRouter = ref.watch(goRouterProvider);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      restorationScopeId: 'app',
      routerConfig: goRouter,
      onGenerateTitle: (context) => 'Home Front Pk'.hardcoded,
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.green,
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFFF6F7C4),
          foregroundColor: Color(0xFF182430),
          elevation: 0,
        ),
        scaffoldBackgroundColor: const Color(0xFF182430),
        // elevatedButtonTheme: ElevatedButtonThemeData(
        //   style: ElevatedButton.styleFrom(
        //     backgroundColor: Colors.white,
        //     foregroundColor: Colors.green,
        //   ),
        // ),
        textTheme: ThemeData().textTheme.apply(
              displayColor: Colors.white,
              bodyColor: Colors.white,
            ),
      ),
    );
  }
}
