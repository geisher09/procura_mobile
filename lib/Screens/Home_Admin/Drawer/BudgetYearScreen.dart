import "package:flutter/material.dart";
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final formatCurrency = new NumberFormat("#,##0.00", "en_US");

class BudgetYearScreen extends StatefulWidget {
  final String host;
  const BudgetYearScreen({Key key, this.host}) : super(key: key);
  @override
  _BudgetYearScreenState createState() => _BudgetYearScreenState();
}

class _BudgetYearScreenState extends State<BudgetYearScreen> {
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
        iconTheme: IconThemeData(
          color: Theme.of(context).brightness == Brightness.light
              ? Colors.black
              : Colors.white, //change your color here
        ),
        centerTitle: true,
        title: Text(
          "BUDGET YEAR",
          style: new TextStyle(
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.black
                  : Colors.white,
              fontSize: 15.0,
              fontFamily: 'Lulo'),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//      floatingActionButton: FloatingActionButton(
//        child: Icon(
//          Icons.remove_red_eye
//        ),
//        onPressed: (){},
//      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Center(
                child: Text(
                  'Select Budget Year',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w400),
                ),
              ),
              Center(
                  child: FutureBuilder<String>(
                future: getSWData(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return new DropdownButton(
                      iconSize: 30.0,
                      style: TextStyle(
                          color: Theme.of(context).brightness == Brightness.light
                              ? Colors.black
                              : Colors.white,
                          fontSize: 20.0,
                          fontStyle: FontStyle.italic,
                          fontFamily: 'Raleway'),
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
                          return Center(
                              child: Container(
                            height: 10.0,
                            width: 10.0,
                          ));
                        }
                      }))
            ],
          ),
        ),
      ),
    );
  }
}

class BudgetYearDetails extends StatelessWidget {
  final List list;
  BudgetYearDetails({this.list});
  @override
  String money(String fund) {
    if (fund == 'Unallocated') {
      return 'Unallocated';
    } else {
      return 'P' + formatCurrency.format(double.parse(fund));
    }
  }

  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    Widget fundsPortrait(String fund_101, String fund_164) {
      return Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              height: 100.0,
              width: width / 1.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      height: 80.0,
                      width: 80.0,
                      child: Theme.of(context).brightness == Brightness.light
                          ? Image.asset("assets/images/fund101.png") : Image.asset("assets/images/2fund101.png")
                  ),
                  Text(money(fund_101),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0,
                      )),
                ],
              ),
            ),
            Container(
              height: 100.0,
              width: width / 1.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      height: 80.0,
                      width: 80.0,
                      child: Theme.of(context).brightness == Brightness.light
                          ? Image.asset("assets/images/fund164.png") : Image.asset("assets/images/2fund164.png")
                  ),
                  Text(money(fund_164),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0,
                      )),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: RaisedButton(
                splashColor: Colors.blueGrey,
                //shape: StadiumBorder(),
                child: Padding(
                  padding: const EdgeInsets.only(top: 15.0,bottom:15.0),
                  child: Text(
                    'Proceed to Budget Allocation',
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15.0),
                  ),
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
      );
    }

    Widget fundsLandscape(String fund_101, String fund_164) {
      return Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  width: width / 2.8,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          height: 80.0,
                          width: 80.0,
                          child: Theme.of(context).brightness == Brightness.light
                              ? Image.asset("assets/images/fund101.png") : Image.asset("assets/images/2fund101.png")
                      ),
                      Text(money(fund_101),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30.0,
                          )),
                    ],
                  ),
                ),
                Container(
                  width: width / 2.8,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          height: 80.0,
                          width: 80.0,
                          child: Theme.of(context).brightness == Brightness.light
                              ? Image.asset("assets/images/fund164.png") : Image.asset("assets/images/2fund164.png")
                      ),
                      Text(money(fund_164),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30.0,
                          )),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: RaisedButton(
                splashColor: Colors.blueGrey,
                //shape: StadiumBorder(),
                child: Padding(
                  padding: const EdgeInsets.only(top: 15.0,bottom:15.0),
                  child: Text(
                    'Proceed to Budget Allocation',
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15.0),
                  ),
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: Center(
        child: Column(
          children: <Widget>[
//            Container(
//              height: MediaQuery.of(context).orientation == Orientation.portrait
//                  ? height / 8.0
//                  : height / 4.0,
//              width: MediaQuery.of(context).orientation == Orientation.portrait
//                  ? width / 1.7
//                  : width / 3.0,
//              child: Card(
//                child: Center(
//                  child: Row(
//                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                    children: <Widget>[
//                      Icon(
//                        FontAwesomeIcons.calendarAlt
//                      ),
//                      Text(list[0]['budget_year'],
//                          style: TextStyle(
//                              color: Theme.of(context).brightness == Brightness.light
//                                  ? Colors.black
//                                  : Colors.white,
//                              fontFamily: 'Lulo',
//                              fontWeight: FontWeight.bold,
//                              fontSize: 35.0,
//                              letterSpacing: 2.0)),
//                    ],
//                  ),
//                ),
//              ),
//            ),
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
                          ? Colors.grey[50]
                          : Colors.grey[850],
                      borderRadius: new BorderRadius.only(
                          topLeft: Radius.circular(15.0),
                          topRight: Radius.circular(15.0),
                          bottomLeft: Radius.circular(15.0),
                          bottomRight: Radius.circular(15.0)),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Icon(
                              FontAwesomeIcons.calendarAlt
                          ),
                          Text(list[0]['budget_year'],
                              style: TextStyle(
                                  color: Theme.of(context).brightness == Brightness.light
                                      ? Colors.black
                                      : Colors.white,
                                  fontFamily: 'Lulo',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 35.0,
                                  letterSpacing: 2.0)),
                        ],
                      ),
                    ),
                  )
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top:20.0),
              child: MediaQuery.of(context).orientation == Orientation.portrait
                  ? fundsPortrait(list[0]['fund_101'], list[0]['fund_164'])
                  : fundsLandscape(list[0]['fund_101'], list[0]['fund_164']),
            )
          ],
        ),
      ),
    );
  }
}
