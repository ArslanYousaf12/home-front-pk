import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home_front_pk/firebase_options.dart';
// import 'package:flutter/material.dart';
import 'package:home_front_pk/src/app.dart';
import 'package:home_front_pk/src/exceptions/async_error_logger.dart';
import 'package:home_front_pk/src/localization/string_hardcoded.dart';

Future<void> setupEmulators() async {
  await FirebaseAuth.instance.useAuthEmulator('127.0.0.1', 9099);
  FirebaseFirestore.instance.useFirestoreEmulator('127.0.0.1', 8080);
  await FirebaseStorage.instance.useStorageEmulator('127.0.0.1', 9199);
}

void main() async {
  //ensure flutter SDK is ready for widget rendering

  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // * Setup emulators for local development
  // await setupEmulators();

  FlutterNativeSplash.remove();
  registerErroHandler();

  runApp(ProviderScope(observers: [
    AsyncErrorLogger(),
  ], child: const MyApp()));
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
