import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'custom_icons.dart';
import 'package:dynamic_theme/dynamic_theme.dart';

class HomeDrawer extends StatefulWidget {
  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer>{

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: new ListView(
      children: <Widget>[
        new UserAccountsDrawerHeader(
          accountName: new Text(
            'Geisher Bernabe',
            style:
                new TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).brightness == Brightness.light? Colors.black:Colors.white),
          ),
          accountEmail: new Text(
            'macncheeze00@gmail.com',
            style: new TextStyle(
              color: Theme.of(context).brightness == Brightness.light? Colors.black:Colors.white
            ),
          ),
          currentAccountPicture: CircleAvatar(
            backgroundImage: AssetImage('assets/images/user.png'),
          ),
          decoration: new BoxDecoration(
            color: Theme.of(context).brightness == Brightness.light? Colors.white:Color(0xFF202020),

    ),
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
        ),
        new ListTile(
          title: new Text('Night Mode'),
          trailing: Theme.of(context).brightness == Brightness.light?Icon(FontAwesomeIcons.moon):Icon(FontAwesomeIcons.solidMoon),
          onTap: changeBrightness,
        )
      ],
    ));
  }

  void changeBrightness() {
    DynamicTheme.of(context).setBrightness(Theme.of(context).brightness == Brightness.dark? Brightness.light: Brightness.dark);
  }


}
