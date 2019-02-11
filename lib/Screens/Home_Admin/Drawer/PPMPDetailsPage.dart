import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:procura/Components/custom_icons.dart';

class PPMPDetailsPage extends StatelessWidget {
  final String usertype;
  final String title;
  final String host;
  final String id;

  PPMPDetailsPage({this.usertype, this.title, this.host, this.id});

  @override
  Widget build(BuildContext context) {
    Future<List> getPPMPDetails() async {
      final response = await http
          .post("$host/getPPMPDetails.php", body: {"id": id.toString()});
      print(usertype);
      return json.decode(response.body);
    }

    Widget check(String month) {
      if (month == '0') {
        return Text(' ');
      } else {
        return Icon(
          FontAwesomeIcons.check,
          size: 15.0,
        );
      }
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

    Widget bottombar(String user) {
      if (user == 'sectorpending') {
        return Container(
          color: Colors.transparent,
          height: 90.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  'Approve this file?',
                  style: new TextStyle(
                      fontSize: 13.0, fontFamily: 'Montserrat'),
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
        );
      } else {
        return Container(
          height: 1.0,
          width: 1.0,
        );
      }
    }

    Widget bodyData() => FutureBuilder<List>(
        future: getPPMPDetails(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
          }
          if (snapshot.hasData) {
            rows(list: snapshot.data);
            return DataTable(
                columns: <DataColumn>[
                  DataColumn(
                    label: Text(
                      "CODE",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.blue),
                    ),
                    numeric: false,
                  ),
                  DataColumn(
                    label: Text(
                      "DESCRIPTION",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.blue),
                    ),
                    numeric: false,
                  ),
                  DataColumn(
                    label: Text(
                      "QTY",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.blue),
                    ),
                    numeric: false,
                  ),
                  DataColumn(
                    label: Text(
                      "UNIT PRICE",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.blue),
                    ),
                    numeric: false,
                  ),
                  DataColumn(
                    label: Text(
                      "ESTIMATED BUDGET",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.blue),
                    ),
                    numeric: false,
                  ),
                  DataColumn(
                    label: Text(
                      "MODE OF PROCUREMENT",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.blue),
                    ),
                    numeric: false,
                  ),
                  DataColumn(
                    label: Text(
                      "Jan",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.blue),
                    ),
                    numeric: false,
                  ),
                  DataColumn(
                    label: Text(
                      "Feb",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.blue),
                    ),
                    numeric: false,
                  ),
                  DataColumn(
                    label: Text(
                      "Mar",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.blue),
                    ),
                    numeric: false,
                  ),
                  DataColumn(
                    label: Text(
                      "Apr",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.blue),
                    ),
                    numeric: false,
                  ),
                  DataColumn(
                    label: Text(
                      "May",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.blue),
                    ),
                    numeric: false,
                  ),
                  DataColumn(
                    label: Text(
                      "Jun",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.blue),
                    ),
                    numeric: false,
                  ),
                  DataColumn(
                    label: Text(
                      "Jul",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.blue),
                    ),
                    numeric: false,
                  ),
                  DataColumn(
                    label: Text(
                      "Aug",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.blue),
                    ),
                    numeric: false,
                  ),
                  DataColumn(
                    label: Text(
                      "Sep",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.blue),
                    ),
                    numeric: false,
                  ),
                  DataColumn(
                    label: Text(
                      "Oct",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.blue),
                    ),
                    numeric: false,
                  ),
                  DataColumn(
                    label: Text(
                      "Nov",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.blue),
                    ),
                    numeric: false,
                  ),
                  DataColumn(
                    label: Text(
                      "Dec",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.blue),
                    ),
                    numeric: false,
                  )
                ],
                rows: names
                    .map(
                      (name) => DataRow(
                            cells: [
                              DataCell(
                                Text(name.code),
                                showEditIcon: false,
                                placeholder: false,
                              ),
                              DataCell(
                                Text(name.description),
                                showEditIcon: false,
                                placeholder: false,
                              ),
                              DataCell(
                                Text(name.qty),
                                showEditIcon: false,
                                placeholder: false,
                              ),
                              DataCell(
                                Text(name.unit_cost),
                                showEditIcon: false,
                                placeholder: false,
                              ),
                              DataCell(
                                Text(name.estimated_budget),
                                showEditIcon: false,
                                placeholder: false,
                              ),
                              DataCell(
                                Text(name.procurement_mode),
                                showEditIcon: false,
                                placeholder: false,
                              ),
                              DataCell(
                                check(name.jan),
                                showEditIcon: false,
                                placeholder: false,
                              ),
                              DataCell(
                                check(name.feb),
                                showEditIcon: false,
                                placeholder: false,
                              ),
                              DataCell(
                                check(name.mar),
                                showEditIcon: false,
                                placeholder: false,
                              ),
                              DataCell(
                                check(name.apr),
                                showEditIcon: false,
                                placeholder: false,
                              ),
                              DataCell(
                                check(name.may),
                                showEditIcon: false,
                                placeholder: false,
                              ),
                              DataCell(
                                check(name.jun),
                                showEditIcon: false,
                                placeholder: false,
                              ),
                              DataCell(
                                check(name.jul),
                                showEditIcon: false,
                                placeholder: false,
                              ),
                              DataCell(
                                check(name.aug),
                                showEditIcon: false,
                                placeholder: false,
                              ),
                              DataCell(
                                check(name.sep),
                                showEditIcon: false,
                                placeholder: false,
                              ),
                              DataCell(
                                check(name.oct),
                                showEditIcon: false,
                                placeholder: false,
                              ),
                              DataCell(
                                check(name.nov),
                                showEditIcon: false,
                                placeholder: false,
                              ),
                              DataCell(
                                check(name.dec),
                                showEditIcon: false,
                                placeholder: false,
                              )
                            ],
                          ),
                    )
                    .toList());
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.black
                : Colors.white, //change your color here
          ),
          //centerTitle: true,
          title: Text(
            title,
            style: new TextStyle(
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.black
                  : Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
              letterSpacing: 1.0,
              fontFamily: 'Montserrat',
              fontStyle: FontStyle.italic,
            ),
          ),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            child: Container(
              child: Center(child: Card(child: bodyData())),
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: usertype == 'sectorpending'
              ? Container(
            color: Colors.transparent,
            height: 90.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    'Approve this file?',
                    style: new TextStyle(
                        fontSize: 13.0, fontFamily: 'Montserrat'),
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
          ) : Container(
            width: 1.0,
            height: 1.0,
          )
        ));
  }
}

