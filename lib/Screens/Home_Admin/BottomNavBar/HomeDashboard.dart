import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:http/http.dart' as http;


class HomeDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//    final response = await http.post(
//        "http://192.168.22.9/procura_mobile/getdata.php",
    Future<List> getData() async {
      final response = await http.get("http://192.168.22.4/ProcuraMobile/getUserData.php");
      return json.decode(response.body);
    }

    var now = new DateTime.now();
    var formatter = new DateFormat('EEEE, LLL d y');
    String formatted = formatter.format(now);

    return Scaffold(
      appBar: new AppBar(title: Text('title'),),
      body: new FutureBuilder<List>(
        future: getData(),
        builder: (context,snapshot){
          if(snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? page_identifier(list: snapshot.data)
              : new Center(child: new CircularProgressIndicator(),);
        },
      ),
    );
  }
}

class page_identifier extends StatelessWidget {
  page_identifier({this.list});
  List list;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list == null ? 0:list.length,
      itemBuilder: (context, i){
        return Text(list[i]['username']);
      },
    );
  }
}

