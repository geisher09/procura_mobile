import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:procura/Components/custom_icons.dart';
import 'package:procura/Screens/Home_Admin/Drawer/BudgetAllocPage.dart';

final formatCurrency = new NumberFormat("#,##0.00", "en_US");

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
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          height: 450.0,
          child: Card(
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(25.0)),
            child: FutureBuilder<List>(
                future: getSectors(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return new SectorList(host: widget.host, list: snapshot.data);
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }),
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

  String money(String fund){
    if(fund=='Unallocated'){
      return 'Unallocated';
    }else{
      return 'P'+formatCurrency.format(double.parse(fund));
    }
  }
  Decoration border(int index){
    if(index==4){
      return BoxDecoration(
          border: Border(
              bottom: BorderSide.none
          )
      );
    }else{
      return BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: Colors.grey[400],
                  width: 1.0
              )
          )
      );
    }
  }
  Widget sectorid(int index){
    if(index==0){
      return SizedBox(
        height: 15.0,
        width: 15.0,
        child: Icon(
          CustomIcons.uniE801,
        ),
      );
    }else if(index==1){
      return SizedBox(
        height: 15.0,
        width: 15.0,
        child: Icon(
          CustomIcons.uniE821,
        ),
      );
    }else if(index==2){
      return SizedBox(
        height: 15.0,
        width: 15.0,
        child: Icon(
          CustomIcons.handout,
        ),
      );
    }else if(index==3){
      return SizedBox(
        height: 15.0,
        width: 15.0,
        child: Icon(
          CustomIcons.notes,
        ),
      );
    }else if(index==4){
      return SizedBox(
        height: 15.0,
        width: 15.0,
        child: Icon(
          CustomIcons.search_outline,
        ),
      );
    }
  }

  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return Container(
          padding: EdgeInsets.all(10.0),
          decoration: border(i),
          child: GestureDetector(
            onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                builder: (BuildContext context) => new BudgetAllocPage(
                    host: host, title: list[i]['name'], id: i + 1))),
            child: new ListTile(
              leading: sectorid(i),
              title: Text(
                list[i]['name'],
                style: new TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13.0),
                textAlign: TextAlign.center,
              ),
              trailing: Icon(
                  CustomIcons.uniE876,
                size: 13.0,
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
                                fontSize: 10.0)),
                        Text(money(list[i]['fund_101']),
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 11.0,
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
                                fontSize: 10.0)),
                        Text(money(list[i]['fund_164']),
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 11.0,
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
