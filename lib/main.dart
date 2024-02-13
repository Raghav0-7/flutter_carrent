
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pract/login/registration.dart';
import 'package:pract/pages/welcome.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid ? await Firebase.initializeApp(
  options:const FirebaseOptions(
      apiKey: 'AIzaSyAl6y-VRGBsrU83oSwBcy_leTgbsQ8mzo8',
      appId: '1:419377329089:android:551f4bfbfc11bd66d9b540',
      messagingSenderId: '419377329089',
      projectId: 'carrent-84e57'))
      : await Firebase.initializeApp();

  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,

      ),
      debugShowCheckedModeBanner: false,
      home:  const Splash(),
    );
  }
}
