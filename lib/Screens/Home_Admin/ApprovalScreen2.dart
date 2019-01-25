import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'package:open_file/open_file.dart';
import 'package:flutter_pdf_viewer/main.dart';
import 'package:procura/Components/custom_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class ApprovalScreen2 extends StatelessWidget {
  final text1, text2, date, time;
  ApprovalScreen2(this.text2, this.text1, this.date, this.time);

  Dio dio = Dio();
  @override
  Widget build(BuildContext context) {
    void _approveDialog() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: AlertDialog(
              title: Text(
                'Approve File',
                style: TextStyle(fontFamily: 'Montserrat', fontSize: 13.0),
                textAlign: TextAlign.center,
              ),
              titlePadding: EdgeInsets.only(top: 15.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
              content: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Container(
                      height: 80.0,
                      width: 180.0,
                      child: Image.network(
                          'http://192.168.22.7/Procura/mobile/assets/UserSignatures/signature4.png'),
                    ),
                  ),
                  FractionalTranslation(
                      translation: Offset(0.0, -1.0),
                      child: Divider(
                        color: Colors.grey[600],
                      )),
                  FractionalTranslation(
                    translation: Offset(0.0, -1.5),
                    child: Text(
                      'I hereby agree to digitally sign this file',
                      style:
                          TextStyle(fontFamily: 'Montserrat', fontSize: 12.0),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    decoration: new BoxDecoration(
                      border: new Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                    child: TextFormField(
                      //controller:
                      obscureText: true,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      decoration: new InputDecoration(
                        icon: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: new Icon(
                            CustomIcons.lock,
                            color: Colors.black,
                            size: 15.0,
                          ),
                        ),
                        border: InputBorder.none,
                        hintText: "Password",
                        hintStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 13.0,
                            fontWeight: FontWeight.w500),
                        contentPadding:
                            EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 20.0),
                    child: Text(
                      'Enter password to continue',
                      style: TextStyle(
                          fontSize: 12.0, fontStyle: FontStyle.italic),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new FlatButton(
                        child: new Text(
                          "Cancel",
                          style: TextStyle(
                              color: Colors.teal[700],
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      new FlatButton(
                        color: Colors.teal[700],
                        child: new Text(
                          "Sign",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    }

    void _rejectDialog() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: AlertDialog(
              title: Text(
                'Reject file',
                style: TextStyle(fontFamily: 'Montserrat', fontSize: 13.0),
                textAlign: TextAlign.center,
              ),
              titlePadding: EdgeInsets.all(15.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
              content: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom:10.0),
                    child: Container(
                      height: 80.0,
                      width: 180.0,
                      child: Image.asset(
                          "assets/images/Reject.png"),
                    ),
                  ),
                  Container(
                    decoration: new BoxDecoration(
                      border: new Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                    child: TextFormField(
                      //controller:
                      autocorrect: true,
                      obscureText: false,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      decoration: new InputDecoration(
                        border: InputBorder.none,
                        hintText: "Notes/Comments",
                        hintStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 13.0,
                            fontWeight: FontWeight.w500),
                        contentPadding:
                            EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 20.0),
                    child: Text(
                      'Provide notes on why you rejected this file',
                      style: TextStyle(
                          fontSize: 12.0, fontStyle: FontStyle.italic),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new FlatButton(
                        child: new Text(
                          "Cancel",
                          style: TextStyle(
                              color: Colors.red[900],
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      new FlatButton(
                        color: Colors.red[900],
                        child: new Text(
                          "Done",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    }

    var conwidth = MediaQuery.of(context).size.width / 1.25;
    var noteswidth = MediaQuery.of(context).size.width / 1.15;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Theme.of(context).brightness == Brightness.light
              ? Colors.black
              : Colors.white, //change your color here
        ),
        title: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: Text(
                text2,
                style: new TextStyle(
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.black
                        : Colors.white,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.5),
              ),
            ),
            Container(
              height: 15.0,
              width: 30.0,
              color: Colors.grey[500],
              child: Center(
                child: Text(
                  'PPMP',
                  style: new TextStyle(
                      color: Colors.black,
                      fontSize: 10.0,
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Montserrat'),
                ),
              ),
            )
          ],
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10.0),
          alignment: Alignment.topLeft,
          child: Column(
            children: <Widget>[
              //Pic and Inbox details
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 5.0, 5.0, 5.0),
                    child: Container(
                      decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        image: new DecorationImage(
                          image: new AssetImage("assets/images/user2.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      width: 45.0,
                      height: 45.0,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0, bottom: 5.0),
                        child: Text(
                          text1,
                          style: new TextStyle(
                              fontSize: 13.5,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Text(
                            date + ', ' + time,
                            style: new TextStyle(
                                fontSize: 11.0, fontFamily: 'Montserrat-Thin'),
                          )),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: GestureDetector(
                  onTap: () => PdfViewer.loadAsset("assets/files/finals.pdf"),
                  child: Container(
                      height: 50.0,
                      width: conwidth,
                      decoration: new BoxDecoration(
                        borderRadius: new BorderRadius.circular(8.0),
                        color: Colors.grey[500].withOpacity(0.5),
                      ),
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              'assets/images/logo.png',
                              height: 30.0,
                              width: 30.0,
                            ),
                          ),
                          Text(
                            'FILENAME.pdf',
                            style: new TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.w900,
                                fontFamily: 'Montserrat'),
                          ),
                        ],
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Container(
                  width: noteswidth,
                  height:
                      MediaQuery.of(context).orientation == Orientation.portrait
                          ? 60
                          : 30,
                  child: RichText(
                    overflow: TextOverflow.ellipsis,
                    maxLines: 4,
                    text: new TextSpan(
                      style: new TextStyle(
                        fontSize: 12.5,
                        //fontFamily: 'Montserrat',
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.black
                            : Colors.white,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'NOTES:' + ' ',
                            style: new TextStyle(fontWeight: FontWeight.w700)),
                        TextSpan(
                          text:
                              "Sample text Sample text Sample text Sample text Sample text Sample text Sample text"
                              " Sample text Sample text Limit to 120 chars",
                          style: new TextStyle(fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  ),
                ),
              )
              //Document file
//              RaisedButton(
//                child: Text(text2),
//                onPressed: () => FlutterPdfViewer.loadAsset("assets/files/finals.pdf"),
//              ),
//              RaisedButton(
//                child: Text(text2+'2'),
//                onPressed: () => OpenFile.open("/storage/sdcard1/MyFavorite/Geronima-resume.docx"),
//              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0.0,
        child: Container(
          color: Colors.transparent,
          height: 90.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  'Approve this file?',
                  style:
                      new TextStyle(fontSize: 13.0, fontFamily: 'Montserrat'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      color: Colors.red,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 3.0),
                          child: Icon(
                            CustomIcons.uniE86E,
                            size: 20.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      onPressed: _rejectDialog,
                    ),
                    new Container(
                      height: 15.0,
                      width: 1.0,
                      color: Colors.grey[500],
                    ),
                    RaisedButton(
                      color: Colors.green,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 3.0),
                          child: Icon(
                            CustomIcons.uniE86D,
                            size: 20.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      onPressed: _approveDialog,
                      //onPressed: () => launch("http://docs.google.com/gview?embedded=true&url=/assets/files/finals.pdf"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
