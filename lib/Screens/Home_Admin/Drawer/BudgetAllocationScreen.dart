import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BudgetAllocationScreen extends StatefulWidget {
  final String host;
  const BudgetAllocationScreen({Key key, this.host}) : super(key: key);

  @override
  _BudgetAllocationScreenState createState() => _BudgetAllocationScreenState();
}

class _BudgetAllocationScreenState extends State<BudgetAllocationScreen> {
  Future<List> getData() async {
    final response = await http.get("${widget.host}/getBudgetAlloc.php");
    print(response.body);
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Theme.of(context).brightness == Brightness.light
              ? Colors.black
              : Colors.white, //change your color here
        ),
        title: Text(
          "BUDGET ALLOCATION",
          style: new TextStyle(
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.black
                  : Colors.white,
              fontSize: 15.0,
              fontWeight: FontWeight.w600,
              letterSpacing: 2.0),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Card(
          child: FutureBuilder(
            future: getData(),
            builder: (context, snapshot) {
              if (snapshot.hasError) print(snapshot.error);
              return snapshot.hasData
                  ? new BudgetAllocList(list: snapshot.data)
                  : new Center(
                      child: CircularProgressIndicator(),
                    );
            },
          ),
        ),
      ),
//      body: Container(
//          padding: EdgeInsets.all(10.0),
//          alignment: Alignment.topCenter,
//          child: Card(
//            child: Padding(
//              padding: const EdgeInsets.all(8.0),
//              child: Column(
//                children: <Widget>[
//                  Padding(
//                    padding: const EdgeInsets.all(8.0),
//                    child: Row(
//                      mainAxisAlignment: MainAxisAlignment.spaceAround,
//                      children: <Widget>[
//                        Text(
//                          'SECTOR',
//                          style: new TextStyle(
//                              fontFamily: 'Montserrat',
//                              fontSize: 14.0,
//                              fontWeight: FontWeight.w600),
//                        ),
//                        Text(
//                          'FUND 101',
//                          style: new TextStyle(
//                              fontFamily: 'Montserrat',
//                              fontSize: 14.0,
//                              fontWeight: FontWeight.w600),
//                        ),
//                        Text(
//                          'FUND 164',
//                          style: new TextStyle(
//                              fontFamily: 'Montserrat',
//                              fontSize: 14.0,
//                              fontWeight: FontWeight.w600),
//                        )
//                      ],
//                    ),
//                  ),
//                  FutureBuilder(
//                    future: getData(),
//                    builder: (context, snapshot) {
//                      if (snapshot.hasError) print(snapshot.error);
//                      return snapshot.hasData
//                          ? new BudgetAllocList(list: snapshot.data)
//                          : new Center(
//                        child: CircularProgressIndicator(),
//                      );
//                    },
//                  ),
////                  Container(
////                    color: Theme.of(context).brightness == Brightness.light
////                        ? Colors.grey[300]
////                        : Colors.grey[850],
////                    child: Padding(
////                      padding: const EdgeInsets.all(8.0),
////                      child: Column(
////                        children: <Widget>[
////
////                        ],
////                      ),
////                    ),
////                  ),
//                ],
//              ),
//            ),
//          )),
    );
  }
}

class BudgetAllocList extends StatelessWidget {
  final List list;
  BudgetAllocList({this.list});
  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: new Container(
            height: 30.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Expanded(flex: 2,child: Container(child: Text(list[i]['departmentname'], overflow: TextOverflow.ellipsis))),
                Expanded(flex: 1,child: Container(child: Text(list[i]['fund_101'], overflow: TextOverflow.ellipsis))),
                Expanded(flex: 1,child: Container(child: Text(list[i]['fund_164'], overflow: TextOverflow.ellipsis))),
              ],
            ),
          ),
        );
      },
    );
  }
}
