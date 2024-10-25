// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';

class FavouritesPage extends StatefulWidget {
  FavouritesPage({super.key});

  @override
  State<FavouritesPage> createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[400],
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.arrow_forward),
            color: Colors.deepPurple[400],
          )
        ],
        title: Center(
          child: Text(
            "My Favourites",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
          ),
        ),
      ),
      body: ListView.separated(
          shrinkWrap: true,
          itemCount: 10,
          padding: EdgeInsets.only(left: 10, right: 10, top: 10),
          itemBuilder: (context, index) {
            return Center(
              child: Container(
                height: 250,
                width: 395,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[350],
                ),
                child: Stack(children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                        height: 250,
                        width: 175,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[400],
                        )),
                  ),
                ]),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(height: 10);
          }),
    );
  }
}
