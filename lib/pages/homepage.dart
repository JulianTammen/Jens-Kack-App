// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool clickedSearch = false;
  TextEditingController myController = TextEditingController();

  var _container = Container(
      height: 200,
      color: Colors.white,
      child: ListView.separated(
        shrinkWrap: true,
        padding: EdgeInsets.only(right: 10, left: 10, top: 10),
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (context, index) {
          return Container(
            width: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[350],
            ),
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(width: 10);
        },
      ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        flexibleSpace: clickedSearch
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 60,
                  ),
                  Container(
                    height: 35,
                    width: 360,
                    padding: EdgeInsets.only(left: 10),
                    child: TextField(
                      controller: myController,
                      autofocus: true,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                      ),
                    ),
                  ),
                ],
              )
            : Center(
                child: Column(
                  children: [
                    Container(
                      height: 60,
                    ),
                    Text(
                      clickedSearch ? "" : "Jens Kack App",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    ),
                  ],
                ),
              ),
        actions: [
          IconButton(
              onPressed: () {
                clickedSearch = false;
                Navigator.pushNamed(context, '/favouritespage');
                setState(() {});
              },
              icon: Icon(
                Icons.favorite,
                color: Colors.white,
              )),
        ],
        leading: IconButton(
            onPressed: () {
              clickedSearch = true;
              setState(() {});
            },
            icon: Icon(Icons.search,
                color: clickedSearch ? Colors.black : Colors.white)),
        backgroundColor: Colors.deepPurple[400],
      ),
      body: ListView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        children: [
          Container(
            padding: EdgeInsets.only(left: 10, top: 10),
            child: Text(
              "Category 1",
              style: TextStyle(
                fontSize: 25,
              ),
            ),
          ),
          _container,
          Container(
            padding: EdgeInsets.only(left: 10, top: 10),
            child: Text(
              "Category 2",
              style: TextStyle(
                fontSize: 25,
              ),
            ),
          ),
          _container,
          Container(
            padding: EdgeInsets.only(left: 10, top: 10),
            child: Text(
              "Category 3",
              style: TextStyle(
                fontSize: 25,
              ),
            ),
          ),
          _container,
          Container(
            padding: EdgeInsets.only(left: 10, top: 10),
            child: Text(
              "Category 4",
              style: TextStyle(
                fontSize: 25,
              ),
            ),
          ),
          _container,
          Container(
            padding: EdgeInsets.only(left: 10, top: 10),
            child: Text(
              "Category 5",
              style: TextStyle(
                fontSize: 25,
              ),
            ),
          ),
          _container,
        ],
      ),
    );
  }
}
