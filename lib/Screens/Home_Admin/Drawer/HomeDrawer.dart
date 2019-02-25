import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:procura/Components/custom_icons.dart';
import 'package:procura/Screens/Home_Admin/Drawer/BudgetAllocationScreen.dart';
import 'package:procura/Screens/Home_Admin/Drawer/BudgetAllocationSector.dart';
import 'package:procura/Screens/Home_Admin/Drawer/BudgetProposalScreen.dart';
import 'package:procura/Screens/Home_Admin/Drawer/BudgetYearScreen.dart';
import 'package:procura/Screens/Home_Admin/Drawer/DeptPPMPScreen.dart';
import 'package:procura/Screens/Home_Admin/Drawer/DeptPRScreen.dart';
import 'package:procura/Screens/Home_Admin/Drawer/ProfileScreen.dart';
import 'package:procura/Screens/Home_Admin/Drawer/PurchaseRequestScreen.dart';
import 'package:procura/Screens/Home_Admin/Drawer/SectorPPMPScreen.dart';
import 'package:procura/Screens/Home_Admin/Drawer/SettingsScreen.dart';
import 'package:procura/Screens/Home_Admin/BottomNavBar/flutterappbadger.dart';
import 'package:procura/Screens/Home_Admin/Drawer/try.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeDrawer extends StatefulWidget {
  final String host;
  final List list;
  final String pic;
  const HomeDrawer({this.host, this.list, this.pic});
  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  Future<List> getData() async {
    final prefs = await SharedPreferences.getInstance();
    final Id = prefs.getString('id') ?? '0';

    final response = await http.post("${widget.host}/getUserData.php",
        body: {"id": Id.replaceAll("\"", "")});
    return json.decode(response.body);
  }

  Future<String> getApprover() async {
    final response = await http.get("${widget.host}/pr_Approver.php");
    return (response.body);
  }

  @override
  Widget drawerIndicator(String type, String approverID) {
    List splithost = widget.host.split('/');
    String newHost = 'http://${splithost[2]}/Procura/storage/app/public/';
    if (type == '1') {
      return Drawer(
          child: new ListView(
        children: <Widget>[
          GestureDetector(
            child: new UserAccountsDrawerHeader(
              accountName: new Text(
                '${widget.list[0]['name']}',
                style: new TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.black
                        : Colors.white),
              ),
              accountEmail: new Text(
                '${widget.list[0]['username']}',
                style: new TextStyle(
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.black
                        : Colors.white),
              ),
              currentAccountPicture: CircleAvatar(
                  backgroundImage:
                      NetworkImage(newHost + widget.list[0]['user_image'])),
              decoration: new BoxDecoration(
                color: Colors.transparent,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (context) => ProfileScreen(
                        host: widget.host, list: widget.list, pic: widget.pic)),
              );
            },
          ),
          new ListTile(
            title: new Text('Profile'),
            leading: Icon(
              CustomIcons.single_01,
              size: 20.0,
            ),
            onTap: () {
              Navigator.pop(context);
//            Navigator.of(context, rootNavigator: true).push(
//              new CupertinoPageRoute<bool>(
//                fullscreenDialog: true,
//                builder: (BuildContext context) => new ProfileScreen(host: host, list: list, pic: pic)),
//              ),
//            );
              Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (context) => ProfileScreen(
                        host: widget.host, list: widget.list, pic: widget.pic)),
              );
            },
          ),
          new ExpansionTile(
            title: new Text(
              'Budgeting',
              style: TextStyle(fontSize: 14.0),
            ),
            leading: Icon(
              CustomIcons.wallet_43,
              size: 20.0,
            ),
            children: <Widget>[
              new ListTile(
                  title: new Text('Budget Proposals'),
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => BudgetProposalScreen(
                              bp: 'depthead',
                              host: widget.host,
                              id: widget.list[0]['id'])),
                    );
                  }),
            ],
          ),
          new ListTile(
              title: new Text('PPMP'),
              leading: Icon(
                CustomIcons.single_folded_content,
                size: 20.0,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => DeptPPMPScreen(
                          host: widget.host,
                          listuser: widget.list,
                          id: widget.list[0]['id'])),
                );
              }),
          new ListTile(
              title: new Text('Purchase Request'),
              leading: Icon(
                CustomIcons.bag_09,
                size: 20.0,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => DeptPRScreen(
                          host: widget.host, id: widget.list[0]['id'])),
                );
              }),
          new ListTile(
            title: new Text('Logout'),
            leading: Icon(
              CustomIcons.uniE820,
              size: 20.0,
            ),
            onTap: //() => Navigator.pushReplacementNamed(context, "/login")
                () => showDialog(
              context: context,
              builder: (BuildContext context) {
                return SingleChildScrollView(
                  child: AlertDialog(
                    title: Text(
                      'Logout',
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 17.0,
                          letterSpacing: 1.0),
                      textAlign: TextAlign.center,
                    ),
                    titlePadding: EdgeInsets.only(top: 15.0),
                    shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(20.0))),
                    contentPadding:
                    EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    content: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            'You are about to logout from this device, click "Ok" to continue',
                            style: TextStyle(
                                fontSize: 14.0,
                                fontStyle: FontStyle.italic),
                            textAlign: TextAlign.center,
                            maxLines: 3,
                          ),
                        ),
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            new FlatButton(
                              child: new Text(
                                "Cancel",
                                style: TextStyle(
                                    color: Color(0xFF19b3b1),
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            new FlatButton(
                              color: Color(0xFF19b3b1),
                              child: new Text(
                                "Ok",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold),
                              ),
                              onPressed: () async {
                                final prefs = await SharedPreferences
                                    .getInstance();
                                prefs.remove('id');
                                prefs.remove('ifStop');
                                Navigator.of(context)
                                    .pushNamedAndRemoveUntil(
                                    '/login',
                                        (Route<dynamic> route) =>
                                    false);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          new Divider(),
          new ListTile(
            title: new Text('Settings'),
            leading: Icon(
              CustomIcons.cog,
              size: 20.0,
            ),
            onTap: () {
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) =>
                          SettingsScreen(host: widget.host, list: widget.list))
                  //Notif()),
                  );
            },
            trailing: IconButton(
              icon: Theme.of(context).brightness == Brightness.light
                  ? Icon(FontAwesomeIcons.moon)
                  : Icon(FontAwesomeIcons.solidMoon),
              onPressed: changeBrightness,
              iconSize: 20.0,
            ),
          ),
        ],
      ));
    } else if (type == '3') {
      if (approverID == widget.list[0]['id']) {
        return Drawer(
            child: new ListView(
          children: <Widget>[
            GestureDetector(
              child: new UserAccountsDrawerHeader(
                accountName: new Text(
                  '${widget.list[0]['name']}',
                  style: new TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.black
                          : Colors.white),
                ),
                accountEmail: new Text(
                  '${widget.list[0]['username']}',
                  style: new TextStyle(
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.black
                          : Colors.white),
                ),
                currentAccountPicture: CircleAvatar(
                    backgroundImage:
                        NetworkImage(newHost + widget.list[0]['user_image'])),
                decoration: new BoxDecoration(
                  color: Colors.transparent,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => ProfileScreen(
                          host: widget.host,
                          list: widget.list,
                          pic: widget.pic)),
                );
              },
            ),
            new ListTile(
              title: new Text('Profile'),
              leading: Icon(
                CustomIcons.single_01,
                size: 20.0,
              ),
              onTap: () {
                Navigator.pop(context);
//            Navigator.of(context, rootNavigator: true).push(
//              new CupertinoPageRoute<bool>(
//                fullscreenDialog: true,
//                builder: (BuildContext context) => new ProfileScreen(host: host, list: list, pic: pic)),
//              ),
//            );
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => ProfileScreen(
                          host: widget.host,
                          list: widget.list,
                          pic: widget.pic)),
                );
              },
            ),
            new ExpansionTile(
              title: new Text(
                'Budgeting',
                style: TextStyle(fontSize: 14.0),
              ),
              leading: Icon(
                CustomIcons.wallet_43,
                size: 20.0,
              ),
              children: <Widget>[
                new ListTile(
                    title: new Text('Budget Allocation'),
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => BudgetAllocationSector(
                                host: widget.host, uid: widget.list[0]['id'])),
                      );
                    }),
              ],
            ),
            new ListTile(
                title: new Text('PPMP'),
                leading: Icon(
                  CustomIcons.single_folded_content,
                  size: 20.0,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => SectorPPMPScreen(
                            host: widget.host,
                            listuser: widget.list,
                            id: widget.list[0]['id'])),
                  );
                }),
            new ListTile(
                title: new Text('Purchase Request'),
                leading: Icon(
                  CustomIcons.bag_09,
                  size: 20.0,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => PurchaseRequestScreen(
                              host: widget.host,
                              listuser: widget.list,
                            )),
                  );
                }),
            new ListTile(
                title: new Text('Logout'),
                leading: Icon(
                  CustomIcons.uniE820,
                  size: 20.0,
                ),
              onTap: //() => Navigator.pushReplacementNamed(context, "/login")
                  () => showDialog(
                context: context,
                builder: (BuildContext context) {
                  return SingleChildScrollView(
                    child: AlertDialog(
                      title: Text(
                        'Logout',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 17.0,
                            letterSpacing: 1.0),
                        textAlign: TextAlign.center,
                      ),
                      titlePadding: EdgeInsets.only(top: 15.0),
                      shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(20.0))),
                      contentPadding:
                      EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      content: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              'You are about to logout from this device, click "Ok" to continue',
                              style: TextStyle(
                                  fontSize: 14.0,
                                  fontStyle: FontStyle.italic),
                              textAlign: TextAlign.center,
                              maxLines: 3,
                            ),
                          ),
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              new FlatButton(
                                child: new Text(
                                  "Cancel",
                                  style: TextStyle(
                                      color: Color(0xFF19b3b1),
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              new FlatButton(
                                color: Color(0xFF19b3b1),
                                child: new Text(
                                  "Ok",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold),
                                ),
                                onPressed: () async {
                                  final prefs = await SharedPreferences
                                      .getInstance();
                                  prefs.remove('id');
                                  prefs.remove('ifStop');
                                  Navigator.of(context)
                                      .pushNamedAndRemoveUntil(
                                      '/login',
                                          (Route<dynamic> route) =>
                                      false);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),),
            new Divider(),
            new ListTile(
              title: new Text('Settings'),
              leading: Icon(
                CustomIcons.cog,
                size: 20.0,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) =>
                          SettingsScreen(host: widget.host, list: widget.list)),
                );
              },
              trailing: IconButton(
                icon: Theme.of(context).brightness == Brightness.light
                    ? Icon(FontAwesomeIcons.moon)
                    : Icon(FontAwesomeIcons.solidMoon),
                onPressed: changeBrightness,
                iconSize: 20.0,
              ),
            ),
          ],
        ));
      } else {
        return Drawer(
            child: new ListView(
          children: <Widget>[
            GestureDetector(
              child: new UserAccountsDrawerHeader(
                accountName: new Text(
                  '${widget.list[0]['name']}',
                  style: new TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.black
                          : Colors.white),
                ),
                accountEmail: new Text(
                  '${widget.list[0]['username']}',
                  style: new TextStyle(
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.black
                          : Colors.white),
                ),
                currentAccountPicture: CircleAvatar(
                    backgroundImage:
                        NetworkImage(newHost + widget.list[0]['user_image'])),
                decoration: new BoxDecoration(
                  color: Colors.transparent,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => ProfileScreen(
                          host: widget.host,
                          list: widget.list,
                          pic: widget.pic)),
                );
              },
            ),
            new ListTile(
              title: new Text('Profile'),
              leading: Icon(
                CustomIcons.single_01,
                size: 20.0,
              ),
              onTap: () {
                Navigator.pop(context);
//            Navigator.of(context, rootNavigator: true).push(
//              new CupertinoPageRoute<bool>(
//                fullscreenDialog: true,
//                builder: (BuildContext context) => new ProfileScreen(host: host, list: list, pic: pic)),
//              ),
//            );
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => ProfileScreen(
                          host: widget.host,
                          list: widget.list,
                          pic: widget.pic)),
                );
              },
            ),
            new ExpansionTile(
              title: new Text(
                'Budgeting',
                style: TextStyle(fontSize: 14.0),
              ),
              leading: Icon(
                CustomIcons.wallet_43,
                size: 20.0,
              ),
              children: <Widget>[
                new ListTile(
                    title: new Text('Budget Allocation'),
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => BudgetAllocationSector(
                                host: widget.host, uid: widget.list[0]['id'])),
                      );
                    }),
              ],
            ),
            new ListTile(
                title: new Text('PPMP'),
                leading: Icon(
                  CustomIcons.single_folded_content,
                  size: 20.0,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => SectorPPMPScreen(
                            host: widget.host,
                            listuser: widget.list,
                            id: widget.list[0]['id'])),
                  );
                }),
            new ListTile(
                title: new Text('Logout'),
                leading: Icon(
                  CustomIcons.uniE820,
                  size: 20.0,
                ),
              onTap: //() => Navigator.pushReplacementNamed(context, "/login")
                  () => showDialog(
                context: context,
                builder: (BuildContext context) {
                  return SingleChildScrollView(
                    child: AlertDialog(
                      title: Text(
                        'Logout',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 17.0,
                            letterSpacing: 1.0),
                        textAlign: TextAlign.center,
                      ),
                      titlePadding: EdgeInsets.only(top: 15.0),
                      shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(20.0))),
                      contentPadding:
                      EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      content: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              'You are about to logout from this device, click "Ok" to continue',
                              style: TextStyle(
                                  fontSize: 14.0,
                                  fontStyle: FontStyle.italic),
                              textAlign: TextAlign.center,
                              maxLines: 3,
                            ),
                          ),
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              new FlatButton(
                                child: new Text(
                                  "Cancel",
                                  style: TextStyle(
                                      color: Color(0xFF19b3b1),
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              new FlatButton(
                                color: Color(0xFF19b3b1),
                                child: new Text(
                                  "Ok",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold),
                                ),
                                onPressed: () async {
                                  final prefs = await SharedPreferences
                                      .getInstance();
                                  prefs.remove('id');
                                  prefs.remove('ifStop');
                                  Navigator.of(context)
                                      .pushNamedAndRemoveUntil(
                                      '/login',
                                          (Route<dynamic> route) =>
                                      false);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),),
            new Divider(),
            new ListTile(
              title: new Text('Settings'),
              leading: Icon(
                CustomIcons.cog,
                size: 20.0,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) =>
                          SettingsScreen(host: widget.host, list: widget.list)),
                );
              },
              trailing: IconButton(
                icon: Theme.of(context).brightness == Brightness.light
                    ? Icon(FontAwesomeIcons.moon)
                    : Icon(FontAwesomeIcons.solidMoon),
                onPressed: changeBrightness,
                iconSize: 20.0,
              ),
            ),
          ],
        ));
      }
    } else if (type == '2') {
      if (approverID == widget.list[0]['id']) {
        return Drawer(
            child: new ListView(
          children: <Widget>[
            GestureDetector(
              child: new UserAccountsDrawerHeader(
                accountName: new Text(
                  '${widget.list[0]['name']}',
                  style: new TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.black
                          : Colors.white),
                ),
                accountEmail: new Text(
                  '${widget.list[0]['username']}',
                  style: new TextStyle(
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.black
                          : Colors.white),
                ),
                currentAccountPicture: CircleAvatar(
                    backgroundImage:
                        NetworkImage(newHost + widget.list[0]['user_image'])),
                decoration: new BoxDecoration(
                  color: Colors.transparent,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => ProfileScreen(
                          host: widget.host,
                          list: widget.list,
                          pic: widget.pic)),
                );
              },
            ),
            new ListTile(
              title: new Text('Profile'),
              leading: Icon(
                CustomIcons.single_01,
                size: 20.0,
              ),
              onTap: () {
                Navigator.pop(context);
//            Navigator.of(context, rootNavigator: true).push(
//              new CupertinoPageRoute<bool>(
//                fullscreenDialog: true,
//                builder: (BuildContext context) => new ProfileScreen(host: host, list: list, pic: pic)),
//              ),
//            );
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => ProfileScreen(
                          host: widget.host,
                          list: widget.list,
                          pic: widget.pic)),
                );
              },
            ),
            new ExpansionTile(
              title: new Text(
                'Budgeting',
                style: TextStyle(fontSize: 14.0),
              ),
              leading: Icon(
                CustomIcons.wallet_43,
                size: 20.0,
              ),
              children: <Widget>[
                new ListTile(
                    title: new Text('Budget Proposals'),
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => BudgetProposalScreen(
                                bp: 'budgetofficer',
                                host: widget.host,
                                id: widget.list[0]['id'])),
                      );
                    }),
                new ListTile(
                    title: new Text('Budget Year'),
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) =>
                                BudgetYearScreen(host: widget.host)),
                      );
                    }),
                new ListTile(
                    title: new Text('Budget Allocation'),
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => BudgetAllocationScreen(
                                host: widget.host, funcId: '1', yearId: '1')),
                      );
                    }),
              ],
            ),
            new ListTile(
                title: new Text('Purchase Request'),
                leading: Icon(
                  CustomIcons.bag_09,
                  size: 20.0,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => PurchaseRequestScreen(
                              host: widget.host,
                              listuser: widget.list,
                            )),
                  );
                }),
            new ListTile(
                title: new Text('Logout'),
                leading: Icon(
                  CustomIcons.uniE820,
                  size: 20.0,
                ),
              onTap: //() => Navigator.pushReplacementNamed(context, "/login")
                  () => showDialog(
                context: context,
                builder: (BuildContext context) {
                  return SingleChildScrollView(
                    child: AlertDialog(
                      title: Text(
                        'Logout',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 17.0,
                            letterSpacing: 1.0),
                        textAlign: TextAlign.center,
                      ),
                      titlePadding: EdgeInsets.only(top: 15.0),
                      shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(20.0))),
                      contentPadding:
                      EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      content: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              'You are about to logout from this device, click "Ok" to continue',
                              style: TextStyle(
                                  fontSize: 14.0,
                                  fontStyle: FontStyle.italic),
                              textAlign: TextAlign.center,
                              maxLines: 3,
                            ),
                          ),
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              new FlatButton(
                                child: new Text(
                                  "Cancel",
                                  style: TextStyle(
                                      color: Color(0xFF19b3b1),
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              new FlatButton(
                                color: Color(0xFF19b3b1),
                                child: new Text(
                                  "Ok",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold),
                                ),
                                onPressed: () async {
                                  final prefs = await SharedPreferences
                                      .getInstance();
                                  prefs.remove('id');
                                  prefs.remove('ifStop');
                                  Navigator.of(context)
                                      .pushNamedAndRemoveUntil(
                                      '/login',
                                          (Route<dynamic> route) =>
                                      false);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),),
            new Divider(),
            new ListTile(
              title: new Text('Settings'),
              leading: Icon(
                CustomIcons.cog,
                size: 20.0,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) =>
                          SettingsScreen(host: widget.host, list: widget.list)),
                );
              },
              trailing: IconButton(
                icon: Theme.of(context).brightness == Brightness.light
                    ? Icon(FontAwesomeIcons.moon)
                    : Icon(FontAwesomeIcons.solidMoon),
                onPressed: changeBrightness,
                iconSize: 20.0,
              ),
            ),
          ],
        ));
      } else {
        return Drawer(
            child: new ListView(
          children: <Widget>[
            GestureDetector(
              child: new UserAccountsDrawerHeader(
                accountName: new Text(
                  '${widget.list[0]['name']}',
                  style: new TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.black
                          : Colors.white),
                ),
                accountEmail: new Text(
                  '${widget.list[0]['username']}',
                  style: new TextStyle(
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.black
                          : Colors.white),
                ),
                currentAccountPicture: CircleAvatar(
                    backgroundImage:
                        NetworkImage(newHost + widget.list[0]['user_image'])),
                decoration: new BoxDecoration(
                  color: Colors.transparent,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => ProfileScreen(
                          host: widget.host,
                          list: widget.list,
                          pic: widget.pic)),
                );
              },
            ),
            new ListTile(
              title: new Text('Profile'),
              leading: Icon(
                CustomIcons.single_01,
                size: 20.0,
              ),
              onTap: () {
                Navigator.pop(context);
//            Navigator.of(context, rootNavigator: true).push(
//              new CupertinoPageRoute<bool>(
//                fullscreenDialog: true,
//                builder: (BuildContext context) => new ProfileScreen(host: host, list: list, pic: pic)),
//              ),
//            );
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => ProfileScreen(
                          host: widget.host,
                          list: widget.list,
                          pic: widget.pic)),
                );
              },
            ),
            new ExpansionTile(
              title: new Text(
                'Budgeting',
                style: TextStyle(fontSize: 14.0),
              ),
              leading: Icon(
                CustomIcons.wallet_43,
                size: 20.0,
              ),
              children: <Widget>[
                new ListTile(
                    title: new Text('Budget Proposals'),
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => BudgetProposalScreen(
                                bp: 'budgetofficer',
                                host: widget.host,
                                id: widget.list[0]['id'])),
                      );
                    }),
                new ListTile(
                    title: new Text('Budget Year'),
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) =>
                                BudgetYearScreen(host: widget.host)),
                      );
                    }),
                new ListTile(
                    title: new Text('Budget Allocation'),
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => BudgetAllocationScreen(
                                host: widget.host, funcId: '1', yearId: '1')),
                      );
                    }),
              ],
            ),
            new ListTile(
                title: new Text('Logout'),
                leading: Icon(
                  CustomIcons.uniE820,
                  size: 20.0,
                ),
              onTap: //() => Navigator.pushReplacementNamed(context, "/login")
                  () => showDialog(
                context: context,
                builder: (BuildContext context) {
                  return SingleChildScrollView(
                    child: AlertDialog(
                      title: Text(
                        'Logout',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 17.0,
                            letterSpacing: 1.0),
                        textAlign: TextAlign.center,
                      ),
                      titlePadding: EdgeInsets.only(top: 15.0),
                      shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(20.0))),
                      contentPadding:
                      EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      content: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              'You are about to logout from this device, click "Ok" to continue',
                              style: TextStyle(
                                  fontSize: 14.0,
                                  fontStyle: FontStyle.italic),
                              textAlign: TextAlign.center,
                              maxLines: 3,
                            ),
                          ),
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              new FlatButton(
                                child: new Text(
                                  "Cancel",
                                  style: TextStyle(
                                      color: Color(0xFF19b3b1),
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              new FlatButton(
                                color: Color(0xFF19b3b1),
                                child: new Text(
                                  "Ok",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold),
                                ),
                                onPressed: () async {
                                  final prefs = await SharedPreferences
                                      .getInstance();
                                  prefs.remove('id');
                                  prefs.remove('ifStop');
                                  Navigator.of(context)
                                      .pushNamedAndRemoveUntil(
                                      '/login',
                                          (Route<dynamic> route) =>
                                      false);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),),
            new Divider(),
            new ListTile(
              title: new Text('Settings'),
              leading: Icon(
                CustomIcons.cog,
                size: 20.0,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) =>
                          SettingsScreen(host: widget.host, list: widget.list)),
                );
              },
              trailing: IconButton(
                icon: Theme.of(context).brightness == Brightness.light
                    ? Icon(FontAwesomeIcons.moon)
                    : Icon(FontAwesomeIcons.solidMoon),
                onPressed: changeBrightness,
                iconSize: 20.0,
              ),
            ),
          ],
        ));
      }
    } else if (type == '5') {
      if (approverID == widget.list[0]['id']) {
        return Drawer(
            child: new ListView(
          children: <Widget>[
            GestureDetector(
              child: new UserAccountsDrawerHeader(
                accountName: new Text(
                  '${widget.list[0]['name']}',
                  style: new TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.black
                          : Colors.white),
                ),
                accountEmail: new Text(
                  '${widget.list[0]['username']}',
                  style: new TextStyle(
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.black
                          : Colors.white),
                ),
                currentAccountPicture: CircleAvatar(
                    backgroundImage:
                        NetworkImage(newHost + widget.list[0]['user_image'])),
                decoration: new BoxDecoration(
                  color: Colors.transparent,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => ProfileScreen(
                          host: widget.host,
                          list: widget.list,
                          pic: widget.pic)),
                );
              },
            ),
            new ListTile(
              title: new Text('Profile'),
              leading: Icon(
                CustomIcons.single_01,
                size: 20.0,
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => ProfileScreen(
                          host: widget.host,
                          list: widget.list,
                          pic: widget.pic)),
                );
              },
            ),
            new ExpansionTile(
              title: new Text(
                'APP',
                style: TextStyle(fontSize: 14.0),
              ),
              leading: Icon(
                CustomIcons.wallet_43,
                size: 20.0,
              ),
              children: <Widget>[
                new ListTile(
                    title: new Text('CSE'),
                    onTap: () {
                      List splithost = widget.host.split('/');
                      var newHost = 'http://${splithost[2]}:8000/mobile/app_cse';
                      launch(newHost);
                    }),
                new ListTile(
                    title: new Text('Non-CSE'),
                    onTap: () {
                      List splithost = widget.host.split('/');
                      var newHost = 'http://${splithost[2]}:8000/mobile/app_non_cse';
                      launch(newHost);
                    }),
              ],
            ),
            new ListTile(
                title: new Text('Purchase Request'),
                leading: Icon(
                  CustomIcons.bag_09,
                  size: 20.0,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => PurchaseRequestScreen(
                              host: widget.host,
                              listuser: widget.list,
                            )),
                  );
                }),
            new ListTile(
                title: new Text('Logout'),
                leading: Icon(
                  CustomIcons.uniE820,
                  size: 20.0,
                ),
              onTap: //() => Navigator.pushReplacementNamed(context, "/login")
                  () => showDialog(
                context: context,
                builder: (BuildContext context) {
                  return SingleChildScrollView(
                    child: AlertDialog(
                      title: Text(
                        'Logout',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 17.0,
                            letterSpacing: 1.0),
                        textAlign: TextAlign.center,
                      ),
                      titlePadding: EdgeInsets.only(top: 15.0),
                      shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(20.0))),
                      contentPadding:
                      EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      content: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              'You are about to logout from this device, click "Ok" to continue',
                              style: TextStyle(
                                  fontSize: 14.0,
                                  fontStyle: FontStyle.italic),
                              textAlign: TextAlign.center,
                              maxLines: 3,
                            ),
                          ),
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              new FlatButton(
                                child: new Text(
                                  "Cancel",
                                  style: TextStyle(
                                      color: Color(0xFF19b3b1),
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              new FlatButton(
                                color: Color(0xFF19b3b1),
                                child: new Text(
                                  "Ok",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold),
                                ),
                                onPressed: () async {
                                  final prefs = await SharedPreferences
                                      .getInstance();
                                  prefs.remove('id');
                                  prefs.remove('ifStop');
                                  Navigator.of(context)
                                      .pushNamedAndRemoveUntil(
                                      '/login',
                                          (Route<dynamic> route) =>
                                      false);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),),
            new Divider(),
            new ListTile(
              title: new Text('Settings'),
              leading: Icon(
                CustomIcons.cog,
                size: 20.0,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) =>
                          SettingsScreen(host: widget.host, list: widget.list)),
                );
              },
              trailing: IconButton(
                icon: Theme.of(context).brightness == Brightness.light
                    ? Icon(FontAwesomeIcons.moon)
                    : Icon(FontAwesomeIcons.solidMoon),
                onPressed: changeBrightness,
                iconSize: 20.0,
              ),
            ),
          ],
        ));
      } else {
        return Drawer(
            child: new ListView(
          children: <Widget>[
            GestureDetector(
              child: new UserAccountsDrawerHeader(
                accountName: new Text(
                  '${widget.list[0]['name']}',
                  style: new TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.black
                          : Colors.white),
                ),
                accountEmail: new Text(
                  '${widget.list[0]['username']}',
                  style: new TextStyle(
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.black
                          : Colors.white),
                ),
                currentAccountPicture: CircleAvatar(
                    backgroundImage:
                        NetworkImage(newHost + widget.list[0]['user_image'])),
                decoration: new BoxDecoration(
                  color: Colors.transparent,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => ProfileScreen(
                          host: widget.host,
                          list: widget.list,
                          pic: widget.pic)),
                );
              },
            ),
            new ListTile(
              title: new Text('Profile'),
              leading: Icon(
                CustomIcons.single_01,
                size: 20.0,
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => ProfileScreen(
                          host: widget.host,
                          list: widget.list,
                          pic: widget.pic)),
                );
              },
            ),
            new ExpansionTile(
              title: new Text(
                'APP',
                style: TextStyle(fontSize: 14.0),
              ),
              leading: Icon(
                CustomIcons.wallet_43,
                size: 20.0,
              ),
              children: <Widget>[
                new ListTile(
                    title: new Text('CSE'),
                    onTap: () {
                      List splithost = widget.host.split('/');
                      var newHost = 'http://${splithost[2]}:8000/mobile/app_cse';
                      launch(newHost);
                    }),
                new ListTile(
                    title: new Text('Non-CSE'),
                    onTap: () {
                      List splithost = widget.host.split('/');
                      var newHost = 'http://${splithost[2]}:8000/mobile/app_non_cse';
                      launch(newHost);
                    }),
              ],
            ),
            new ListTile(
                title: new Text('Logout'),
                leading: Icon(
                  CustomIcons.uniE820,
                  size: 20.0,
                ),
              onTap: //() => Navigator.pushReplacementNamed(context, "/login")
                  () => showDialog(
                context: context,
                builder: (BuildContext context) {
                  return SingleChildScrollView(
                    child: AlertDialog(
                      title: Text(
                        'Logout',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 17.0,
                            letterSpacing: 1.0),
                        textAlign: TextAlign.center,
                      ),
                      titlePadding: EdgeInsets.only(top: 15.0),
                      shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(20.0))),
                      contentPadding:
                      EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      content: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              'You are about to logout from this device, click "Ok" to continue',
                              style: TextStyle(
                                  fontSize: 14.0,
                                  fontStyle: FontStyle.italic),
                              textAlign: TextAlign.center,
                              maxLines: 3,
                            ),
                          ),
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              new FlatButton(
                                child: new Text(
                                  "Cancel",
                                  style: TextStyle(
                                      color: Color(0xFF19b3b1),
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              new FlatButton(
                                color: Color(0xFF19b3b1),
                                child: new Text(
                                  "Ok",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold),
                                ),
                                onPressed: () async {
                                  final prefs = await SharedPreferences
                                      .getInstance();
                                  prefs.remove('id');
                                  prefs.remove('ifStop');
                                  Navigator.of(context)
                                      .pushNamedAndRemoveUntil(
                                      '/login',
                                          (Route<dynamic> route) =>
                                      false);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),),
            new Divider(),
            new ListTile(
              title: new Text('Settings'),
              leading: Icon(
                CustomIcons.cog,
                size: 20.0,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) =>
                          SettingsScreen(host: widget.host, list: widget.list)),
                );
              },
              trailing: IconButton(
                icon: Theme.of(context).brightness == Brightness.light
                    ? Icon(FontAwesomeIcons.moon)
                    : Icon(FontAwesomeIcons.solidMoon),
                onPressed: changeBrightness,
                iconSize: 20.0,
              ),
            ),
          ],
        ));
      }
    } else {
      return Drawer(
          child: new ListView(
        children: <Widget>[
          GestureDetector(
            child: new UserAccountsDrawerHeader(
              accountName: new Text(
                '${widget.list[0]['name']}',
                style: new TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.black
                        : Colors.white),
              ),
              accountEmail: new Text(
                '${widget.list[0]['username']}',
                style: new TextStyle(
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.black
                        : Colors.white),
              ),
              currentAccountPicture: CircleAvatar(
                  backgroundImage:
                      NetworkImage(newHost + widget.list[0]['user_image'])),
              decoration: new BoxDecoration(
                color: Colors.transparent,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (context) => ProfileScreen(
                        host: widget.host, list: widget.list, pic: widget.pic)),
              );
            },
          ),
          new ListTile(
            title: new Text('Profile'),
            leading: Icon(
              CustomIcons.single_01,
              size: 20.0,
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (context) => ProfileScreen(
                        host: widget.host, list: widget.list, pic: widget.pic)),
              );
            },
          ),
          new ListTile(
              title: new Text('Logout'),
              leading: Icon(
                CustomIcons.uniE820,
                size: 20.0,
              ),
            onTap: //() => Navigator.pushReplacementNamed(context, "/login")
                () => showDialog(
              context: context,
              builder: (BuildContext context) {
                return SingleChildScrollView(
                  child: AlertDialog(
                    title: Text(
                      'Logout',
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 17.0,
                          letterSpacing: 1.0),
                      textAlign: TextAlign.center,
                    ),
                    titlePadding: EdgeInsets.only(top: 15.0),
                    shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(20.0))),
                    contentPadding:
                    EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    content: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            'You are about to logout from this device, click "Ok" to continue',
                            style: TextStyle(
                                fontSize: 14.0,
                                fontStyle: FontStyle.italic),
                            textAlign: TextAlign.center,
                            maxLines: 3,
                          ),
                        ),
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            new FlatButton(
                              child: new Text(
                                "Cancel",
                                style: TextStyle(
                                    color: Color(0xFF19b3b1),
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            new FlatButton(
                              color: Color(0xFF19b3b1),
                              child: new Text(
                                "Ok",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold),
                              ),
                              onPressed: () async {
                                final prefs = await SharedPreferences
                                    .getInstance();
                                prefs.remove('id');
                                prefs.remove('ifStop');
                                Navigator.of(context)
                                    .pushNamedAndRemoveUntil(
                                    '/login',
                                        (Route<dynamic> route) =>
                                    false);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),),
          new Divider(),
          new ListTile(
            title: new Text('Settings'),
            leading: Icon(
              CustomIcons.cog,
              size: 20.0,
            ),
            onTap: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (context) =>
                        SettingsScreen(host: widget.host, list: widget.list)),
              );
            },
            trailing: IconButton(
              icon: Theme.of(context).brightness == Brightness.light
                  ? Icon(FontAwesomeIcons.moon)
                  : Icon(FontAwesomeIcons.solidMoon),
              onPressed: changeBrightness,
              iconSize: 20.0,
            ),
          ),
        ],
      ));
    }
  }

  Widget build(BuildContext context) {
    timeDilation = 1.0; // 1.0 means normal animation speed.
    return FutureBuilder<String>(
        future: getApprover(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
          }
          if (snapshot.hasData) {
            return drawerIndicator(
                widget.list[0]['user_type_id'], snapshot.data);
          } else {
            return drawerIndicator(
                widget.list[0]['user_type_id'], snapshot.data);
          }
        });
  }

  void changeBrightness() {
    DynamicTheme.of(context).setBrightness(
        Theme.of(context).brightness == Brightness.dark
            ? Brightness.light
            : Brightness.dark);
  }
}
