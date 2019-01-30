import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
      print(response.body);
      return json.decode(response.body);
    }

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Theme.of(context).brightness == Brightness.light
              ? Colors.black
              : Colors.white, //change your color here
        ),
        centerTitle: true,
        title: Text(
          title,
          style: new TextStyle(
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.black
                  : Colors.white,
              fontSize: 12.0,
              fontFamily: 'Montserrat'),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: FutureBuilder<List>(
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
    );
  }
}

class BudgetAlloc extends StatelessWidget {
  final List list;
  BudgetAlloc({this.list});
  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return new Container(
          child: Card(
              child: ListTile(
                title: Center(
                    child: Container(
                        child: Text(list[i]['departmentname'],
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                fontSize: 14.0,
                                letterSpacing: 1.0)))),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(list[i]['dfund_101'],
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat',
                            fontSize: 13.0)),
                    Text(list[i]['dfund_164'],
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat',
                            fontSize: 13.0)),
                  ],
                ),
              )),
        );
      },
    );
  }
}
