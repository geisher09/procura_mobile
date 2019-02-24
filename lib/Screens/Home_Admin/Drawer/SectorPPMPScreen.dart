import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:procura/Components/custom_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:procura/Screens/Home_Admin/Drawer/PPMPDetailsPage.dart';
import 'package:url_launcher/url_launcher.dart';

final formatter = new DateFormat.yMMMMd("en_US").add_jm();

class SectorPPMPScreen extends StatelessWidget {
  SectorPPMPScreen({this.host, this.listuser, this.id});
  final String host;
  final List listuser;
  final String id;
  Future<List> getPPMP(String page) async {
    final response = await http
        .post("$host/getPPMP_Sector.php", body: {"pid": page, "uid": id});
    //print(response.body);
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _buildTabs() {
      return <Widget>[
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
          overflow: TextOverflow.ellipsis,
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
        )),
      ];
    }

    return DefaultTabController(
      length: 3,
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
            "PPMP",
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
        body: TabBarView(
          children: <Widget>[
            FutureBuilder<List>(
                future: getPPMP('1'),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    print(snapshot.error);
                  }
                  if (snapshot.hasData) {
                    if (snapshot.data.length == 0) {
                      return Center(child: Text('No Data Available'));
                    } else {
                      return new PPMP(host: host, page: 1, list: snapshot.data, listuser: listuser);
                    }
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }),
            FutureBuilder<List>(
                future: getPPMP('2'),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    print(snapshot.error);
                  }
                  if (snapshot.hasData) {
                    if (snapshot.data.length == 0) {
                      return Center(child: Text('No Data Available'));
                    } else {
                      return new PPMP(host: host, page: 2, list: snapshot.data, listuser: listuser);
                    }
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }),
            FutureBuilder<List>(
                future: getPPMP('3'),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    print(snapshot.error);
                  }
                  if (snapshot.hasData) {
                    if (snapshot.data.length == 0) {
                      return Center(child: Text('No Data Available'));
                    } else {
                      return new PPMP(host: host, page: 3, list: snapshot.data, listuser: listuser);
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

class PPMP extends StatelessWidget {
  final String host;
  final int page;
  final List list;
  final List listuser;
  PPMP({this.host, this.page, this.list, this.listuser});
  @override
  String date(String date) {
    return formatter.format(DateTime.parse(date));
  }

  Widget build(BuildContext context) {
    var w1 = MediaQuery.of(context).size.width;
    List splithost = host.split('/');
    String newHost = 'http://${splithost[2]}:8000/mobile/projects/';
    double width = MediaQuery.of(context).orientation == Orientation.portrait
        ? w1 / 4.5
        : w1 / 5.0;

    Widget options(String title, String id, int page, String user_id) {
      if (page == 1) {
        return InkWell(
          borderRadius: BorderRadius.circular(20.0),
          splashColor: Colors.grey[500],
          onTap: () => Navigator.of(context).push(new MaterialPageRoute(
              builder: (BuildContext context) => new PPMPDetailsPage(
                user_id: user_id,
                  listuser: listuser,
                  usertype: 'sectorpending',
                  title: title,
                  host: host,
                  id: id))),
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
        );
      } else if (page == 2) {
        return Container(
          width: width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              InkWell(
                borderRadius: BorderRadius.circular(20.0),
                splashColor: Colors.grey[500],
                onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => new PPMPDetailsPage(
                        user_id: user_id,
                        listuser: listuser,
                        usertype: 'sector', title: title, host: host, id: id))),
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
                        : Colors.blue[500],
                  ),
                ),
              ),
              InkWell(
                borderRadius: BorderRadius.circular(20.0),
                splashColor: Colors.grey[500],
                onTap: () => launch('$newHost$id/file'),
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
                    FontAwesomeIcons.fileExcel,
                    size: 18.0,
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.green[800]
                        : Colors.green[500],
                  ),
                ),
              ),
            ],
          ),
        );
      } else if(page == 3){
        return InkWell(
          borderRadius: BorderRadius.circular(20.0),
          splashColor: Colors.grey[500],
          onTap: () => Navigator.of(context).push(new MaterialPageRoute(
              builder: (BuildContext context) => new PPMPDetailsPage(
                  user_id: user_id,
                  listuser: listuser,
                  usertype: 'sector', title: title, host: host, id: id))),
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
        );
      }
    }

    return ListView.builder(
        itemCount: list == null ? 0 : list.length,
        itemBuilder: (context, i) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 2.0, 10.0, 0.0),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(0.0)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      list[i]['title'],
                      style: new TextStyle(
                          fontSize: 16.0, fontFamily: 'Montserrat'),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      list[i]['departmentname'],
                      style: new TextStyle(
                          fontWeight: FontWeight.w300,
                          fontFamily: 'Montserrat',
                          fontSize: 13.0),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      'Sender: '+list[i]['name'],
                      style: new TextStyle(
                          fontWeight: FontWeight.w300,
                          fontFamily: 'Montserrat',
                          fontSize: 13.0),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Date submitted: ',
                        style: new TextStyle(
                            fontStyle: FontStyle.italic, fontSize: 12.0),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        date(list[i]['submitted_at']),
                        style: new TextStyle(
                            fontFamily: 'Montserrat', fontSize: 12.0),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                    child: options(list[i]['title'], list[i]['id'], page, list[i]['user_id']),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
