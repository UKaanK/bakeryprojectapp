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
    apiKey: 'AIzaSyDbrU7IXxsLj_Uk1c2i9IKY0qnP6bqXNuE',
    appId: '1:635173287001:web:3393a32b626e471d47ed48',
    messagingSenderId: '635173287001',
    projectId: 'test-e8d77',
    authDomain: 'test-e8d77.firebaseapp.com',
    databaseURL: 'https://test-e8d77-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'test-e8d77.appspot.com',
    measurementId: 'G-4EZTS819DN',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAySL6s-13H9DmW5AVBvlDp3FJhD70oWjE',
    appId: '1:635173287001:android:a5483557d345168c47ed48',
    messagingSenderId: '635173287001',
    projectId: 'test-e8d77',
    databaseURL: 'https://test-e8d77-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'test-e8d77.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyACYYDbFVv-Fck4lD_MgRuDBKvDvUV5fRA',
    appId: '1:635173287001:ios:88f0ce66932a5ebe47ed48',
    messagingSenderId: '635173287001',
    projectId: 'test-e8d77',
    databaseURL: 'https://test-e8d77-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'test-e8d77.appspot.com',
    iosBundleId: 'com.example.bakeryprojectapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyACYYDbFVv-Fck4lD_MgRuDBKvDvUV5fRA',
    appId: '1:635173287001:ios:88f0ce66932a5ebe47ed48',
    messagingSenderId: '635173287001',
    projectId: 'test-e8d77',
    databaseURL: 'https://test-e8d77-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'test-e8d77.appspot.com',
    iosBundleId: 'com.example.bakeryprojectapp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDbrU7IXxsLj_Uk1c2i9IKY0qnP6bqXNuE',
    appId: '1:635173287001:web:0e239f8240d9674b47ed48',
    messagingSenderId: '635173287001',
    projectId: 'test-e8d77',
    authDomain: 'test-e8d77.firebaseapp.com',
    databaseURL: 'https://test-e8d77-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'test-e8d77.appspot.com',
    measurementId: 'G-RHB7QPL6WF',
  );
}
