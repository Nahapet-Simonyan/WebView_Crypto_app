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
        return macos;
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
    apiKey: 'AIzaSyCtK2SKJyYYfP_UjX7KUpq4c95bFjau13A',
    appId: '1:557489775699:web:e232742e713fdaa55f92a6',
    messagingSenderId: '557489775699',
    projectId: 'brakek-crypto',
    authDomain: 'brakek-crypto.firebaseapp.com',
    storageBucket: 'brakek-crypto.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB-Zcc4HXvoitre3joloxmh0qD8vYD2OZM',
    appId: '1:557489775699:android:2c878695a15a95435f92a6',
    messagingSenderId: '557489775699',
    projectId: 'brakek-crypto',
    storageBucket: 'brakek-crypto.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAl4wMUHXBIwLZ8ffdH6tMavM9cDcKv60U',
    appId: '1:557489775699:ios:e40d6f9030a5e0795f92a6',
    messagingSenderId: '557489775699',
    projectId: 'brakek-crypto',
    storageBucket: 'brakek-crypto.appspot.com',
    iosBundleId: 'com.sou.bin7r4decl',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAl4wMUHXBIwLZ8ffdH6tMavM9cDcKv60U',
    appId: '1:557489775699:ios:c3ecbde542318e215f92a6',
    messagingSenderId: '557489775699',
    projectId: 'brakek-crypto',
    storageBucket: 'brakek-crypto.appspot.com',
    iosBundleId: 'com.sou.bin7r4decl.RunnerTests',
  );
}