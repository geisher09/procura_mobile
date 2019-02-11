import 'package:flutter/material.dart';
import 'package:procura/Screens/Home_Admin/BottomNavBar/HomeBottomAppBar.dart';
import 'package:procura/Screens/Home_Admin/Drawer/HomeDrawer.dart';
import 'package:http/http.dart' as http;
import 'package:procura/main.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../Components/custom_icons.dart';
import 'package:procura/Screens/Home_Admin/BottomNavBar/HomeDashboard2.dart';
import 'package:procura/Screens/Home_Admin/BottomNavBar/HomeApproval.dart';
import 'package:procura/Screens/Home_Admin/BottomNavBar/HomeRequests.dart';
import 'package:procura/Screens/Home_Admin/BottomNavBar/HomeNotifs.dart';

class Home_AdminScreen extends StatefulWidget {
  final String host;
  Home_AdminScreen({this.host});
  @override
  _Home_AdminScreenState createState() => _Home_AdminScreenState(host);
}

class _Home_AdminScreenState extends State<Home_AdminScreen> {
  _Home_AdminScreenState(this.host);
  final String host;
  Future<List> getData() async {
    final prefs = await SharedPreferences.getInstance();
    final Id = prefs.getString('id') ?? '0';
    final response = await http
        .post("${host}/getUserData.php", body: {"id": Id.replaceAll("\"", "")});
    //print(response.body);
    return json.decode(response.body);
  }

