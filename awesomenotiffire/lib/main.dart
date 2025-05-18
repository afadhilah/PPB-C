import 'package:flutter/material.dart';
import 'package:flutter_application_3/screens/home_screen.dart';
import 'package:flutter_application_3/services/notification_service.dart';

import 'firebase_options.dart'; // dari flutterfire configure
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await NotificationService.initializeNotification();

  FirebaseMessaging.onBackgroundMessage(
    NotificationService.firebaseMessagingBackgroundHandler,
  );

  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notification Demo',
      routes: {
        'home': (context) => const HomeScreen(),
      },
      initialRoute: 'home',
      navigatorKey: navigatorKey,
    );
  }
}