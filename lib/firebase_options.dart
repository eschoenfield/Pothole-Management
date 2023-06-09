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
    apiKey: 'AIzaSyAUVeZIz0YVfUGYVX90Zq79YMV-Ey0I08c',
    appId: '1:1098731538923:web:44c3dff5ac3af585e4f1ae',
    messagingSenderId: '1098731538923',
    projectId: 'potholemanagement-396d0',
    authDomain: 'potholemanagement-396d0.firebaseapp.com',
    storageBucket: 'potholemanagement-396d0.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAFm-rWunD7dY4GsSvm00_mYkYsnOEq94Q',
    appId: '1:1098731538923:android:0adf947cc79ad791e4f1ae',
    messagingSenderId: '1098731538923',
    projectId: 'potholemanagement-396d0',
    storageBucket: 'potholemanagement-396d0.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBTRKiNzFYsbp8BTif7DYMmQmsjmQGbqHk',
    appId: '1:1098731538923:ios:f744b4f02216deb4e4f1ae',
    messagingSenderId: '1098731538923',
    projectId: 'potholemanagement-396d0',
    storageBucket: 'potholemanagement-396d0.appspot.com',
  );
}
