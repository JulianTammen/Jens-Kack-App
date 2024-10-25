// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields

//import 'package:flutter/foundation.dart';
// ignore: unused_import
import 'dart:io';
// ignore: unused_import
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kurs1/pages/authpage.dart';
import 'package:kurs1/pages/edit_profilepage.dart';
import 'package:kurs1/pages/favourites.dart';
import 'package:kurs1/pages/homepage.dart';
import 'package:kurs1/pages/loginpage.dart';
import 'package:kurs1/pages/profilepage.dart';
import 'package:kurs1/pages/registerpage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/homepage': (context) => HomePage(),
        '/favouritespage': (context) => FavouritesPage(),
        '/profilepage': (context) => ProfilePage(),
        '/edit_profilepage': (context) => Edit_ProfilePage(),
        '/loginpage': (context) => LoginPage(),
        '/registerpage': (context) => RegisterPage(),
      },
      home: AuthPage(),
    );
  }
}
