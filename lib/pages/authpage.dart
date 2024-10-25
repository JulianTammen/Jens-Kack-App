import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kurs1/pages/loginpage.dart';
import 'package:kurs1/pages/startpage.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData){
              print('uwu');
              return StartPage();
            }
            else{ 
              print('owo');
              return const LoginPage();
            }
          }),
    );
  }
}
