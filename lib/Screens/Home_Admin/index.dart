import 'package:flutter/material.dart';
import '../../Components/HomeBottomAppBar.dart';
import '../../Components/HomeDrawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../Components/custom_icons.dart';
import 'HomeDashboard.dart';
import 'HomeApproval.dart';
import 'HomeRequests.dart';
import 'HomeNotifs.dart';

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

    String _page_title;
    Widget page;
    if(_current == 'TAB: 0'){
      _page_title = 'Dashboard';
      page = new HomeDashboard();
    }
    else if(_current == 'TAB: 1'){
      _page_title = 'For Approval';
      page = new HomeApproval(_page_title);
    }
    else if(_current == 'TAB: 2'){
      _page_title = 'My Requests';
      page = new HomeRequests(_page_title);
    }
    else{
      _page_title = 'Notifications';
      page = new HomeNotifs(_page_title);
    }
    return Scaffold(
      key: _scaffoldKey,
      drawer: new HomeDrawer(),
      appBar: new AppBar(
        backgroundColor:Theme.of(context).brightness == Brightness.light? Colors.white:Color(0xFF202020),
        leading: new IconButton(
            icon: Image.asset('assets/images/user.png'),
            onPressed: () => _scaffoldKey.currentState.openDrawer()
        ),
        title: new Text(
          _page_title,
          style: new TextStyle(
              color: Theme.of(context).brightness == Brightness.light? Colors.black:Colors.white,
              fontSize: 25.0,
              letterSpacing: 2.5,
              fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
        ],
      ),
      body: Center(
        child: page
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