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

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyASHyGSIhMr-WxwXIKqhSAmkCl0ZsUmxwE',
    appId: '1:362982684603:ios:003fec704b421c1174369e',
    messagingSenderId: '362982684603',
    projectId: 'amicae-app',
    storageBucket: 'amicae-app.firebasestorage.app',
    iosBundleId: 'com.example.amicae',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAsUInaMzQFL5lz6rTwLcFgmnkKM8MrQEU',
    appId: '1:362982684603:web:110c7adcec408b3574369e',
    messagingSenderId: '362982684603',
    projectId: 'amicae-app',
    authDomain: 'amicae-app.firebaseapp.com',
    storageBucket: 'amicae-app.firebasestorage.app',
    measurementId: 'G-TL5Y99Y48P',
  );

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAsUInaMzQFL5lz6rTwLcFgmnkKM8MrQEU',
    appId: '1:362982684603:web:110c7adcec408b3574369e',
    messagingSenderId: '362982684603',
    projectId: 'amicae-app',
    authDomain: 'amicae-app.firebaseapp.com',
    storageBucket: 'amicae-app.firebasestorage.app',
    measurementId: 'G-TL5Y99Y48P',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyASHyGSIhMr-WxwXIKqhSAmkCl0ZsUmxwE',
    appId: '1:362982684603:ios:003fec704b421c1174369e',
    messagingSenderId: '362982684603',
    projectId: 'amicae-app',
    storageBucket: 'amicae-app.firebasestorage.app',
    iosBundleId: 'com.example.amicae',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB9jTRo_Hv9WHkqfbVIGFtTwQfGg1dvn0w',
    appId: '1:362982684603:android:b8cc962b55c9d55374369e',
    messagingSenderId: '362982684603',
    projectId: 'amicae-app',
    storageBucket: 'amicae-app.firebasestorage.app',
  );

}