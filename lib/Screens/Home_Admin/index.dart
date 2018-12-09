import 'package:flutter/material.dart';
import '../../Components/HomeBottomAppBar.dart';

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
      drawer: new Drawer(
        child: new Text(
          '\n\n\n\t\tDRAWER',
          style: new TextStyle(
            fontSize: 20.0
          ),
        ),
      ),
      appBar: new AppBar(
        leading: new IconButton(
            icon: Icon(Icons.menu),
            color: Colors.black38,
            onPressed: () => _scaffoldKey.currentState.openDrawer()
        ),
        title: new Text(
            'Procura',
          style: new TextStyle(
            color: Colors.black,
              fontSize: 25.0,
              letterSpacing: 0.5,
              fontWeight: FontWeight.bold
          ),
        ),
        backgroundColor: Colors.white,
        actions: <Widget>[
          new Center(
            child: new Text(
              'Hello Geisher!',
              style: TextStyle(color: Colors.black),
            ),
          ),
          new IconButton(
              icon: Image.asset('assets/images/user.png'),
              onPressed: () {}
              ),
        ],
      ),
      body: Center(
        child: Text(
          _current,
          style: TextStyle(fontSize: 30.0),
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        backgroundColor: Colors.black45,
        child: new Icon(Icons.arrow_back),
        elevation: 2.0,
        onPressed: () => Navigator.pushReplacementNamed(context, "/login"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: HomeBottomAppBar(
        color: Colors.black38,
        selectedColor: Colors.blueAccent,
        notchedShape: CircularNotchedRectangle(),
        onTabSelected: _selectedTab,
        items: [
          HomeBottomAppBarItem(iconData: Icons.dashboard, text: 'Dashboard'),
          HomeBottomAppBarItem(iconData: Icons.account_balance_wallet, text: 'Budget'),
          HomeBottomAppBarItem(iconData: Icons.explore, text: 'Track'),
          HomeBottomAppBarItem(iconData: Icons.notifications, text: 'Notifs'),
        ],
      ),
    );
  }
}
