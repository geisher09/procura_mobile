import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:procura/Components/custom_icons.dart';

class PRDetailsPage extends StatelessWidget {
  final String usertype;
  final String title;
  final String host;
  final String id;

  PRDetailsPage({this.usertype, this.title, this.host, this.id});

  @override
  Widget build(BuildContext context) {
    Future<List> getPPMPDetails() async {
      final response = await http
          .post("$host/getPurchaseRequestDetails.php", body: {"id": id});
      print(usertype);
      return json.decode(response.body);
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
                      "ITEM #",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.blue),
                    ),
                    numeric: false,
                  ),
                  DataColumn(
                    label: Text(
                      "UNIT",
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
                      "TOTAL PRICE",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.blue),
                    ),
                    numeric: false,
                  ),
                ],
                rows: names
                    .map(
                      (name) => DataRow(
                    cells: [
                      DataCell(
                        Text(name.item_no.toString()),
                        showEditIcon: false,
                        placeholder: false,
                      ),
                      DataCell(
                        Text(name.unit),
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
                        Text(name.cost),
                        showEditIcon: false,
                        placeholder: false,
                      ),
                      DataCell(
                        Text(name.estimated_budget),
                        showEditIcon: false,
                        placeholder: false,
                      ),
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
  int item_no;
  String unit;
  String description;
  String qty;
  String cost;
  String estimated_budget;
  Name(
      {
        this.item_no,
        this.unit,
        this.description,
        this.qty,
        this.cost,
        this.estimated_budget,
        });
}

var names = <Name>[];

void rows({List list}) {
  names.clear();
  for (int i = 0; i < list.length; i++) {
    names.add(Name(
        item_no: i+1,
        unit: list[i]['unit'],
        description: list[i]['description'],
        qty: list[i]['quantity'],
        cost: list[i]['unit_cost'],
        estimated_budget: list[i]['total_cost'],
    ));
  }
}
