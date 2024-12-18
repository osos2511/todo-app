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
    apiKey: 'AIzaSyBHQxmSldA8XgJsDHZr1Ru6Ukfo5wZfNwQ',
    appId: '1:370699792938:web:2b8b5c517bf971614d4953',
    messagingSenderId: '370699792938',
    projectId: 'todo-app-2cf5f',
    authDomain: 'todo-app-2cf5f.firebaseapp.com',
    storageBucket: 'todo-app-2cf5f.appspot.com',
    measurementId: 'G-X651TMZKHP',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBWWgcdZ82v5gLJiXQRhsNmPFrMxWHepC4',
    appId: '1:370699792938:android:67cf93718d10f2864d4953',
    messagingSenderId: '370699792938',
    projectId: 'todo-app-2cf5f',
    storageBucket: 'todo-app-2cf5f.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCwP0ehulPj6c6Gyi36bpRt1BvOkUe8HnQ',
    appId: '1:370699792938:ios:dfb5e0a8ab5e1aee4d4953',
    messagingSenderId: '370699792938',
    projectId: 'todo-app-2cf5f',
    storageBucket: 'todo-app-2cf5f.appspot.com',
    iosBundleId: 'com.example.todoApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCwP0ehulPj6c6Gyi36bpRt1BvOkUe8HnQ',
    appId: '1:370699792938:ios:dfb5e0a8ab5e1aee4d4953',
    messagingSenderId: '370699792938',
    projectId: 'todo-app-2cf5f',
    storageBucket: 'todo-app-2cf5f.appspot.com',
    iosBundleId: 'com.example.todoApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBHQxmSldA8XgJsDHZr1Ru6Ukfo5wZfNwQ',
    appId: '1:370699792938:web:ef398efcf576b8664d4953',
    messagingSenderId: '370699792938',
    projectId: 'todo-app-2cf5f',
    authDomain: 'todo-app-2cf5f.firebaseapp.com',
    storageBucket: 'todo-app-2cf5f.appspot.com',
    measurementId: 'G-HDLQ5RS8TD',
  );
}
