import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:procura/Components/custom_icons.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class SettingsScreen2 extends StatefulWidget {
  final String host;
  final List list;
  SettingsScreen2({this.host, this.list});
  @override
  _SettingsScreen2State createState() => _SettingsScreen2State();
}

class _SettingsScreen2State extends State<SettingsScreen2> {
  File _image;
  Future getImageGallery() async{
    var imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = imageFile;
    });
  }

  Future getImageCamera() async{
    var imageFile = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = imageFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Theme.of(context).brightness == Brightness.light
              ? Colors.black
              : Colors.white, //change your color here
        ),
        title: Text(
          "Select Options to Update Image",
          style: new TextStyle(
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.black
                  : Colors.white,
              fontSize: 18.0,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.only(top: 15.0, bottom: 10.0),
                child: Center(
                  child: _image == null ? Text('No Image Selected') :
                  Container(
                    decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                        image: FileImage(_image),
                        fit: BoxFit.cover,
                      ),
                    ),
                    width: MediaQuery.of(context).orientation ==
                        Orientation.portrait
                        ? height / 4.0
                        : width / 4.0,
                    height: MediaQuery.of(context).orientation ==
                        Orientation.portrait
                        ? height / 4.0
                        : width / 4.0,
                  ),
                )
            ),
            new RaisedButton(
              color: Colors.indigo[500],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Icon(
                    Icons.image,
                    color: Colors.white,
                  ),
                  Text(
                    "Select from Gallery",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              onPressed: () {
                getImageGallery();
              },
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: new RaisedButton(
                color: Colors.indigo[500],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                    ),
                    Text(
                      "Use Camera",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                onPressed: () {
                  getImageCamera();
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new FlatButton(
                  child: new Text(
                    "Cancel",
                    style: TextStyle(
                        color: Colors.indigo[400],
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                new FlatButton(
                  color: Colors.indigo[500],
                  child: new Text(
                    "Save",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
