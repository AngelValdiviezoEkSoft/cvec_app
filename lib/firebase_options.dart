import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError('FirebaseOptions no configurado para Web');
    } else if (defaultTargetPlatform == TargetPlatform.android) {
      return const FirebaseOptions(
        apiKey: 'AIzaSyDX0nFfBmGDBjzZse69rnRvVxVrEFiQNfk',
        appId: '1:359168005356:android:5d144ce77615f66a8bc1c9',
        messagingSenderId: '359168005356',
        projectId: 'notifications-cve-clients-test',
        storageBucket: 'notifications-cve-clients-test.firebasestorage.app',
      );
    } else if (defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.macOS) {
      throw UnsupportedError('FirebaseOptions no configurado para iOS/macOS');
    } else {
      throw UnsupportedError(
        'DefaultFirebaseOptions no está configurado para esta plataforma.',
      );
    }
  }
}
