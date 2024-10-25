// ignore_for_file: use_build_context_synchronously, unused_catch_clause

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kurs1/pages/registerpage.dart';
import 'package:kurs1/util/colors.dart' as col;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool passwordIsVisible = false;

  void signUserIn() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());

      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);

      wrongEmailOrPasswordMessage();
    }
  }

  void wrongEmailOrPasswordMessage() {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Incorrect Email or Password',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future showForgotPWSheet(BuildContext context) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        backgroundColor: col.Colors.backgroundColor,
        barrierColor: col.Colors.textColorReverseBold.withOpacity(0.5),
        builder: (context) => Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: SizedBox(
                  height: 300,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Column(
                      children: [
                        const Text(
                          'Enter your Email and we will send you a password reset link',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        const SizedBox(height: 30),
                        TextField(
                          controller: emailController,
                          obscureText: false,
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: col.Colors.textColor)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                      color: col.Colors.textColor)),
                              fillColor: Colors.white,
                              filled: true,
                              hintText: 'Email'),
                        ),
                        const SizedBox(height: 30),
                        GestureDetector(
                          onTap: resetPassword,
                          child: Container(
                            height: 60,
                            decoration: BoxDecoration(
                                color: col.Colors.accentColor,
                                border: Border.all(width: 0),
                                borderRadius: BorderRadius.circular(10)),
                            child: const Center(
                                child: Text('Reset Password',
                                    style: TextStyle(
                                        color: col.Colors.textColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold))),
                          ),
                        ),
                      ],
                    ),
                  )),
            ));
  }

  Future resetPassword() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              content: Text(
                'Password reset link was sent! Check your email',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            );
          });
    } on FirebaseAuthException catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(
                e.message.toString(),
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: col.Colors.backgroundColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const Icon(
                    Icons.lock,
                    size: 100,
                  ),
                  const SizedBox(height: 50),
                  const Text(
                    'Welcome back!',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  const SizedBox(height: 50),
                  TextField(
                    controller: emailController,
                    obscureText: false,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: col.Colors.textColor)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide:
                                const BorderSide(color: col.Colors.textColor)),
                        fillColor: Colors.white,
                        filled: true,
                        hintText: 'Email'),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: passwordController,
                    obscureText: passwordIsVisible ? false : true,
                    decoration: InputDecoration(
                        suffixIcon: passwordIsVisible
                            ? IconButton(
                                icon: const Icon(Icons.visibility),
                                onPressed: () {
                                  setState(() {
                                    passwordIsVisible = false;
                                  });
                                },
                              )
                            : IconButton(
                                icon: const Icon(Icons.visibility_off),
                                onPressed: () {
                                  setState(() {
                                    passwordIsVisible = true;
                                  });
                                },
                              ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: col.Colors.textColor)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide:
                                const BorderSide(color: col.Colors.textColor)),
                        fillColor: Colors.white,
                        filled: true,
                        hintText: 'Password'),
                  ),
                  const SizedBox(height: 7),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () => showForgotPWSheet(context),
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(
                              color: col.Colors.secondAccentColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 7),
                  GestureDetector(
                    onTap: () {
                      signUserIn();
                    },
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                          color: col.Colors.accentColor,
                          border: Border.all(width: 0),
                          borderRadius: BorderRadius.circular(10)),
                      child: const Center(
                          child: Text('Sign In',
                              style: TextStyle(
                                  color: col.Colors.textColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold))),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Not a member? ',
                        style: TextStyle(
                            color: col.Colors.textColorReverseBold,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RegisterPage()),
                        ),
                        child: const Text(
                          'Register now?',
                          style: TextStyle(
                              color: col.Colors.secondAccentColor,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
