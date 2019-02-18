import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

var flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();

// NOTE: if you want to find out if the app was launched via notification then you could use the following call and then do something like
// change the default route of the app
// var notificationAppLaunchDetails =
//     await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

class Notif extends StatefulWidget {
  @override
  _NotifState createState() => new _NotifState();
}

class _NotifState extends State<Notif> {
 // var platform = MethodChannel('crossingthestreams.io/resourceResolver');

  @override
  initState() {
    super.initState();
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    var initializationSettingsAndroid =
    new AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = new IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidRecieveLocalNotification);
    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Plugin example app'),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: new Padding(
            padding: new EdgeInsets.all(8.0),
            child: new Center(
              child: new Column(
                children: <Widget>[
                  new Padding(
                    padding: new EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 8.0),
                    child: new Text(
                        'Tap on a notification when it appears to trigger navigation'),
                  ),
                  new Padding(
                    padding: new EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 8.0),
                    child: new RaisedButton(
                      child: new Text('Show plain notification with payload'),
                      onPressed: () async {
                        await _showNotification();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future _showNotification() async {
    var scheduledNotificationDateTime =
    new DateTime.now().add(new Duration(seconds: 5));
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.Max, priority: Priority.High);
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
//    await flutterLocalNotificationsPlugin.show(
//        0, 'Trial!', 'Trial trial', platformChannelSpecifics,
//        payload: 'trial name');
    await flutterLocalNotificationsPlugin.schedule(
        0,
        'scheduled trial',
        'scheduled trial',
        scheduledNotificationDateTime,
        platformChannelSpecifics);
  }

  Future onSelectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }

    await Navigator.push(
      context,
      new MaterialPageRoute(builder: (context) => new SecondScreen(payload)),
    );
  }

  Future onDidRecieveLocalNotification(
      int id, String title, String body, String payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    showDialog(
      context: context,
      builder: (BuildContext context) => new CupertinoAlertDialog(
        title: new Text(title),
        content: new Text(body),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: new Text('Ok'),
            onPressed: () async {
              Navigator.of(context, rootNavigator: true).pop();
              await Navigator.push(
                context,
                new MaterialPageRoute(
                  builder: (context) => new SecondScreen(payload),
                ),
              );
            },
          )
        ],
      ),
    );
  }


}

class SecondScreen extends StatefulWidget {
  final String payload;
  SecondScreen(this.payload);
  @override
  State<StatefulWidget> createState() => new SecondScreenState();
}

class SecondScreenState extends State<SecondScreen> {
  String _payload;
  @override
  void initState() {
    super.initState();
    _payload = widget.payload;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Second Screen: " + _payload,
          style: TextStyle(
            fontSize: 14.0
          ),
        ),
      ),
      body: new Center(
        child: new RaisedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: new Text('Go back!'),
        ),
      ),
    );
  }
}
