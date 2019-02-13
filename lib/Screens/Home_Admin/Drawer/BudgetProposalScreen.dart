import 'dart:convert';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:procura/Components/custom_icons.dart';

final formatCurrency = new NumberFormat("#,##0.00", "en_US");
String money(String fund) {
  return 'P' + formatCurrency.format(double.parse(fund));
}

class BudgetProposalScreen extends StatelessWidget {
  BudgetProposalScreen({this.bp, this.host, this.id});
  final String bp;
  final String host;
  final String id;
  Future<List> getBudgetProposal(String page) async {
    final response =
        await http.post("${host}/getBudgetProposal.php", body: {"id": page});
    //print(response.body);
    return json.decode(response.body);
  }

  Future<List> getBudgetProposal_Dept(String page) async {
    final response = await http.post("${host}/getBudgetProposal_Dept.php",
        body: {"id": page, "uid": id});
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _buildTabs() {
      return <Widget>[
        Tab(
            child: Text(
          'ALL',
          style: new TextStyle(
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.black
                : Colors.white,
            fontSize: 11.0,
            fontWeight: FontWeight.w600,
          ),
        )),
        Tab(
            child: Text(
          'APPROVED',
          style: new TextStyle(
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.black
                : Colors.white,
            fontSize: 11.0,
            fontWeight: FontWeight.w600,
          ),
        )),
        Tab(
            child: Text(
          'REJECTED',
          style: new TextStyle(
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.black
                : Colors.white,
            fontSize: 11.0,
            fontWeight: FontWeight.w600,
          ),
          overflow: TextOverflow.ellipsis,
        )),
        Tab(
            child: Text(
          'PENDING',
          style: new TextStyle(
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.black
                : Colors.white,
            fontSize: 11.0,
            fontWeight: FontWeight.w600,
          ),
        )),
      ];
    }

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.black
                : Colors.white, //change your color here
          ),
          centerTitle: true,
          bottom: TabBar(
            tabs: _buildTabs(),
          ),
          title: Text(
            bp == 'depthead' ? "MY BUDGET PROPOSAL" : "BUDGET PROPOSAL",
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
        body: bp == 'sectorhead'
            ? TabBarView(
                children: <Widget>[
                  FutureBuilder<List>(
                      future: getBudgetProposal('1'),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          print(snapshot.error);
                        }
                        if (snapshot.hasData) {
                          if (snapshot.data.length == 0) {
                            return Center(child: Text('No Data Available'));
                          } else {
                            return new BudgetProposal(
                                host: host, page: 1, list: snapshot.data);
                          }
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      }),
                  FutureBuilder<List>(
                      future: getBudgetProposal('2'),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          print(snapshot.error);
                        }
                        if (snapshot.hasData) {
                          if (snapshot.data.length == 0) {
                            return Center(child: Text('No Data Available'));
                          } else {
                          return new BudgetProposal(
                              host: host, page: 2, list: snapshot.data);
                        }
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      }),
                  FutureBuilder<List>(
                      future: getBudgetProposal('3'),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          print(snapshot.error);
                        }
                        if (snapshot.hasData) {
                          if (snapshot.data.length == 0) {
                            return Center(child: Text('No Data Available'));
                          } else {
                            return new BudgetProposal(
                                host: host, page: 3, list: snapshot.data);
                          }
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      }),
                  FutureBuilder<List>(
                      future: getBudgetProposal('4'),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          print(snapshot.error);
                        }
                        if (snapshot.hasData) {
                          if (snapshot.data.length == 0) {
                            return Center(child: Text('No Data Available'));
                          } else {
                            return new BudgetProposal(
                                host: host, page: 4, list: snapshot.data);
                          }
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      }),
                ],
              )
            : TabBarView(
                children: <Widget>[
                  FutureBuilder<List>(
                      future: getBudgetProposal_Dept('1'),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          print(snapshot.error);
                        }
                        if (snapshot.hasData) {
                          if (snapshot.data.length == 0) {
                            return Center(child: Text('No Data Available'));
                          } else {
                            return new BudgetProposal_Dept(
                                host: host, page: 1, list: snapshot.data);
                          }
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      }),
                  FutureBuilder<List>(
                      future: getBudgetProposal_Dept('2'),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          print(snapshot.error);
                        }
                        if (snapshot.hasData) {
                          if (snapshot.data.length == 0) {
                            return Center(child: Text('No Data Available'));
                          } else {
                            return new BudgetProposal_Dept(
                                host: host, page: 2, list: snapshot.data);
                          }
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      }),
                  FutureBuilder<List>(
                      future: getBudgetProposal_Dept('3'),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          print(snapshot.error);
                        }
                        if (snapshot.hasData) {
                          if (snapshot.data.length == 0) {
                            return Center(child: Text('No Data Available'));
                          } else {
                            return new BudgetProposal_Dept(
                                host: host, page: 3, list: snapshot.data);
                          }
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      }),
                  FutureBuilder<List>(
                      future: getBudgetProposal_Dept('4'),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          print(snapshot.error);
                        }
                        if (snapshot.hasData) {
                          if (snapshot.data.length == 0) {
                            return Center(child: Text('No Data Available'));
                          } else {
                            return new BudgetProposal_Dept(
                                host: host, page: 4, list: snapshot.data);
                          }
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      }),
                ],
              ),
      ),
    );
  }
}

