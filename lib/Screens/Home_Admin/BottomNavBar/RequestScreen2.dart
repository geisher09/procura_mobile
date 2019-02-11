import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'package:open_file/open_file.dart';
import 'package:flutter_pdf_viewer/flutter_pdf_viewer.dart';
import 'package:procura/Components/custom_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class RequestScreen2 extends StatelessWidget {
  final text1, text2, text3, date, time;
  RequestScreen2(this.text1, this.text2, this.text3, this.date, this.time);

  Dio dio = Dio();
  @override
  Widget build(BuildContext context) {
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
                  'PR',
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
                          image: new AssetImage("assets/images/user1.png"),
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
                        padding: const EdgeInsets.only(left: 12.0, bottom: 5.0),
                        child: Text(
                          'to '+text3,
                          style: new TextStyle(
                              fontSize: 13.0,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w400),
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
                child: Container(
                  height: 30.0,
                  width: noteswidth,
                  //color: Colors.grey,
                  child: Row(
                    children: <Widget>[
                      Text(
                        'Status: ',
                        style: new TextStyle(
                            fontSize: 14.0, fontFamily: 'Montserrat'),
                      ),
                      Text(
                        'ON-HOLD/',
                        style: new TextStyle(
                            fontSize: 14.0, fontFamily: 'Montserrat',color: Colors.deepOrange, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'APPROVED/',
                        style: new TextStyle(
                            fontSize: 14.0, fontFamily: 'Montserrat',color: Colors.green[700], fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'REJECTED',
                        style: new TextStyle(
                            fontSize: 14.0, fontFamily: 'Montserrat',color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                )
              ),
              Padding(
                padding: const EdgeInsets.only(top:10.0),
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
                  height: MediaQuery.of(context).orientation == Orientation.portrait ?
                  60 : 30,
                  child: RichText(
                    overflow: TextOverflow.ellipsis,
                    maxLines: 4,
                    text: new TextSpan(
                      style: new TextStyle(
                        fontSize: 12.5,
                        //fontFamily: 'Montserrat',
                        color: Theme.of(context).brightness == Brightness.light? Colors.black:Colors.white,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'NOTES:'+' ',
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
//      bottomNavigationBar: BottomAppBar(
//        elevation: 0.0,
//        child: Container(
//          color: Colors.transparent,
//          height: 90.0,
//          child: Column(
//            crossAxisAlignment: CrossAxisAlignment.center,
//            children: <Widget>[
//              Padding(
//                padding: const EdgeInsets.only(top: 10.0),
//                child: Text(
//                  'Approve this file?',
//                  style: new TextStyle(
//                      fontSize: 13.0,
//                      fontFamily: 'Montserrat'),
//                ),
//              ),
//              Padding(
//                padding: const EdgeInsets.all(8.0),
//                child: Row(
//                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                  crossAxisAlignment: CrossAxisAlignment.center,
//                  children: <Widget>[
//                    RaisedButton(
//                      color: Colors.red,
//                      child: Center(
//                        child: Padding(
//                          padding: const EdgeInsets.only(top: 3.0),
//                          child: Icon(
//                            CustomIcons.uniE86E,
//                            size: 20.0,
//                            color: Colors.white,
//                          ),
//                        ),
//                      ),
//                      onPressed: (){},
//                    ),
//                    new Container(
//                      height: 15.0,
//                      width: 1.0,
//                      color: Colors.grey[500],
//                    ),
//                    RaisedButton(
//                      color: Colors.green,
//                      child: Center(
//                        child: Padding(
//                          padding: const EdgeInsets.only(top: 3.0),
//                          child: Icon(
//                            CustomIcons.uniE86D,
//                            size: 20.0,
//                            color: Colors.white,
//                          ),
//                        ),
//                      ),
//                      onPressed: (){},
//                    ),
//                  ],
//                ),
//              ),
//            ],
//          ),
//        ),
//      ),
    );
  }
}
