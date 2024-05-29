import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter/material.dart';
import 'package:home_front_pk/src/app.dart';
import 'package:home_front_pk/src/exceptions/async_error_logger.dart';
import 'package:home_front_pk/src/localization/string_hardcoded.dart';

void main() {
  //ensure flutter SDK is ready for widget rendering
  WidgetsFlutterBinding.ensureInitialized();
  registerErroHandler();

  runApp(ProviderScope(observers: [
    AsyncErrorLogger(),
  ], child: MyApp()));
}

void registerErroHandler() {
  // * Show some error UI if any uncaught exception happens
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    debugPrint(details.toString());
  };
  // * Handle errors from the underlying platform/OS
  PlatformDispatcher.instance.onError = (exception, stackTrace) {
    debugPrint(exception.toString());
    return true;
  };
  // * Show some error UI when any widget in the app fails to build
  ErrorWidget.builder = (details) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Errro Occured'.hardcoded),
      ),
      body: Center(
        child: Text(details.toString()),
      ),
    );
  };
}
