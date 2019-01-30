import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:procura/Components/custom_icons.dart';
import 'package:procura/Screens/Home_Admin/Drawer/BudgetAllocPage.dart';

class BudgetAllocationScreen extends StatefulWidget {
  final String host;
  const BudgetAllocationScreen({Key key, this.host}) : super(key: key);

  @override
  _BudgetAllocationScreenState createState() => _BudgetAllocationScreenState();
}

class _BudgetAllocationScreenState extends State<BudgetAllocationScreen> {
  Future<List> getSectors() async {
    final response = await http.get("${widget.host}/getSectors.php");
    print(response.body);
    return json.decode(response.body);
  }

  Future<List> getData1() async {
    final response = await http.get("${widget.host}/getBudgetAlloc1.php");
    print(response.body);
    return json.decode(response.body);
  }

  Future<List> getData2() async {
    final response = await http.get("${widget.host}/getBudgetAlloc2.php");
    print(response.body);
    return json.decode(response.body);
  }

  Future<List> getData3() async {
    final response = await http.get("${widget.host}/getBudgetAlloc3.php");
    print(response.body);
    return json.decode(response.body);
  }

  Future<List> getData4() async {
    final response = await http.get("${widget.host}/getBudgetAlloc4.php");
    print(response.body);
    return json.decode(response.body);
  }

  Future<List> getData5() async {
    final response = await http.get("${widget.host}/getBudgetAlloc5.php");
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
    body: FutureBuilder<List>(
        future: getSectors(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return new SectorList(host: widget.host,list: snapshot.data);
          } else{
            return Center(
                child: CircularProgressIndicator()
            );}
        }),
    );
  }
}

class SectorList extends StatelessWidget {
  final String host;
  final List list;
  SectorList({this.host, this.list});
  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i){
        return Container(
          padding: EdgeInsets.all(10.0),
          child: GestureDetector(
            onTap: ()=>Navigator.of(context).push(
              new MaterialPageRoute(builder: (BuildContext context)=> new BudgetAllocPage(host: host, title:list[i]['name'], id: i+1))
            ),
            child: Card(
              child: new ListTile(
                title: Text(list[i]['name']),
              ),
            ),
          ),
        );
      },
    );
  }
}