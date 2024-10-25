// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kurs1/pages/loginpage.dart';
import 'package:kurs1/util/colors.dart' as col;

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final birthdayController = TextEditingController();

  bool passwordIsVisible = false;

  Future<void> selectBirthday() async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2100));

    if (picked != null) {
      birthdayController.text = picked.toString().split(" ")[0];
    }
  }

  void signUserIn() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim());
    Navigator.pop(context);
  }

  Future signUserUp() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    addUserDetails(
        emailController.text.trim(),
        usernameController.text.trim(),
        firstnameController.text.trim(),
        lastnameController.text.trim(),
        birthdayController.text.trim());

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());

      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);

      registerErrorMessage(e);
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  Future addUserDetails(String email, String username, String firstName,
      String lastName, String birthday) async {
    await FirebaseFirestore.instance.collection('users').add({
      'email': email,
      'first name': firstName,
      'lastname': lastName,
      'birthday': birthday
    });
  }

  void registerErrorMessage(FirebaseAuthException e) {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'There is an error, check your details!',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: col.Colors.backgroundColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  const Icon(
                    Icons.waving_hand_outlined,
                    size: 100,
                  ),
                  const SizedBox(height: 50),
                  const Text(
                    'Hello there!',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                  const Text(
                    'Register below with your details',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  const SizedBox(height: 50),
                  TextField(
                    controller: emailController,
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
                    //obscureText: passwordIsVisible ? false : true,
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
                  const SizedBox(height: 10),
                  TextField(
                    controller: usernameController,
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
                        hintText: 'Username'),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: firstnameController,
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
                        hintText: 'First name'),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: lastnameController,
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
                        hintText: 'Last name'),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: birthdayController,
                    readOnly: true,
                    onTap: () {
                      selectBirthday();
                    },
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
                        hintText: 'Birthday'),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      signUserUp();
                    },
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                          color: col.Colors.accentColor,
                          border: Border.all(width: 0),
                          borderRadius: BorderRadius.circular(10)),
                      child: const Center(
                          child: Text('Sign Up',
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
                        'Already a member? ',
                        style: TextStyle(
                            color: col.Colors.textColorReverseBold,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()),
                        ),
                        child: const Text(
                          'Login now!',
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
