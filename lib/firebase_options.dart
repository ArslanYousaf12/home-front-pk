// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCRf3Rcu0h-CB3VWP3EtFuuuG8-3dhrR9s',
    appId: '1:610491281004:web:afa60e743c2b4cdd5d3249',
    messagingSenderId: '610491281004',
    projectId: 'easy-build-ehtasham',
    authDomain: 'easy-build-ehtasham.firebaseapp.com',
    storageBucket: 'easy-build-ehtasham.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB9G1GGTdPTsJw04dgb7k4LUMkF13IdcKo',
    appId: '1:610491281004:android:8ebcefaa34e75ecc5d3249',
    messagingSenderId: '610491281004',
    projectId: 'easy-build-ehtasham',
    storageBucket: 'easy-build-ehtasham.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBETcWsDQ7sgSE8XV1_Yq930KQbB_DxeQ8',
    appId: '1:610491281004:ios:2db4287699bafdaa5d3249',
    messagingSenderId: '610491281004',
    projectId: 'easy-build-ehtasham',
    storageBucket: 'easy-build-ehtasham.appspot.com',
    iosBundleId: 'com.example.homeFrontPk',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBETcWsDQ7sgSE8XV1_Yq930KQbB_DxeQ8',
    appId: '1:610491281004:ios:2db4287699bafdaa5d3249',
    messagingSenderId: '610491281004',
    projectId: 'easy-build-ehtasham',
    storageBucket: 'easy-build-ehtasham.appspot.com',
    iosBundleId: 'com.example.homeFrontPk',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCRf3Rcu0h-CB3VWP3EtFuuuG8-3dhrR9s',
    appId: '1:610491281004:web:ebdabbec4aa9e4735d3249',
    messagingSenderId: '610491281004',
    projectId: 'easy-build-ehtasham',
    authDomain: 'easy-build-ehtasham.firebaseapp.com',
    storageBucket: 'easy-build-ehtasham.appspot.com',
  );
}
