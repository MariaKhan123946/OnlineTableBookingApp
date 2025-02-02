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
    apiKey: 'AIzaSyD4KqJg9-uKtunxuggufaeosFuj41YBUK0',
    appId: '1:1086930634230:web:186890f7fc81b180c533d7',
    messagingSenderId: '1086930634230',
    projectId: 'tablebookingapp-71af4',
    authDomain: 'tablebookingapp-71af4.firebaseapp.com',
    storageBucket: 'tablebookingapp-71af4.appspot.com',
    measurementId: 'G-R9L4SYDTQ1',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCLS7E3XDe6uD9LG2skBW6AisVoX-dXgxs',
    appId: '1:1086930634230:android:b55c3b21673af164c533d7',
    messagingSenderId: '1086930634230',
    projectId: 'tablebookingapp-71af4',
    storageBucket: 'tablebookingapp-71af4.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDRjbYCLB7rYSTQnGCnRutDcHSYipn4r70',
    appId: '1:1086930634230:ios:bbd3702e13540171c533d7',
    messagingSenderId: '1086930634230',
    projectId: 'tablebookingapp-71af4',
    storageBucket: 'tablebookingapp-71af4.appspot.com',
    iosBundleId: 'com.example.ui',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDRjbYCLB7rYSTQnGCnRutDcHSYipn4r70',
    appId: '1:1086930634230:ios:bbd3702e13540171c533d7',
    messagingSenderId: '1086930634230',
    projectId: 'tablebookingapp-71af4',
    storageBucket: 'tablebookingapp-71af4.appspot.com',
    iosBundleId: 'com.example.ui',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyD4KqJg9-uKtunxuggufaeosFuj41YBUK0',
    appId: '1:1086930634230:web:6b1e4f1ea13749b9c533d7',
    messagingSenderId: '1086930634230',
    projectId: 'tablebookingapp-71af4',
    authDomain: 'tablebookingapp-71af4.firebaseapp.com',
    storageBucket: 'tablebookingapp-71af4.appspot.com',
    measurementId: 'G-PRRNSYJPNZ',
  );
}
