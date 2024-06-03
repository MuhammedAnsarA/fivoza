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
    apiKey: 'AIzaSyBmJ_3lwgdbAJNhSv5gEQkUcKkq3hfTia8',
    appId: '1:346939594435:web:94d9054c4db9fd0644f476',
    messagingSenderId: '346939594435',
    projectId: 'fivoza-ba87b',
    authDomain: 'fivoza-ba87b.firebaseapp.com',
    storageBucket: 'fivoza-ba87b.appspot.com',
    measurementId: 'G-P9HTXDRMHE',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB0IBnxMoHpYncSdlvagxgocF3EciDQPfs',
    appId: '1:346939594435:android:73369f2f3730a30844f476',
    messagingSenderId: '346939594435',
    projectId: 'fivoza-ba87b',
    storageBucket: 'fivoza-ba87b.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyArFl2Ea1N1CtFCF9t5uvAbdT-awkzLGxU',
    appId: '1:346939594435:ios:24e0d2aaa4b5425844f476',
    messagingSenderId: '346939594435',
    projectId: 'fivoza-ba87b',
    storageBucket: 'fivoza-ba87b.appspot.com',
    iosBundleId: 'com.example.fivoza',
  );
}