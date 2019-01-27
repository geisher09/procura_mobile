//import 'package:flutter/material.dart';
//
//class sampscreen3 extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        iconTheme: IconThemeData(
//          color: Theme.of(context).brightness == Brightness.light? Colors.black:Colors.white,//change your color here
//        ),
//        title: Text("Second Screen for reqs",
//          style: new TextStyle(
//              color: Theme.of(context).brightness == Brightness.light? Colors.black:Colors.white,
//              fontSize: 13.0,
//              fontWeight: FontWeight.w400
//          ),
//        ),
//        elevation: 0.0,
//        backgroundColor:Colors.transparent,
//      ),
//      body: Center(
//        child: RaisedButton(
//          onPressed: () {
//            Navigator.pop(context);
//          },
//          child: Text('Go back!'),
//        ),
//      ),
//    );
//  }
//}

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:open_file/open_file.dart';

class sampscreen3 extends StatefulWidget {
  @override
  _sampscreen3State createState() => new _sampscreen3State();
}

class _sampscreen3State extends State<sampscreen3> {
  String _openResult = 'Unknown';
  @override
  void initState() {
    super.initState();
    openFile("/assets/files/Bernabe1.docx").then((_result){
      setState(() {
        _openResult = _result;
      });
    });
  }

  Future<String> openFile(filePath)async{
    return await OpenFile.open(filePath);
  }

  @override
  Widget build(BuildContext context) {

    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('Plugin example app'),
        ),
        body: new Center(
          child: new GestureDetector(child: new Text('open result: $_openResult\n'),),
        ),
      ),
    );
  }
}