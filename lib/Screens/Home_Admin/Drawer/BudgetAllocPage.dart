import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

final formatCurrency = new NumberFormat("#,##0.00", "en_US");

class BudgetAllocPage extends StatelessWidget {
  final String title;
  final String host;
  final int id;
  BudgetAllocPage({this.title,this.host,this.id});
  @override
  Widget build(BuildContext context) {
    Future<List> getBudgetAlloc() async {
      final response = await http
          .post("$host/getSectorDepartments.php", body: {"id": id.toString()});
      return json.decode(response.body);
    }

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
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: FutureBuilder<List>(
            future: getBudgetAlloc(),
            builder: (context, snapshot) {
              if(snapshot.hasError){
                print(snapshot.error);
              }
              if (snapshot.hasData) {
                return new BudgetAlloc(list: snapshot.data);
              } else{
                return Center(
                    child: CircularProgressIndicator()
                );}
            }),
      ),
    );
  }
}

class BudgetAlloc extends StatelessWidget {
  final List list;
  BudgetAlloc({this.list});
  @override
  String money(String fund){
    if(fund=='Unallocated'){
      return 'Unallocated';
    }else{
      return 'P'+formatCurrency.format(double.parse(fund));
    }
  }
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return new Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey[400]
              )
            )
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListTile(
              title: Column(
                children: <Widget>[
                  Center(
                      child: Container(
                          child: Text(list[i]['departmentname'],
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.0,
                                  letterSpacing: 0.5)))),
                  Container(
                    height: 15.0,
                  )
                ],
              ),
              subtitle: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('Fund 101',
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 12.0)),
                        Text(money(list[i]['dfund_101']),
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 13.0,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: new Container(
                        height: 15.0,
                        width: 1.0,
                        color: Colors.grey[300],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('Fund 164',
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 12.0)),
                        Text(money(list[i]['dfund_164']),
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 13.0,
                                fontWeight: FontWeight.bold
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