class BudgetProposal extends StatelessWidget {
  final String host;
  final int page;
  final List list;
  BudgetProposal({this.host, this.page, this.list});
  @override
  Widget build(BuildContext context) {
    var w1 = MediaQuery.of(context).size.width;
    double width(int page) {
      if (page == 4) {
        return MediaQuery.of(context).orientation == Orientation.portrait
            ? w1 / 1.75
            : w1 / 1.30;
      } else {
        return MediaQuery.of(context).orientation == Orientation.portrait
            ? w1 / 1.35
            : w1 / 1.2;
      }
    }

    Widget options(int page) {
      if (page == 4) {
        return Container(
          width: 100.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              InkWell(
                borderRadius: BorderRadius.circular(20.0),
                splashColor: Colors.grey[500],
                onTap: () {},
                child: Container(
                  height: 30.0,
                  width: 30.0,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.grey[700]
                            : Colors.grey[200],
                      )),
                  child: Icon(
                    CustomIcons.eye_1,
                    size: 19.0,
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.blue[800]
                        : Colors.blue[400],
                  ),
                ),
              ),
              InkWell(
                borderRadius: BorderRadius.circular(20.0),
                splashColor: Colors.grey[500],
                onTap: () {},
                child: Container(
                  height: 30.0,
                  width: 30.0,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.grey[700]
                            : Colors.grey[200],
                      )),
                  child: Icon(
                    FontAwesomeIcons.solidThumbsUp,
                    size: 16.0,
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.green[800]
                        : Colors.green[400],
                  ),
                ),
              ),
              InkWell(
                borderRadius: BorderRadius.circular(20.0),
                splashColor: Colors.grey[500],
                onTap: () {},
                child: Container(
                  height: 30.0,
                  width: 30.0,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.grey[700]
                            : Colors.grey[200],
                      )),
                  child: Icon(
                    FontAwesomeIcons.solidThumbsDown,
                    size: 16.0,
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.red[800]
                        : Colors.red[400],
                  ),
                ),
              )
            ],
          ),
        );
      } else {
        return InkWell(
          borderRadius: BorderRadius.circular(20.0),
          splashColor: Colors.grey[500],
          onTap: () {},
          child: Container(
            height: 30.0,
            width: 30.0,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.grey[700]
                      : Colors.grey[200],
                )),
            child: Icon(
              CustomIcons.eye_1,
              size: 18.0,
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.blue[800]
                  : Colors.blue[400],
            ),
          ),
        );
      }
    }

    return ListView.builder(
        itemCount: list == null ? 0 : list.length,
        itemBuilder: (context, i) {
          return
//            Padding(
//            padding: const EdgeInsets.only(left: 15.0, right: 15.0),
//            child: Center(
//                child: Card(
//                    child: Padding(
//              padding: const EdgeInsets.all(10.0),
//              child: Column(
//                mainAxisAlignment: MainAxisAlignment.center,
//                children: <Widget>[
//                  Text(
//                    list[i]['amount'],
//                    style: TextStyle(fontSize: 17.0, fontFamily: 'Montserrat'),
//                    overflow: TextOverflow.ellipsis,
//                  ),
//                  Padding(
//                    padding: const EdgeInsets.only(bottom: 20.0),
//                    child: Divider(),
//                  ),
//                  options(page),
//                ],
//              ),
//            ))),
//          );
              Container(
            decoration: new BoxDecoration(
                border: Border(
              bottom: BorderSide(
                  color: Colors.grey, width: 0.5, style: BorderStyle.solid),
            )),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 5.0, 5.0, 5.0),
                  child: Container(
                    decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                        image: NetworkImage(host + list[i]['user_image']),
                        fit: BoxFit.cover,
                      ),
                    ),
                    width: 35.0,
                    height: 35.0,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Text(
                        list[i]['name'],
                        style: new TextStyle(
                            fontSize: 13.5,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w600),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Text(
                          list[i]['proposal_name'],
                          style: new TextStyle(
                              fontSize: 12,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500),
                          overflow: TextOverflow.ellipsis,
                        )),
                    Container(
                      height: 15.0,
                      width: width(page),
                      child: Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Text(
                            'Amount: ' + money(list[i]['amount']),
                            style: new TextStyle(
                              fontSize: 12,
                              fontFamily: 'Montserrat',
                            ),
                            overflow: TextOverflow.ellipsis,
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Text(
                        list[i]['departmentname'],
                        style: new TextStyle(fontSize: 12.0),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                options(page),
              ],
            ),
            width: w1,
            height: 70.0,
          );
        });
  }
}

