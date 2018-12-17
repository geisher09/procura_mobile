import 'package:flutter/material.dart';

class HomeNotifs extends StatelessWidget {
  String _title;
  HomeNotifs(this._title);
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Center(
        child:  new Text(_title, style: new TextStyle(
            fontSize: 45.0,
            color: Colors.green
        ),),
      ),
    );
  }
}