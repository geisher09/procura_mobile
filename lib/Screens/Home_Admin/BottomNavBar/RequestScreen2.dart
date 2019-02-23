import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'package:open_file/open_file.dart';
import 'package:flutter_pdf_viewer/flutter_pdf_viewer.dart';
import 'package:procura/Components/custom_icons.dart';
import 'package:procura/Screens/Home_Admin/Drawer/PPMPDetailsPage.dart';
import 'package:procura/Screens/Home_Admin/Drawer/PRDetailsPage.dart';
import 'package:url_launcher/url_launcher.dart';

final formatter = new DateFormat.yMMMMd("en_US").add_jm();

class RequestScreen2 extends StatelessWidget {
  final List listuser;
  final String user_id;
  final String id;
  final String proposal_file;
  final String host;
  final String title;
  final String requestType;
  final String image;
  final String approver;
  final String date;
  final String status;
  final String remarks;
  RequestScreen2(
      {this.listuser,
        this.user_id,
        this.id,
      this.proposal_file,
      this.host,
      this.title,
      this.requestType,
      this.image,
      this.approver,
      this.date,
      this.status,
      this.remarks});
  String datef(String date) {
    return formatter.format(DateTime.parse(date));
  }

  Widget stats() {
    if (status == null) {
      return Text(
        'PENDING',
        style: new TextStyle(
            fontSize: 14.0,
            fontFamily: 'Montserrat',
            color: Colors.yellow[800],
            fontWeight: FontWeight.bold),
      );
    } else if (status == '1') {
      return Text(
        'APPROVED',
        style: new TextStyle(
            fontSize: 14.0,
            fontFamily: 'Montserrat',
            color: Colors.green[700],
            fontWeight: FontWeight.bold),
      );
    } else {
      return Text(
        'REJECTED',
        style: new TextStyle(
            fontSize: 14.0,
            fontFamily: 'Montserrat',
            color: Colors.red[700],
            fontWeight: FontWeight.bold),
      );
    }
  }

  String remarksText(String notes) {
    if (notes == null) {
      return 'No remarks';
    } else {
      return notes;
    }
  }

  @override
  Widget build(BuildContext context) {
    var conwidth = MediaQuery.of(context).size.width / 1.25;
    var noteswidth = MediaQuery.of(context).size.width / 1.15;
    List splithost = host.split('/');
    String newHost = 'http://${splithost[2]}/Procura/storage/app/';
    String newHost2 = 'http://${splithost[2]}/Procura/storage/app/public/';
    void viewer(String reqtype) {
      if (reqtype == 'BP') {
        launch('$newHost/$proposal_file');
      }else if(reqtype == 'PPMP'){
        Navigator.of(context).push(new MaterialPageRoute(
            builder: (BuildContext context) => new PPMPDetailsPage(user_id: user_id,
                listuser: listuser,
                usertype: 'sector',
                title: title,
                host: host,
                id: id)));
      }else if(reqtype == 'PR'){
        Navigator.of(context).push(new MaterialPageRoute(
            builder: (BuildContext context) => new PRDetailsPage(user_id: user_id,
                listuser: listuser,
                usertype: 'sector',
                title: title,
                host: host,
                id: id)));
      }
    }

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
              child: Container(
                width:
                    MediaQuery.of(context).orientation == Orientation.portrait
                        ? MediaQuery.of(context).size.width / 1.8
                        : MediaQuery.of(context).size.width / 1.35,
                child: Text(
                  title,
                  style: new TextStyle(
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.black
                          : Colors.white,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.5),
                  overflow: TextOverflow.fade,
                ),
              ),
            ),
            Container(
              height: 30.0,
              width: 60.0,
              decoration: BoxDecoration(
                borderRadius: new BorderRadius.circular(8.0),
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.grey[850]
                    : Colors.grey[50],
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text(
                    requestType,
                    style: new TextStyle(
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.grey[50]
                            : Colors.grey[850],
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Lulo'),
                  ),
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
                          image: new NetworkImage(newHost2 + image),
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
                          "me",
                          style: new TextStyle(
                              fontSize: 13.5,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0, bottom: 5.0),
                        child: Text(
                          'to ' + approver,
                          style: new TextStyle(
                              fontSize: 13.0,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Text(
                            datef(date),
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
                                fontSize: 15.0,
                                fontFamily: 'Montserrat',
                                letterSpacing: 1.0),
                          ),
                          stats(),
                        ],
                      ))),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: GestureDetector(
                  onTap: () => viewer(requestType),
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
                          Container(
                            width: conwidth / 1.2,
                            height: 20.0,
                            child: Text(
                              title + '.$requestType',
                              overflow: TextOverflow.ellipsis,
                              style: new TextStyle(
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w900,
                                  fontFamily: 'Montserrat'),
                            ),
                          ),
                        ],
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Container(
                  width: noteswidth,
//                  height:
//                      MediaQuery.of(context).orientation == Orientation.portrait
//                          ? 60
//                          : 30,
                  child: RichText(
                    overflow: TextOverflow.ellipsis,
                    maxLines: 20,
                    text: new TextSpan(
                      style: new TextStyle(
                        fontSize: 13.5,
                        //fontFamily: 'Montserrat',
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.black
                            : Colors.white,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'REMARKS:' + ' ',
                            style: new TextStyle(
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.0)),
                        TextSpan(
                          text: remarksText(remarks),
                          style: new TextStyle(
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.italic),
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
