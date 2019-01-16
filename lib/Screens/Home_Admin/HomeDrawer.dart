import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:procura/Components/custom_icons.dart';
import 'package:procura/Screens/Home_Admin/BudgetProposalScreen.dart';
import 'package:procura/Screens/Home_Admin/PPMPScreen.dart';
import 'package:procura/Screens/Home_Admin/ProfileScreen.dart';
import 'package:procura/Screens/Home_Admin/PurchaseRequestScreen.dart';
import 'package:procura/Screens/Home_Admin/SettingsScreen.dart';
import 'package:procura/Screens/Home_Admin/sampscreen1.dart';
import 'package:procura/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomeDrawer extends StatefulWidget {
  final List list;
  final String pic;
  HomeDrawer({this.list, this.pic});
  @override
  _HomeDrawerState createState() => _HomeDrawerState(list,pic);
}

class _HomeDrawerState extends State<HomeDrawer> {
  _HomeDrawerState(this.list,this.pic);
  final List list;
  final String pic;

  Future<List> getData() async {
    final prefs = await SharedPreferences.getInstance();
    final Id = prefs.getString('id') ?? '0';

    final response = await http
        .post("${host}/getUserData.php", body: {"id": Id.replaceAll("\"", "")});
    return json.decode(response.body);
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: new ListView(
      children: <Widget>[
        GestureDetector(
          child: new UserAccountsDrawerHeader(
            accountName: new Text(
              '${list[0]['name']}',
              style: new TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.black
                      : Colors.white),
            ),
            accountEmail: new Text(
              '${list[0]['username']}',
              style: new TextStyle(
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.black
                      : Colors.white),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(host+list[0]['user_image'])
            ),
            decoration: new BoxDecoration(
              color: Colors.transparent,
            ),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfileScreen(list: list, pic: pic)),
            );
          },
        ),
        new ListTile(
          title: new Text('Profile'),
          leading: Icon(
            CustomIcons.uniE82A,
            size: 20.0,
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfileScreen(list: list, pic: pic)),
            );
          },
        ),
        new ListTile(
          title: new Text('Budget Proposal'),
          leading: Icon(
            FontAwesomeIcons.moneyBillAlt,
            size: 20.0,
          ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BudgetProposalScreen()),
              );
            }
        ),
        new ListTile(
          title: new Text('PPMP'),
          leading: Icon(
            CustomIcons.briefcase_24,
            size: 20.0,
          ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PPMPScreen()),
              );
            }
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
                MaterialPageRoute(builder: (context) => PurchaseRequestScreen()),
              );
            }
        ),
        new ListTile(
          title: new Text('Logout'),
          leading: Icon(
            CustomIcons.uniE820,
            size: 20.0,
          ),
          onTap: //() => Navigator.pushReplacementNamed(context, "/login"),
              () async {
            final prefs = await SharedPreferences.getInstance();
            prefs.remove('id');
            prefs.remove('ifStop');
            Navigator.of(context).popAndPushNamed('/login');
          }
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
              MaterialPageRoute(builder: (context) => SettingsScreen()),
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

  void changeBrightness() {
    DynamicTheme.of(context).setBrightness(
        Theme.of(context).brightness == Brightness.dark
            ? Brightness.light
            : Brightness.dark);
  }
}
