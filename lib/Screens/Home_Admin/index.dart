import 'package:flutter/material.dart';
import '../../Components/HomeBottomAppBar.dart';
import '../../Components/HomeDrawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../Components/custom_icons.dart';
import 'HomeDashboard2.dart';
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
    void _showDialog() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: AlertDialog(
              title: Container(
                height: MediaQuery.of(context).orientation == Orientation.portrait ? 150.0 : 250,
                width: double.infinity,
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: new AssetImage(
                        "assets/images/alert.png"),
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
                  child: new Text("Close",
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold
                    ),
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
    Widget page;
    var iconD;
    var onP;
    if(_current == 'TAB: 0'){
      _page_title = 'Dashboard';
      page = new HomeDashboard2();
      iconD = Image.asset('assets/icons/pLogo.png',width: 150.0,height: 150.0,);
      onP = _showDialog;
    }
    else if(_current == 'TAB: 1'){
      _page_title = 'For Approval';
      page = new HomeApproval();
      iconD = Icon(CustomIcons.uniE86F,
      color: Colors.blueGrey,
      );
    }
    else if(_current == 'TAB: 2'){
      _page_title = 'My Requests';
      page = new HomeRequests();
      iconD = Icon(CustomIcons.uniE86F,
        color: Colors.blueGrey,
      );
    }
    else{
      _page_title = 'Notifications';
      page = new HomeNotifs(_page_title);
      iconD = Image.asset('assets/icons/pLogo.png',width: 150.0,height: 150.0,);
      onP = _showDialog;
    }
    return Scaffold(
      key: _scaffoldKey,
      drawer: new HomeDrawer(),
      appBar: new AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor:Colors.transparent,
        leading: IconButton(
              icon: Image.asset('assets/images/user1.png',width: 30.0,height: 30.0,),
              onPressed: () => _scaffoldKey.currentState.openDrawer()
        ),
        title: new Text(
          _page_title,
          style: new TextStyle(
              color: Theme.of(context).brightness == Brightness.light? Colors.black:Colors.white,
              fontSize: 15.0,
              letterSpacing: 1.5,
              fontWeight: FontWeight.w900
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: iconD,
            onPressed: onP,
          )
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
          HomeBottomAppBarItem(iconData: CustomIcons.chart_bar, count:0),
          HomeBottomAppBarItem(iconData: CustomIcons.ok, count:0),
          HomeBottomAppBarItem(iconData: CustomIcons.paper_plane_empty,  count:0),
          HomeBottomAppBarItem(iconData: CustomIcons.bell, count:5),
        ],
      ),
    );
  }

}