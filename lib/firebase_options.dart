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
    apiKey: 'AIzaSyCJBPZzwl_xj8knq-pdVnb-mD66ekuIQDg',
    appId: '1:330765395006:web:cf97072eefc2b0c9775d6f',
    messagingSenderId: '330765395006',
    projectId: 'furry-friend-2121b',
    authDomain: 'furry-friend-2121b.firebaseapp.com',
    storageBucket: 'furry-friend-2121b.firebasestorage.app',
    measurementId: 'G-1142Z5VXMQ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCmy3_91OT4mOdtyqZVqJ_Aw1tKE6TB5nk',
    appId: '1:330765395006:android:3aee24f7c9befff6775d6f',
    messagingSenderId: '330765395006',
    projectId: 'furry-friend-2121b',
    storageBucket: 'furry-friend-2121b.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAdDiN7h2qhrGG9OwHEyoxuw--wkSV51ro',
    appId: '1:330765395006:ios:e2dd79943f843492775d6f',
    messagingSenderId: '330765395006',
    projectId: 'furry-friend-2121b',
    storageBucket: 'furry-friend-2121b.firebasestorage.app',
    iosBundleId: 'com.example.furryFriend',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAdDiN7h2qhrGG9OwHEyoxuw--wkSV51ro',
    appId: '1:330765395006:ios:e2dd79943f843492775d6f',
    messagingSenderId: '330765395006',
    projectId: 'furry-friend-2121b',
    storageBucket: 'furry-friend-2121b.firebasestorage.app',
    iosBundleId: 'com.example.furryFriend',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCJBPZzwl_xj8knq-pdVnb-mD66ekuIQDg',
    appId: '1:330765395006:web:49126bb5ec10aeec775d6f',
    messagingSenderId: '330765395006',
    projectId: 'furry-friend-2121b',
    authDomain: 'furry-friend-2121b.firebaseapp.com',
    storageBucket: 'furry-friend-2121b.firebasestorage.app',
    measurementId: 'G-ZJ6SMD9DHJ',
  );
}
