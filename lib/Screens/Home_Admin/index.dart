import 'package:flutter/material.dart';

class Home_AdminScreen extends StatefulWidget {
  @override
  _Home_AdminScreenState createState() => _Home_AdminScreenState();
}

class _Home_AdminScreenState extends State<Home_AdminScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Home Sample hihi')
      ),
      floatingActionButton: new FloatingActionButton(
        backgroundColor: Colors.red,
        child: new Icon(
          Icons.arrow_back_ios
        ),
        elevation: 1.0,
        onPressed: () =>
            Navigator.pushReplacementNamed(context, "/login"),
      ),
    );
  }
}

