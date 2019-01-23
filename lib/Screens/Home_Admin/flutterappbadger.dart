import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';

class MyAppbadger extends StatefulWidget {
  @override
  _MyAppbadgerState createState() => new _MyAppbadgerState();
}

class _MyAppbadgerState extends State<MyAppbadger> {
  String _appBadgeSupported = 'Unknowns';

  @override
  initState() {
    super.initState();
    initPlatformState();
  }

  initPlatformState() async {
    String appBadgeSupported;
    try {
      bool res = await FlutterAppBadger.isAppBadgeSupported();
      if (res) {
        appBadgeSupported = 'Supported';
      } else {
        appBadgeSupported = 'Not supported';
      }
    } on PlatformException {
      appBadgeSupported = 'Failed to get badge support.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _appBadgeSupported = appBadgeSupported;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Plugin example app'),
        ),
        body: new SizedBox.expand(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Text('Badge supported: $_appBadgeSupported\n'),
              new RaisedButton(
                child: new Text('Add badge'),
                onPressed: () {
                  _addBadge();
                },
              ),
              new RaisedButton(
                  child: new Text('Remove badge'),
                  onPressed: () {
                    _removeBadge();
                  }),
            ],
          ),
        ),
      ),
    );
  }

  void _addBadge() {
    FlutterAppBadger.updateBadgeCount(5);
  }

  void _removeBadge() {
    FlutterAppBadger.removeBadge();
  }
}