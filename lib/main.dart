// import 'package:event_connect/screens/login_screen.dart';
import 'package:event_connect/firebase_options.dart';
import 'package:event_connect/splash_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.instance.requestPermission();
  runApp(
   const  MaterialApp(
    debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    ),
  );
}
