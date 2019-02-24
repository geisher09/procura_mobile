import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:flutter_pdf_viewer/flutter_pdf_viewer.dart';
import 'package:procura/Components/custom_icons.dart';
import 'package:procura/Screens/Home_Admin/Drawer/PPMPDetailsPage.dart';
import 'package:procura/Screens/Home_Admin/Drawer/PRDetailsPage.dart';
import 'package:http/http.dart' as http;

final formatter = new DateFormat.yMMMMd("en_US").add_jm();

class ApprovalScreen2 extends StatefulWidget {
  final String id;
  final List listuser;
  final String user_id;
  final String host;
  final String title;
  final String requestType;
  final String name;
  final String image;
  final String date;
  final String remarks;
  final String sign;
  ApprovalScreen2({this.id,this.listuser, this.user_id, this.host, this.title, this.requestType, this.name, this.image, this.date, this.remarks, this.sign});
  @override
  _ApprovalScreen2State createState() => _ApprovalScreen2State();
}

class _ApprovalScreen2State extends State<ApprovalScreen2> {
  TextEditingController remarks = new TextEditingController();
  String datef(String date) {
    return formatter.format(DateTime.parse(date));
  }
  @override
  Widget build(BuildContext context) {
    List splithost = widget.host.split('/');
    String newHost = 'http://${splithost[2]}/Procura/storage/app/';
    String newHost2 = 'http://${splithost[2]}/Procura/storage/app/public/';


    void approvePR() {
      List splithost = widget.host.split('/');
      var newHost = 'http://${splithost[2]}:8000/mobile/approved_purchase_requests/${widget.id}';
      http.post(newHost, body: {
        "remarks": remarks.text,
      });
    }
    void rejectPR() {
      List splithost = widget.host.split('/');
      var newHost = 'http://${splithost[2]}:8000/mobile/approved_purchase_requests/${widget.id}';
      Dio().delete(newHost, data: {
        "remarks": remarks.text,
      });
    }

    void approvePPMP() {
      List splithost = widget.host.split('/');
      var newHost = 'http://${splithost[2]}:8000/mobile/approved_projects/${widget.id}';
      http.post(newHost, body: {
        "remarks": remarks.text,
      });
    }
    void rejectPPMP() {
      List splithost = widget.host.split('/');
      var newHost = 'http://${splithost[2]}:8000/mobile/approved_projects/${widget.id}';
      Dio().delete(newHost, data: {
        "remarks": remarks.text,
      });
    }


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
                          newHost2 + widget.listuser[0]['user_signature']),
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
                    child: Form(
                      child: TextFormField(
                        controller: remarks,
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
                  ),
                  Container(
                    height: 15.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new FlatButton(
                        child: new Text(
                          "Cancel",
                          style: TextStyle(
                              color: Colors.green[800],
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      new FlatButton(
                        color: Colors.green[800],
                        child: new Text(
                          "Sign",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          widget.requestType == 'PR' ? approvePR() : approvePPMP();
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              '/home', (Route<dynamic> route) => false);
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
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Container(
                      height: 80.0,
                      width: 180.0,
                      child: Image.asset("assets/images/Reject.png"),
                    ),
                  ),
                  Container(
                    decoration: new BoxDecoration(
                      border: new Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                    child: Form(
                      child: TextFormField(
                        controller: remarks,
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
                              color: Colors.red[800],
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      new FlatButton(
                        color: Colors.red[800],
                        child: new Text(
                          "Done",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          widget.requestType == 'PR' ? rejectPR() : rejectPPMP();
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              '/home', (Route<dynamic> route) => false);
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
              child: Container(
                width:
                MediaQuery.of(context).orientation == Orientation.portrait
                    ? MediaQuery.of(context).size.width / 1.8
                    : MediaQuery.of(context).size.width / 1.35,
                child: Text(
                  widget.title,
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
                    widget.requestType,
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
                          image: new NetworkImage(newHost2 + widget.image),
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
                          widget.name,
                          style: new TextStyle(
                              fontSize: 13.5,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Text(
                            datef(widget.date),
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
                  onTap: () =>
                  widget.requestType == 'PR' ? Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) => new PRDetailsPage(user_id: widget.user_id,
                          listuser: widget.listuser,
                          usertype: 'sector',
                          title: widget.title,
                          host: widget.host,
                          id: widget.id))): Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) => new PPMPDetailsPage(user_id: widget.user_id,
                          listuser: widget.listuser,
                          usertype: 'sector',
                          title: widget.title,
                          host: widget.host,
                          id: widget.id))),
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
                            width: conwidth/1.2,
                            height: 20.0,
                            child: Text(
                              widget.title+'.${widget.requestType}',
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
                      color: Colors.red[800],
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
                      color: Colors.green[800],
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

