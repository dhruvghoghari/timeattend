// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyBNQ_hEZ0EziRR-xkXSYb8s_8naW_jO-u0',
    appId: '1:470228803276:web:32b7da1ffa909428b3ac69',
    messagingSenderId: '470228803276',
    projectId: 'timeattend-9f4bb',
    authDomain: 'timeattend-9f4bb.firebaseapp.com',
    storageBucket: 'timeattend-9f4bb.appspot.com',
    measurementId: 'G-JX96BJQSGX',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyADeK0omNiUaPu88xp1mEocHIy2WnMlRk0',
    appId: '1:470228803276:android:8de93a4d165d7820b3ac69',
    messagingSenderId: '470228803276',
    projectId: 'timeattend-9f4bb',
    storageBucket: 'timeattend-9f4bb.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBmKm-Iqd4w0-jTw0o46vEKufows_qI7b0',
    appId: '1:470228803276:ios:d3a364c80061292fb3ac69',
    messagingSenderId: '470228803276',
    projectId: 'timeattend-9f4bb',
    storageBucket: 'timeattend-9f4bb.appspot.com',
    iosBundleId: 'com.example.timeattend',
  );
}
