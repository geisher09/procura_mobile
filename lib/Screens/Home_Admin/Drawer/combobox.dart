import "package:flutter/material.dart";
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class cb extends StatefulWidget {
  final String host;
  const cb({Key key, this.host}) : super(key: key);

  @override
  _cbState createState() => _cbState();
}

class _cbState extends State<cb> {
  String _mySelection;
  List data = List(); //edited line
  int id;

  Future<String> getSWData() async {
    var res = await http.get("${widget.host}/getBudgetYears.php");
    var resBody = json.decode(res.body);

    setState(() {
      data = resBody;
    });
    return "Sucess";
  }

  Future<List> getBudgetYearDetails(String id) async {
    final response = await http
        .post("${widget.host}/getBudgetYearDetails.php", body: {"id": id});
    return json.decode(response.body);
  }

  @override
  void initState() {
    _mySelection = '1';
    super.initState();
    this.getSWData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Budget year"),
      ),
      body: Column(
        children: <Widget>[
          new Center(
              child: FutureBuilder<String>(
            future: getSWData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return new DropdownButton(
                  items: data.map((item) {
                    return new DropdownMenuItem(
                      child: new Text(item['budget_year']),
                      value: item['id'].toString(),
                    );
                  }).toList(),
                  onChanged: (newVal) {
                    setState(() {
                      _mySelection = newVal;
                    });
                  },
                  value: _mySelection,
                );
              } else {
                return CircularProgressIndicator();
              }
            },
          )),
          Center(
              child: FutureBuilder<List>(
                  future: getBudgetYearDetails(_mySelection),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      print(snapshot.error);
                    }
                    if (snapshot.hasData) {
                      return new BudgetYearDetails(list: snapshot.data);
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  }))
        ],
      ),
    );
  }
}

class BudgetYearDetails extends StatelessWidget {
  final List list;
  BudgetYearDetails({this.list});
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Center(
      child: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).orientation == Orientation.portrait
                ? height / 8.0
                : height / 4.0,
            width: MediaQuery.of(context).orientation == Orientation.portrait
                ? width / 1.7
                : width / 3.0,
            decoration: BoxDecoration(
              gradient: new LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF17ead9).withOpacity(0.7),
                    Color(0xFF6078ea).withOpacity(0.7)
                  ]),
              borderRadius: new BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0)),
            ),
            child: Center(
                child: Container(
                  height: MediaQuery.of(context).orientation == Orientation.portrait
                      ? height / 9.2
                      : height / 4.6,
                  width: MediaQuery.of(context).orientation == Orientation.portrait
                      ? width / 1.8
                      : width / 3.15,
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.white
                        : Colors.grey[850],
                    borderRadius: new BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        topRight: Radius.circular(15.0),
                        bottomLeft: Radius.circular(15.0),
                        bottomRight: Radius.circular(15.0)),
                  ),
                  child: Center(
                    child: Text(list[0]['budget_year'],
                        style: TextStyle(
                            color: Theme.of(context).brightness == Brightness.light
                                ? Colors.black
                                : Colors.white,
                          fontFamily: 'Lulo',
                            fontWeight: FontWeight.bold,
                            fontSize: 35.0,
                            letterSpacing: 2.0)),
                  ),
                )),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).orientation == Orientation.portrait
                    ? height / 8.0
                    : height / 4.0,
                width: MediaQuery.of(context).orientation == Orientation.portrait
                    ? width / 2.5
                    : width / 3.0,
                decoration: BoxDecoration(
                  gradient: new LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF17ead9).withOpacity(0.7),
                        Color(0xFF6078ea).withOpacity(0.7)
                      ]),
                  borderRadius: new BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                      bottomLeft: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0)),
                ),
                child: Center(
                    child: Text(list[0]['fund_101'],
                        style: TextStyle(
                            fontFamily: 'Lulo',
                            fontWeight: FontWeight.bold,
                            fontSize: 35.0,
                            letterSpacing: 2.0))),
              ),
              Container(
                height: MediaQuery.of(context).orientation == Orientation.portrait
                    ? height / 8.0
                    : height / 4.0,
                width: MediaQuery.of(context).orientation == Orientation.portrait
                    ? width / 2.5
                    : width / 3.0,
                decoration: BoxDecoration(
                  gradient: new LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF17ead9).withOpacity(0.7),
                        Color(0xFF6078ea).withOpacity(0.7)
                      ]),
                  borderRadius: new BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                      bottomLeft: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0)),
                ),
                child: Center(
                    child: Text(list[0]['fund_164'],
                        style: TextStyle(
                            fontFamily: 'Lulo',
                            fontWeight: FontWeight.bold,
                            fontSize: 35.0,
                            letterSpacing: 2.0))),
              ),
            ],
          )
        ],
      ),
    );
  }
}
