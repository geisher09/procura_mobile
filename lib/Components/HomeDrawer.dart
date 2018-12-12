import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'custom_icons.dart';

class HomeDrawer extends StatefulWidget {
  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer>{
  bool _isClicked = true;

  void _toggleMoon() {
    setState(() {
      if(_isClicked){
        _isClicked=false;
      }
      else{
        _isClicked=true;
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: new ListView(
      children: <Widget>[
        new UserAccountsDrawerHeader(
          accountName: new Text(
            'Geisher Bernabe',
            style:
                new TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          accountEmail: new Text(
            'macncheeze00@gmail.com',
            style:
                new TextStyle(color: Colors.black),
          ),
          currentAccountPicture: CircleAvatar(
            backgroundImage: AssetImage('assets/images/user.png'),
          ),
          decoration: new BoxDecoration(color: Colors.white),
        ),
        new ListTile(
          title: new Text('Profile'),
          leading: Icon(CustomIcons.uniE82A),
        ),
        new ListTile(
          title: new Text('Budget Proposal'),
          leading: Icon(FontAwesomeIcons.moneyBillAlt),
        ),
        new ListTile(
          title: new Text('PPMP'),
          leading: Icon(CustomIcons.briefcase_24),
        ),
        new ListTile(
          title: new Text('Purchase Request'),
          leading: Icon(CustomIcons.bag_09),
        ),
        new ListTile(
          title: new Text('Logout'),
          leading: Icon(CustomIcons.uniE820),
          onTap: () => Navigator.pushReplacementNamed(context, "/login"),
        ),
        new Divider(
          color: Colors.black,
        ),
        new ListTile(
          leading: (_isClicked)?Icon(FontAwesomeIcons.moon):Icon(FontAwesomeIcons.solidMoon),
          onTap: _toggleMoon,
        )
      ],
    ));
  }
}
