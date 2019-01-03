import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:flutter_pdf_viewer/flutter_pdf_viewer.dart';

class sampscreen2 extends StatelessWidget {
  final text1, text2, date, time;
  sampscreen2(this.text2, this.text1, this.date, this.time);

  @override
  Widget build(BuildContext context) {
    var conwidth = MediaQuery.of(context).size.width / 1.25;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Theme.of(context).brightness == Brightness.light
              ? Colors.black
              : Colors.white, //change your color here
        ),
        title: Text(
          text2,
          style: new TextStyle(
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.black
                  : Colors.white,
              fontSize: 13.0,
              fontWeight: FontWeight.w400),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
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
                      padding: const EdgeInsets.only(left: 12.0),
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
                          date+', '+time,
                          style: new TextStyle(
                              fontSize: 11.0,
                              fontFamily: 'Montserrat'),
                        )),
                  ],
                ),
              ],
            ),
            //Document file
            RaisedButton(
                child: Text('hehe'),
              onPressed: () => FlutterPdfViewer.loadAsset("assets\files\finals.pdf"),
            ),
            RaisedButton(
              child: Text('hehe2'),
              onPressed: () => OpenFile.open("assets\files\SAMPLE FILE.docx"),
            ),
          ],
        ),
      ),
    );
  }
}