  String _current = 'TAB: 0';
  void _selectedTab(int index) async {
    List userDetails = await getData();
    if (userDetails[0]['user_type_id'] == '1') {
      if (index == 2) {
        _current = 'TAB: 3';
      }else if (index == 1) {
        _current = 'TAB: 2';
      }else {
        _current = 'TAB: $index';
      }
      setState(() {
        _current;
      });
    }else if(userDetails[0]['user_type_id'] == '2') {
      if (index == 2) {
        _current = 'TAB: 3';
      }else {
        _current = 'TAB: $index';
      }
      setState(() {
        _current;
      });
    }else{
      setState(() {
        _current = 'TAB: $index';
      });
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    void _showDialog() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: AlertDialog(
              title: Container(
                height:
                    MediaQuery.of(context).orientation == Orientation.portrait
                        ? MediaQuery.of(context).size.height / 3.75
                        : MediaQuery.of(context).size.height / 1.25,
                width: double.infinity,
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: new AssetImage("assets/images/alert.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              titlePadding: EdgeInsets.all(0.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
              content: Text(
                'As we all know, a manual paper-based system is still being practiced in the system of procurement in this institution. Loads of paper works are being produced that leads to confusion and human error such as neglected files that sends drawbacks and prolongs the process.'
                    ' PROCURA offers an applicable solution in this regard.',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                ),
                textAlign: TextAlign.center,
              ),
              actions: <Widget>[
                new FlatButton(
                  child: new Text(
                    "Close",
                    style: TextStyle(
                        fontFamily: 'Montserrat', fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        },
      );
    }

    String _page_title;
    var iconD;
    var onP;
    int page_no;
    if (_current == 'TAB: 0') {
      _page_title = 'Dashboard';
      page_no = 0;
      iconD = Image.asset(
        'assets/icons/pLogo.png',
        width: 150.0,
        height: 150.0,
      );
      onP = _showDialog;
    } else if (_current == 'TAB: 1') {
      _page_title = 'For Approval';
      page_no = 1;
      iconD = Image.asset(
        'assets/icons/pLogo.png',
        width: 150.0,
        height: 150.0,
      );
      onP = _showDialog;
    } else if (_current == 'TAB: 2') {
      _page_title = 'My Requests';
      page_no = 2;
      iconD = Image.asset(
        'assets/icons/pLogo.png',
        width: 150.0,
        height: 150.0,
      );
      onP = _showDialog;
    } else if (_current == 'TAB: 3') {
      _page_title = 'Notifications';
      page_no = 3;
      iconD = Image.asset(
        'assets/icons/pLogo.png',
        width: 150.0,
        height: 150.0,
      );
      onP = _showDialog;
    }

    HomeBottomAppBar HomeBAP(String usertype){
      if(usertype == '1'){
        return HomeBottomAppBar(
            selectedColor: Colors.blueAccent,
            notchedShape: CircularNotchedRectangle(),
            onTabSelected: _selectedTab,
            items: [
              HomeBottomAppBarItem(
                  iconData: CustomIcons.chart_bar, count: 0),
              HomeBottomAppBarItem(
                  iconData: CustomIcons.paper_plane_empty,
                  count: 0),
              HomeBottomAppBarItem(
                  iconData: CustomIcons.bell, count: 5),
            ]
      );
      }else if(usertype == '2'){
        return HomeBottomAppBar(
            selectedColor: Colors.blueAccent,
            notchedShape: CircularNotchedRectangle(),
            onTabSelected: _selectedTab,
            items: [
              HomeBottomAppBarItem(
                  iconData: CustomIcons.chart_bar, count: 0),
              HomeBottomAppBarItem(
                  iconData: CustomIcons.ok, count: 0),
              HomeBottomAppBarItem(
                  iconData: CustomIcons.bell, count: 5),
            ]
        );
      }else{
        return HomeBottomAppBar(
            selectedColor: Colors.blueAccent,
            notchedShape: CircularNotchedRectangle(),
            onTabSelected: _selectedTab,
            items: [
              HomeBottomAppBarItem(
                  iconData: CustomIcons.chart_bar, count: 0),
              HomeBottomAppBarItem(
                  iconData: CustomIcons.ok, count: 0),
              HomeBottomAppBarItem(
                  iconData: CustomIcons.paper_plane_empty,
                  count: 0),
              HomeBottomAppBarItem(
                  iconData: CustomIcons.bell, count: 5),
            ]
        );
      }

    }
    return Scaffold(
        key: _scaffoldKey,
        drawer: new FutureBuilder<List>(
            future: getData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return new HomeDrawer(
                    host: host,
                    list: snapshot.data,
                    pic: snapshot.data[0]['user_image']);
              } else{
                return Center(
                  child: new Container(
                    width: 10.0,
                    height: 10.0,
                  ),
                );}
            }),
        appBar: new AppBar(
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          leading: new FutureBuilder(
              future: getData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return new IconButton(
                      icon: Image.network(
                        host + snapshot.data[0]['user_image'],
                        width: 30.0,
                        height: 30.0,
                      ),
                      onPressed: () => _scaffoldKey.currentState.openDrawer());
                } else
                  return new Center(
                    child: new Container(
                      width: 10.0,
                      height: 10.0,
                    ),
                  );
              }),
          title: new Text(
            _page_title,
            style: new TextStyle(
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.black
                    : Colors.white,
                fontSize: 15.0,
                letterSpacing: 1.5,
                fontWeight: FontWeight.w900),
          ),
          actions: <Widget>[
            IconButton(
              icon: iconD,
              onPressed: onP,
            )
          ],
        ),
        body: Center(
          child: new FutureBuilder<List>(
            future: getData(),
            builder: (context, snapshot) {
              if (snapshot.hasError)
                print(snapshot.error);
              else {
                if (snapshot.hasData) {
                  if (page_no == 0) {
                    return page_dashboard(list: snapshot.data);
                  } else if (page_no == 1) {
                    return page_approval(list: snapshot.data);
                  } else if (page_no == 2) {
                    return page_requests(list: snapshot.data);
                  } else if (page_no == 3) {
                    return page_notifs(list: snapshot.data);
                  }
                } else
                  return new Center(
                    child: new CircularProgressIndicator(),
                  );
              }
            },
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        bottomNavigationBar: new FutureBuilder<List>(
            future: getData(),
            builder: (context, snapshot) {
              if(snapshot.hasData){
                return HomeBAP(snapshot.data[0]['user_type_id']);
              }else
                return new Center(
                  child: new CircularProgressIndicator(),
                );
            }));
  }
}

class page_dashboard extends StatelessWidget {
  final List list;
  page_dashboard({this.list});

  @override
  Widget build(BuildContext context) {
    return new HomeDashboard2(list);
  }
}

class page_approval extends StatelessWidget {
  final List list;
  page_approval({this.list});

  @override
  Widget build(BuildContext context) {
    return new HomeApproval();
  }
}

class page_requests extends StatelessWidget {
  final List list;
  page_requests({this.list});

  @override
  Widget build(BuildContext context) {
    return new HomeRequests();
  }
}

class page_notifs extends StatelessWidget {
  final List list;
  page_notifs({this.list});

  @override
  Widget build(BuildContext context) {
    return new HomeNotifs();
  }
}