class BudgetProposal_Dept extends StatelessWidget {
  final String host;
  final int page;
  final List list;
  BudgetProposal_Dept({this.host, this.page, this.list});
  @override
  Widget build(BuildContext context) {
    var w1 = MediaQuery.of(context).size.width;
    return ListView.builder(
        itemCount: list == null ? 0 : list.length,
        itemBuilder: (context, i) {
          return Container(
            decoration: new BoxDecoration(
                border: Border(
              bottom: BorderSide(
                  color: Colors.grey, width: 0.5, style: BorderStyle.solid),
            )),
            child: Row(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Text(
                        list[i]['proposal_name'],
                        style: new TextStyle(
                            fontFamily: 'Montserrat',
                            letterSpacing: 0.5,
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Text(
                        'Amount: ' + money(list[i]['amount']),
                        style: new TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 13.5,
                            fontWeight: FontWeight.w400),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      height: 15.0,
                      width: MediaQuery.of(context).orientation ==
                              Orientation.portrait
                          ? w1 / 1.2
                          : w1 / 1.15,
                      child: Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Text(
                            'Year: ' + list[i]['for_year'],
                            style: new TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 13,
                                fontWeight: FontWeight.w400),
                            overflow: TextOverflow.ellipsis,
                          )),
                    ),
                  ],
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(20.0),
                  splashColor: Colors.grey[500],
                  onTap: () {},
                  child: Container(
                    height: 30.0,
                    width: 30.0,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? Colors.grey[700]
                                  : Colors.grey[200],
                        )),
                    child: Icon(
                      CustomIcons.eye_1,
                      size: 18.0,
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.blue[800]
                          : Colors.blue[400],
                    ),
                  ),
                ),
              ],
            ),
            width: w1,
            height: 70.0,
          );
        });
  }
}
