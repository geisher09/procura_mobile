import 'package:flutter/material.dart';

class HomeApproval extends StatelessWidget {
  String _title;
  HomeApproval(this._title);
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Center(
        child:  new Text(_title, style: new TextStyle(
            fontSize: 45.0,
            color: Colors.red
        ),),
      ),
    );
  }
}