class Name {
  String code;
  String description;
  String qty;
  String unit_cost;
  String estimated_budget;
  String procurement_mode;
  String jan;
  String feb;
  String mar;
  String apr;
  String may;
  String jun;
  String jul;
  String aug;
  String sep;
  String oct;
  String nov;
  String dec;
  Name(
      {this.code,
      this.description,
      this.qty,
      this.unit_cost,
      this.estimated_budget,
      this.procurement_mode,
      this.jan,
      this.feb,
      this.mar,
      this.apr,
      this.may,
      this.jun,
      this.jul,
      this.aug,
      this.sep,
      this.oct,
      this.nov,
      this.dec});
}

var names = <Name>[];

void rows({List list}) {
  names.clear();
  for (int i = 0; i < list.length; i++) {
    names.add(Name(
        code: list[i]['code'],
        description: list[i]['description'],
        qty: list[i]['qty'],
        unit_cost: list[i]['unit_cost'],
        estimated_budget: list[i]['estimated_budget'],
        procurement_mode: list[i]['procurement_mode'],
        jan: list[i]['0'][0]['id'],
        feb: list[i]['0'][1]['id'],
        mar: list[i]['0'][2]['id'],
        apr: list[i]['0'][3]['id'],
        may: list[i]['0'][4]['id'],
        jun: list[i]['0'][5]['id'],
        jul: list[i]['0'][6]['id'],
        aug: list[i]['0'][7]['id'],
        sep: list[i]['0'][8]['id'],
        oct: list[i]['0'][9]['id'],
        nov: list[i]['0'][10]['id'],
        dec: list[i]['0'][11]['id']));
  }
}
