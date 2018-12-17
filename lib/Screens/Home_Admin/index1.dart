import 'package:flutter/material.dart';

class page extends StatelessWidget {
  String title;
  page(this.title);
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Center(
        child:  new Text(title),
      ),
    );
  }
}

class zone extends StatefulWidget {
  @override
  _zoneState createState() => _zoneState();
}

class _zoneState extends State<zone> with SingleTickerProviderStateMixin{
  TabController tabController;
//here in the initstate we assign the tabcontroller and give it a length and vsyc for animation.
  @override
  void initState(){
    super.initState();
    tabController = new TabController(length: 3,vsync: this);
  }
//dispose method for good practice.
  @override
  void dispose(){
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(appBar:  new AppBar(title: new Text('Tabbed page'),),
//here we define our TabBarView.
        body: new TabBarView(
          children: <Widget>[
            new page("TAB 1"),new page('TAB 2'),new page('TAB 3')
          ],
          controller: tabController,
        ),
//now we can just create a bottomnavigationBar under our scaffold
        bottomNavigationBar:new Material(
          child: new TabBar(
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.black38,
            controller: tabController,
            indicatorColor: Colors.white,
            tabs: <Widget>[
              new Tab(
                child: new Icon(Icons.star),
              ),
              new Tab(
                child: new Icon(Icons.favorite),
              ),
              new Tab(
                child: new Icon(Icons.headset),
              ),
            ],
          ),
        )
    );//scaffold
  }
}
