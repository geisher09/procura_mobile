import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:procura/Screens/Home_Admin/BottomNavBar/HomeApproval_BO.dart';
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

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:async';
import 'package:flutter/cupertino.dart';

var flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
Timer timer;

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

  Future<List> getpushNotifs() async {
    final prefs = await SharedPreferences.getInstance();
    final Id = prefs.getString('id') ?? '0';
    final response = await http
        .post("${host}/pushNotifs.php", body: {"id": Id.replaceAll("\"", "")});
    return json.decode(response.body);
  }

  void pushnotif() async {
    List notifDetails = await getpushNotifs();
    if (notifDetails.length > 0) {
      await _showNotification(notifDetails[0]['data']);
    }
  }

  @override
  initState() {
    super.initState();
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = new IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidRecieveLocalNotification);
    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) => pushnotif());
  }


//  @override
//  void dispose() {
//    timer?.cancel();
//    super.dispose();
//  }

  String _current = 'TAB: 0';
  void _selectedTab(int index) async {
    List userDetails = await getData();
    if (userDetails[0]['user_type_id'] == '1') {
      if (index == 2) {
        _current = 'TAB: 3';
      } else if (index == 1) {
        _current = 'TAB: 2';
      } else {
        _current = 'TAB: $index';
      }
      setState(() {
        _current;
      });
    } else if (userDetails[0]['user_type_id'] == '2') {
      if (index == 2) {
        _current = 'TAB: 3';
      } else {
        _current = 'TAB: $index';
      }
      setState(() {
        _current;
      });
    } else {
      setState(() {
        _current = 'TAB: $index';
      });
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    //pushnotif();
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
    HomeBottomAppBar HomeBAP(String usertype) {
      if (usertype == '1') {
        return HomeBottomAppBar(
            selectedColor: Colors.blueAccent,
            notchedShape: CircularNotchedRectangle(),
            onTabSelected: _selectedTab,
            items: [
              HomeBottomAppBarItem(iconData: CustomIcons.chart_bar, count: 0),
              HomeBottomAppBarItem(
                  iconData: CustomIcons.paper_plane_empty, count: 0),
              HomeBottomAppBarItem(iconData: CustomIcons.bell, count: 5),
            ]);
      } else if (usertype == '2') {
        return HomeBottomAppBar(
            selectedColor: Colors.blueAccent,
            notchedShape: CircularNotchedRectangle(),
            onTabSelected: _selectedTab,
            items: [
              HomeBottomAppBarItem(iconData: CustomIcons.chart_bar, count: 0),
              HomeBottomAppBarItem(iconData: CustomIcons.ok, count: 0),
              HomeBottomAppBarItem(iconData: CustomIcons.bell, count: 5),
            ]);
      } else {
        return HomeBottomAppBar(
            selectedColor: Colors.blueAccent,
            notchedShape: CircularNotchedRectangle(),
            onTabSelected: _selectedTab,
            items: [
              HomeBottomAppBarItem(iconData: CustomIcons.chart_bar, count: 0),
              HomeBottomAppBarItem(iconData: CustomIcons.ok, count: 0),
              HomeBottomAppBarItem(
                  iconData: CustomIcons.paper_plane_empty, count: 0),
              HomeBottomAppBarItem(iconData: CustomIcons.bell, count: 5),
            ]);
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
              } else {
                return Center(
                  child: new Container(
                    width: 10.0,
                    height: 10.0,
                  ),
                );
              }
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
                    return page_approval(host: host, list: snapshot.data);
                  } else if (page_no == 2) {
                    return page_requests(host: host, list: snapshot.data);
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
              if (snapshot.hasData) {
                return HomeBAP(snapshot.data[0]['user_type_id']);
              } else
                return new Center(
                  child: new CircularProgressIndicator(),
                );
            }));
  }

  Future _showNotification(String data) async {
    var length = data.length;
    length -= 2;
    String text = data.substring(12,length);
    print(text);
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.Max, priority: Priority.High);
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, 'Trial notif!', text, platformChannelSpecifics,
        payload: 'trial name');
//    await flutterLocalNotificationsPlugin.schedule(
//        0,
//        'scheduled title',
//        'scheduled body',
//        scheduledNotificationDateTime,
//        platformChannelSpecifics);
  }

  Future onSelectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }

    await Navigator.push(
      context,
      new MaterialPageRoute(builder: (context) => new SecondScreen(payload)),
    );
  }

  Future onDidRecieveLocalNotification(
      int id, String title, String body, String payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    showDialog(
      context: context,
      builder: (BuildContext context) => new CupertinoAlertDialog(
            title: new Text(title),
            content: new Text(body),
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                child: new Text('Ok'),
                onPressed: () async {
                  Navigator.of(context, rootNavigator: true).pop();
                  await Navigator.push(
                    context,
                    new MaterialPageRoute(
                      builder: (context) => new SecondScreen(payload),
                    ),
                  );
                },
              )
            ],
          ),
    );
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
  final String host;
  final List list;
  page_approval({this.host, this.list});

  @override
  Widget build(BuildContext context) {
    if(list[0]['user_type_id'] == '2'){
      return new HomeApproval_BO(host: host, list: list);
    }else if(list[0]['user_type_id'] == '3'){
      return new HomeApproval(host: host, list: list);
    }
  }
}

class page_requests extends StatelessWidget {
  final String host;
  final List list;
  page_requests({this.host, this.list});

  @override
  Widget build(BuildContext context) {
    return new HomeRequests(host: host, list: list);
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

class SecondScreen extends StatefulWidget {
  final String payload;
  SecondScreen(this.payload);
  @override
  State<StatefulWidget> createState() => new SecondScreenState();
}

class SecondScreenState extends State<SecondScreen> {
  String _payload;
  @override
  void initState() {
    super.initState();
    _payload = widget.payload;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          "Second Screenaaaaaaaaaaa: " + _payload,
          style: TextStyle(fontSize: 14.0),
        ),
      ),
      body: new Center(
        child: new RaisedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: new Text('Go back!'),
        ),
      ),
    );
  }
}
