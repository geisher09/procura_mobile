import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:procura/Components/custom_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:procura/Screens/Home_Admin/Drawer/BudgetAllocPage.dart';

final formatCurrency = new NumberFormat("#,##0.00", "en_US");

class BudgetAllocationScreen extends StatefulWidget {
  final String host;
  final String funcId;
  final String yearId;
  const BudgetAllocationScreen({Key key, this.host, this.funcId, this.yearId})
      : super(key: key);

  @override
  _BudgetAllocationScreenState createState() => _BudgetAllocationScreenState();
}

class _BudgetAllocationScreenState extends State<BudgetAllocationScreen> {
  Future<List> getSectors() async {
    final response = await http.post("${widget.host}/getSectors.php",
        body: {"pid": widget.funcId, "yid": widget.yearId});
    //print(response.body);
    return json.decode(response.body);
  }

  Future<List> getBudgetAllocationDetails() async {
    final response = await http.post(
        "${widget.host}/getBudgetAllocationDetails.php",
        body: {"pid": widget.funcId, "yid": widget.yearId});
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Theme.of(context).brightness == Brightness.light
              ? Colors.black
              : Colors.white, //change your color here
        ),
        centerTitle: true,
        title: Text(
          "BUDGET ALLOCATION",
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
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: widget.funcId == '1' ? Container(
                  height: 35.0,
                  width: width/1.1,
                  decoration: BoxDecoration(
                    borderRadius: new BorderRadius.circular(15.0),
                    color: Colors.green,
                  ),
                  child: Center(
                    child: Text(
                      'Showing Current Active Budget Year',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontStyle: FontStyle.italic, color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ) : Container(),
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Container(
                    height: 100.0,
                    child: FutureBuilder<List>(
                        future: getBudgetAllocationDetails(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return new BudgetAllocationDetails(
                                host: widget.host, list: snapshot.data);
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        }),
                  )),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  height: 450.0,
                  width:
                      MediaQuery.of(context).orientation == Orientation.portrait
                          ? MediaQuery.of(context).size.width / 1.2
                          : MediaQuery.of(context).size.width / 1.3,
                  child: Card(
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(25.0)),
                    child: FutureBuilder<List>(
                        future: getSectors(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return new SectorList(
                                host: widget.host, list: snapshot.data);
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        }),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SectorList extends StatelessWidget {
  final String host;
  final List list;
  SectorList({this.host, this.list});
  @override
  String money(String fund) {
    if (fund == 'Unallocated') {
      return 'Unallocated';
    } else {
      return 'P' + formatCurrency.format(double.parse(fund));
    }
  }

  Decoration border(int index) {
    if (index == 4) {
      return BoxDecoration(border: Border(bottom: BorderSide.none));
    } else {
      return BoxDecoration(
          border:
              Border(bottom: BorderSide(color: Colors.grey[400], width: 1.0)));
    }
  }

  EdgeInsets pad(int index) {
    if (index == 4) {
      return EdgeInsets.only(top: 15.0, bottom: 2.0);
    } else {
      return EdgeInsets.only(top: 2.0, bottom: 10.0);
    }
  }

  Widget sectorid(String index) {
    if (index == '1') {
      return SizedBox(
        height: 15.0,
        width: 15.0,
        child: Icon(
          CustomIcons.uniE801,
        ),
      );
    } else if (index == '2') {
      return SizedBox(
        height: 15.0,
        width: 15.0,
        child: Icon(
          CustomIcons.uniE821,
        ),
      );
    } else if (index == '3') {
      return SizedBox(
        height: 15.0,
        width: 15.0,
        child: Icon(
          CustomIcons.handout,
        ),
      );
    } else if (index == '4') {
      return SizedBox(
        height: 15.0,
        width: 15.0,
        child: Icon(
          CustomIcons.search_outline,
        ),
      );
    } else if (index == '5') {
      return SizedBox(
        height: 15.0,
        width: 15.0,
        child: Icon(
          CustomIcons.notes,
        ),
      );
    }
  }

  Widget build(BuildContext context) {
    return new ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return Container(
          padding: pad(i),
          decoration: border(i),
          child: GestureDetector(
            onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                builder: (BuildContext context) => new BudgetAllocPage(
                    host: host, title: list[i]['name'], id: list[i]['id']))),
            child: new ListTile(
              leading: sectorid(list[i]['sectorid']),
              title: Text(
                list[i]['name'],
                style:
                new TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0),
                textAlign: TextAlign.center,
              ),
              trailing: Icon(
                CustomIcons.uniE876,
                size: 13.0,
              ),
              subtitle: Container(
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('Fund 101',
                                style: TextStyle(
                                    fontFamily: 'Montserrat', fontSize: 10.0)),
                            Text(
                              money(list[i]['fund_101']),
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 11.0,
                                  fontWeight: FontWeight.bold),
                              overflow: TextOverflow.fade,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: new Container(
                          height: 15.0,
                          width: 1.0,
                          color: Colors.grey[300],
                        ),
                      ),
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('Fund 164',
                                style: TextStyle(
                                    fontFamily: 'Montserrat', fontSize: 10.0)),
                            Text(money(list[i]['fund_164']),
                                overflow: TextOverflow.fade,
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 11.0,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class BudgetAllocationDetails extends StatelessWidget {
  final String host;
  final List list;
  BudgetAllocationDetails({this.host, this.list});
  String money(String fund) {
    if (fund == 'Unallocated') {
      return 'Unallocated';
    } else {
      return 'P' + formatCurrency.format(double.parse(fund));
    }
  }

  @override
  Widget build(BuildContext context) {
    var cardWidth = MediaQuery.of(context).size.width / 1.5;
    return ListView.builder(
        itemCount: list == null ? 0 : 1,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, i) {
          return Row(
            children: <Widget>[
              Container(
                height: 110.0,
                width:
                    MediaQuery.of(context).orientation == Orientation.portrait
                        ? cardWidth
                        : cardWidth / 1.6,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(15.0)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 25.0, bottom: 10.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            SizedBox(
                              height: 20.0,
                              width: 20.0,
                              child: Icon(
                                FontAwesomeIcons.moneyBillAlt,
                              ),
                            ),
                            SizedBox(
                              height: 40.0,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text("Year's Total Budget",
                                      style: TextStyle(fontSize: 12.0)),
                                  Text(money(list[0]['total']),
                                      style: TextStyle(
                                          letterSpacing: 1.0,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0))
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).orientation ==
                                Orientation.portrait
                            ? cardWidth - cardWidth / 5.0
                            : (cardWidth / 1.6) - (cardWidth / 1.6) / 5.0,
                        height: 0.5,
                        color: Colors.grey[400],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 110.0,
                width:
                    MediaQuery.of(context).orientation == Orientation.portrait
                        ? cardWidth
                        : cardWidth / 1.6,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(15.0)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 25.0, bottom: 10.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            SizedBox(
                              height: 20.0,
                              width: 20.0,
                              child: Icon(
                                FontAwesomeIcons.networkWired,
                              ),
                            ),
                            SizedBox(
                              height: 40.0,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text("Total Budget Allocated",
                                      style: TextStyle(fontSize: 12.0)),
                                  Text(money(list[0]['totalAlloc']),
                                      style: TextStyle(
                                          letterSpacing: 1.0,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0))
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).orientation ==
                                Orientation.portrait
                            ? cardWidth - cardWidth / 5.0
                            : (cardWidth / 1.6) - (cardWidth / 1.6) / 5.0,
                        height: 0.5,
                        color: Colors.grey[400],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 110.0,
                width:
                    MediaQuery.of(context).orientation == Orientation.portrait
                        ? cardWidth
                        : cardWidth / 1.6,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(15.0)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 25.0, bottom: 10.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            SizedBox(
                              height: 20.0,
                              width: 20.0,
                              child: Icon(
                                FontAwesomeIcons.wallet,
                              ),
                            ),
                            SizedBox(
                              height: 40.0,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text("Total Budget Left",
                                      style: TextStyle(fontSize: 12.0)),
                                  Text(money(list[0]['leftAlloc']),
                                      style: TextStyle(
                                          letterSpacing: 1.0,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0))
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).orientation ==
                                Orientation.portrait
                            ? cardWidth - cardWidth / 5.0
                            : (cardWidth / 1.6) - (cardWidth / 1.6) / 5.0,
                        height: 0.5,
                        color: Colors.grey[400],
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
        });
  }
}
