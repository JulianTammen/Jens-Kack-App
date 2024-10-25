// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields, prefer_const_constructors_in_immutables, unused_field

import 'package:flutter/material.dart';
import 'package:kurs1/pages/edit_profilepage.dart';
import 'dart:io';
import 'package:kurs1/util/colors.dart' as col;
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _selectedImage;
  double? _imageHeight;
  double? _imageWidth;

  final user = FirebaseAuth.instance.currentUser;
  

  @override
  void initState() {
    super.initState();
  }

  void signUserOut() async {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: col.Colors.backgroundColor,
        appBar: AppBar(
          backgroundColor: col.Colors.accentColor,
          actions: [
            IconButton(
                onPressed: signUserOut,
                icon: Icon(
                  Icons.logout,
                  color: col.Colors.textColor,
                ))
          ],
          leading: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.menu,
                color: col.Colors.textColor,
              )),
          title: Center(
            child: Text(
              "Profile",
              style: TextStyle(
                  color: col.Colors.textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
            ),
          ),
        ),
        body: ListView.separated(
            itemBuilder: (context, index) {
              if (index == 0) {
                return Stack(children: [
                  Container(
                    height: 235.0,
                    color: col.Colors.primaryColor,
                  ),
                  //users[0]['pfpPath'] != null
                  //    ? Padding(
                  //        padding: const EdgeInsets.only(left: 20, top: 20),
                  //        child: ClipOval(
                  //            child: Image.file(File(users[0]['pfpPath']),
                  //                height: 100.0,
                  //                width: 100.0,
                  //                fit: BoxFit.fitWidth)),
                  //      )
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 20),
                    child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: col.Colors.secondaryColor),
                        child: Center(
                          child: Text(
                            "MM",
                            style: TextStyle(
                                fontSize: 40, color: col.Colors.textColor),
                          ),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 355, top: 10),
                    child: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Edit_ProfilePage()),
                          ).then((_) {});
                        },
                        icon: Icon(
                          Icons.edit,
                          size: 30,
                          color: col.Colors.textColorReverse,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 130, left: 20),
                    child: Text(
                      user!.email!,
                      style: TextStyle(
                          fontSize: 23, color: col.Colors.textColorReverseBold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 165, left: 20),
                    child: Text(
                      "Private User",
                      style: TextStyle(
                          fontSize: 20, color: col.Colors.textColorReverse),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 190, left: 20),
                    child: Text(
                      "Active since: 01.01.24",
                      style: TextStyle(
                          fontSize: 20, color: col.Colors.textColorReverse),
                    ),
                  ),
                ]);
              } else if (index == 1) {
                return Center(
                  child: Text(
                    "My Courses",
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                );
              } else {
                return Center(
                  child: Container(
                    height: 250,
                    width: 395,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: col.Colors.primaryColor,
                    ),
                    child: Stack(children: [
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Container(
                          height: 250,
                          width: 175,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: col.Colors.secondaryColor,
                          ),
                        ),
                      ),
                    ]),
                  ),
                );
              }
            },
            separatorBuilder: (context, index) {
              return SizedBox(height: 10);
            },
            itemCount: 7));
  }
}
