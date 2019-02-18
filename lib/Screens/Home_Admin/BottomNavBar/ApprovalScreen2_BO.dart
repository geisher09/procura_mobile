import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_pdf_viewer/flutter_pdf_viewer.dart';
import 'package:procura/Components/custom_icons.dart';
import 'package:http/http.dart' as http;
import 'package:procura/Screens/Home_Admin/BottomNavBar/HomeApproval_BO.dart';
import 'package:url_launcher/url_launcher.dart';

final formatter = new DateFormat.yMMMMd("en_US").add_jm();

class ApprovalScreen2_BO extends StatelessWidget {
  final List list;
  final String host;
  final String title;
  final String requestType;
  final String name;
  final String image;
  final String date;
  final String remarks;
  final String sign;
  final String proposal_file;
  final String proposal_id;
  final String user_id;
  ApprovalScreen2_BO({this.list, this.host, this.title, this.requestType, this.name, this.image, this.date, this.remarks, this.sign,
  this.proposal_file, this.proposal_id, this.user_id});
  String datef(String date) {
    return formatter.format(DateTime.parse(date));
  }
  @override
  Widget build(BuildContext context) {
    TextEditingController remarks = new TextEditingController();
    var conwidth = MediaQuery.of(context).size.width / 1.25;
    var noteswidth = MediaQuery.of(context).size.width / 1.15;
    List splithost = host.split('/');
    String newHost = 'http://${splithost[2]}/Procura/storage/app/';
    void approveBudgetProposal() {
      var url = "$host/approveBP.php";
      http.post(url, body: {
        "id": proposal_id,
        "remarks": remarks.text,
        "is_approved": '1',
        "uid": user_id
      });
    }
    void rejectBudgetProposal() {
      var url = "$host/rejectBP.php";
      http.post(url, body: {
        "id": proposal_id,
        "remarks": remarks.text,
        "is_approved": '0',
        "uid": user_id
      });
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
                          image: new NetworkImage(host + image),
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
                          name,
                          style: new TextStyle(
                              fontSize: 13.5,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w600),
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
                child: GestureDetector(
                  onTap: () {
                    launch('$newHost/$proposal_file');
                  },
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
                              title+'.file',
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
                      onPressed: () => showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return SingleChildScrollView(
                            child: AlertDialog(
                              title: Text(
                                'Reject File',
                                style: TextStyle(
                                    fontFamily: 'Montserrat', fontSize: 13.0),
                                textAlign: TextAlign.center,
                              ),
                              titlePadding: EdgeInsets.only(top: 15.0),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(20.0))),
                              contentPadding:
                              EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                              content: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Text(
                                      'Are you sure you want to reject this file?',
                                      style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontSize: 14.0,
                                          fontStyle: FontStyle.italic),
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
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
                                      controller: remarks,
                                      obscureText: false,
                                      style: const TextStyle(
                                        color: Colors.black,
                                      ),
                                      decoration: new InputDecoration(
                                        icon: Padding(
                                          padding:
                                          const EdgeInsets.only(left: 8.0),
                                          child: new Icon(
                                            CustomIcons.pencil,
                                            color: Colors.black,
                                            size: 15.0,
                                          ),
                                        ),
                                        border: InputBorder.none,
                                        hintText: "Remarks",
                                        hintStyle: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 13.0,
                                            fontWeight: FontWeight.w500),
                                        contentPadding: EdgeInsets.fromLTRB(
                                            10.0, 10.0, 20.0, 10.0),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8.0, bottom: 20.0),
                                    child: Text(
                                      'Provide remarks about why you rejected this file',
                                      style: TextStyle(
                                          fontSize: 12.0,
                                          fontStyle: FontStyle.italic),
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                          "Reject",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Montserrat',
                                              fontWeight: FontWeight.bold),
                                        ),
                                        onPressed: () {
                                          rejectBudgetProposal();
                                          Navigator.of(context).pushNamedAndRemoveUntil('/home',(Route<dynamic> route)=>false);
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
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
                      onPressed: () => showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return SingleChildScrollView(
                            child: AlertDialog(
                              title: Text(
                                'Approve File',
                                style: TextStyle(
                                    fontFamily: 'Montserrat', fontSize: 13.0),
                                textAlign: TextAlign.center,
                              ),
                              titlePadding: EdgeInsets.only(top: 15.0),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(20.0))),
                              contentPadding:
                              EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                              content: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Text(
                                      'Are you sure you want to approve this file?',
                                      style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontSize: 14.0,
                                          fontStyle: FontStyle.italic),
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
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
                                      controller: remarks,
                                      obscureText: false,
                                      style: const TextStyle(
                                        color: Colors.black,
                                      ),
                                      decoration: new InputDecoration(
                                        icon: Padding(
                                          padding:
                                          const EdgeInsets.only(left: 8.0),
                                          child: new Icon(
                                            CustomIcons.pencil,
                                            color: Colors.black,
                                            size: 15.0,
                                          ),
                                        ),
                                        border: InputBorder.none,
                                        hintText: "Remarks",
                                        hintStyle: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 13.0,
                                            fontWeight: FontWeight.w500),
                                        contentPadding: EdgeInsets.fromLTRB(
                                            10.0, 10.0, 20.0, 10.0),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8.0, bottom: 20.0),
                                    child: Text(
                                      'Provide remarks about this file',
                                      style: TextStyle(
                                          fontSize: 12.0,
                                          fontStyle: FontStyle.italic),
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                          "Approve",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Montserrat',
                                              fontWeight: FontWeight.bold),
                                        ),
                                        onPressed: () {
                                          approveBudgetProposal();
                                          Navigator.of(context).pushNamedAndRemoveUntil('/home',(Route<dynamic> route)=>false);
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
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
