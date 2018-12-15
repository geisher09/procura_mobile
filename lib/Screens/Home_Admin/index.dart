import 'package:flutter/material.dart';
import '../../Components/HomeBottomAppBar.dart';
import '../../Components/HomeDrawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../Components/custom_icons.dart';

class Home_AdminScreen extends StatefulWidget {
  @override
  _Home_AdminScreenState createState() => _Home_AdminScreenState();
}

class _Home_AdminScreenState extends State<Home_AdminScreen> {
  String _current = 'TAB: 0';

  void _selectedTab(int index) {
    setState(() {
      _current = 'TAB: $index';
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: new HomeDrawer(
      ),
      appBar: new AppBar(
        backgroundColor:Theme.of(context).brightness == Brightness.light? Colors.white:Color(0xFF202020),
        leading: new IconButton(
            icon: Image.asset('assets/images/user.png'),
            onPressed: () => _scaffoldKey.currentState.openDrawer()
        ),
        title: new Text(
            'Procura',
          style: new TextStyle(
              color: Theme.of(context).brightness == Brightness.light? Colors.black:Colors.white,
              fontSize: 25.0,
              letterSpacing: 2.5,
              fontWeight: FontWeight.bold
          ),
        ),
        actions: <Widget>[
        ],
      ),
      body: Center(
        child: Text(
          _current,
          style: TextStyle(fontSize: 30.0),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: HomeBottomAppBar(
        selectedColor: Colors.blueAccent,
        notchedShape: CircularNotchedRectangle(),
        onTabSelected: _selectedTab,
        items: [
          HomeBottomAppBarItem(iconData: CustomIcons.dashboard_level_1, text: 'Dashboard'),
          HomeBottomAppBarItem(iconData: FontAwesomeIcons.edit, text: 'For Approval'),
          HomeBottomAppBarItem(iconData: FontAwesomeIcons.shareSquare, text: 'My Requests'),
          HomeBottomAppBarItem(iconData: FontAwesomeIcons.bell, text: 'Notifications'),
        ],
      ),
    );
  }

}