// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields, prefer_const_constructors_in_immutables, camel_case_types, no_leading_underscores_for_local_identifiers, avoid_print, unused_local_variable

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image/image.dart' as img;

class Edit_ProfilePage extends StatefulWidget {
  Edit_ProfilePage({super.key});

  @override
  State<Edit_ProfilePage> createState() => _Edit_ProfilePageState();
}

class _Edit_ProfilePageState extends State<Edit_ProfilePage> {
  @override
  void initState() {
    super.initState();
  }

  final _nameController = TextEditingController();
  final _dateController = TextEditingController();
  final _sexController = TextEditingController();

  File? _selectedImage;

  double? _imageWidth;
  double? _imageHeight;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple[400],
          title: Center(
            child: Text(
              "Edit Profile",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
            ),
          ),
          leading: IconButton(
            icon: (Icon(
              Icons.close,
              color: Colors.white,
            )),
            onPressed: () {
              setState(() {
                Navigator.pop(context);
              });
            },
          ),
          actions: [
            IconButton(
              icon: (Icon(
                Icons.save,
                color: Colors.white,
              )),
              onPressed: () {
                setState(() {});
              },
            ),
          ],
        ),
        body: ListView(
          padding: EdgeInsets.all(10),
          children: [
            Row(
              children: [
                Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.grey[400]),
                    child: Center(
                      child: Text(
                        "MM",
                        style: TextStyle(fontSize: 40, color: Colors.white),
                      ),
                    )),
                SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    _pickImageFromGallery();
                  },
                  child: Container(
                    height: 40,
                    width: 160,
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.add,
                        ),
                        Text("Add Profile Picture"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Name",
                labelText: "Name",
                prefixIcon: Icon(Icons.person),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _dateController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Birthday",
                labelText: "Birthday",
                prefixIcon: Icon(Icons.cake),
              ),
              readOnly: true,
              onTap: () {
                _selectDate();
              },
            ),
            SizedBox(height: 10),
            TextField(
              controller: _sexController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: "Sex"),
            ),
          ],
        ));
  }

  Future<void> _selectDate() async {
    DateTime? _picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2100));

    if (_picked != null) {
      _dateController.text = _picked.toString().split(" ")[0];
    }
  }

  Future<void> _getImageDimensions(File? imageFile) async {
    if (imageFile != null) {
      final bytes = await imageFile.readAsBytes();

      final img.Image? decodedImage = img.decodeImage(bytes);

      if (decodedImage != null) {
        _imageWidth = decodedImage.width.toDouble();
        _imageHeight = decodedImage.height.toDouble();
        print('Bildbreite: $_imageWidth px');
        print('Bildhöhe: $_imageHeight px');
      } else {
        print('Bild konnte nicht dekodiert werden.');
      }
    } else {
      print('Kein Bild ausgewählt.');
    }
  }

  Future _pickImageFromGallery() async {
    final _returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (_returnedImage == null) return;
    setState(() {
      _selectedImage = File(_returnedImage.path);
    });

    final prefs = await SharedPreferences.getInstance();

    _getImageDimensions(_selectedImage!);
  }

  Future<void> deleteImage() async {
    setState(() {
      _selectedImage = null;
      _imageWidth = null;
      _imageHeight = null;
    });

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('selected_image');
  }
}
