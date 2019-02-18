import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:procura/Components/custom_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';
import 'dart:ui';
import 'package:flutter/rendering.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LoginScreen extends StatefulWidget {
  //const LoginScreen({Key key}) : super(key: key);
  final String host;
  LoginScreen({this.host});
  @override
  _LoginScreenState createState() => _LoginScreenState(host);
}

class _LoginScreenState extends State<LoginScreen> {
  _LoginScreenState(this.host);
  final String host;
  final GlobalKey<ScaffoldState> _scaffoldState = new GlobalKey<ScaffoldState>();

  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

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

  void loginProcess(BuildContext context)async {
    print(usernameController.text + ',' + passwordController.text);
    print(host);
    var url = "$host/login.php";
    final response = await
    http.post(url,body: {
      "username" : usernameController.text,
      "password" : passwordController.text,
    });
    if(response.body == '"0"'){
      final snackBar = new SnackBar(
        content: new Text('User unrecognized! (username/password incorrect)'),
      );
      _scaffoldState.currentState.showSnackBar(snackBar);
    }
    else{
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('id',response.body.toString());
      await new Future.delayed(const Duration(seconds: 1));
      Navigator.pushReplacementNamed(context, "/home");
      //await _showNotification();
    }
  }
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);

    TextStyle cardButtonStyle = Theme.of(context).textTheme.title.copyWith(
          fontSize: 16.0,
          color: Colors.white,
          letterSpacing: 0.3,
        );

    var width = MediaQuery.of(context).size.width / 1.5;

    return new Scaffold(
      //resizeToAvoidBottomPadding: false,
      key: _scaffoldState,
      backgroundColor: Colors.white,
      body: new Stack(
        fit: StackFit.expand,
        children: <Widget>[
          new Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("assets/images/tup.PNG"),
                fit: BoxFit.cover,
              ),
            ),
            child: new BackdropFilter(
              filter: new ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
              child: new Container(
                decoration: new BoxDecoration(
                  color: Colors.white.withOpacity(0.0),
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height / 6,
                ),
                new Container(
                  padding: EdgeInsets.only(left: 30.0, right: 30.0),
                  child: new Card(
                    color: Colors.white,
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0)),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Column(children: <Widget>[
                        Container(
                          height: 150.0,
                          width: double.infinity,
                          decoration: new BoxDecoration(
                            image: new DecorationImage(
                              image: new AssetImage(
                                  "assets/images/tup_gradient.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: new Stack(
                            children: <Widget>[
                              new Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    new Text(
                                      "PROCURA",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Montserrat',
                                          fontSize: 30.0,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 5.0),
                                    ),
                                    new Text(
                                      'Better Procurement System.',
                                      style: new TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    new Text(
                                      'Better Work Place.',
                                      style: new TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        new FractionalTranslation(
                          translation: Offset(0.0, -0.5),
                          child: new Image(
                            image: new AssetImage("assets/images/logo.png"),
                            height: 70.0,
                            width: 70.0,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                        new FractionalTranslation(
                          translation: Offset(0.0, -0.3),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                            child: new Column(
                              children: <Widget>[
                                new Container(
                                  decoration: new BoxDecoration(
                                    border: new Border.all(
                                      color: Colors.grey,
                                      width: 1.0,
                                    ),
                                  ),
                                  child: new TextFormField(
                                    controller: usernameController,
                                    obscureText: false,
                                    style: const TextStyle(
                                      color: Colors.black,
                                    ),
                                    decoration: new InputDecoration(
                                      icon: Padding(
                                        padding: const EdgeInsets.only(left:8.0),
                                        child: new Icon(
                                          CustomIcons.single_01,
                                          color: Colors.black,
                                          size: 15.0,
                                        ),
                                      ),
                                      border: InputBorder.none,
                                      hintText: "Username",
                                      hintStyle: const TextStyle(color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w500),
                                      contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                    ),
                                  ),
                                ),
                                new Container(
                                  height: 8.0,
                                ),
                                new Container(
                                  decoration: new BoxDecoration(
                                    border: new Border.all(
                                      color: Colors.grey,
                                      width: 1.0,
                                    ),
                                  ),
                                  child: new TextFormField(
                                    controller: passwordController,
                                    obscureText: true,
                                    style: const TextStyle(
                                      color: Colors.black,
                                    ),
                                    decoration: new InputDecoration(
                                      icon: Padding(
                                        padding: const EdgeInsets.only(left:8.0),
                                        child: new Icon(
                                          CustomIcons.lock,
                                          color: Colors.black,
                                          size: 15.0,
                                        ),
                                      ),
                                      border: InputBorder.none,
                                      hintText: "Password",
                                      hintStyle: const TextStyle(color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w500),
                                      contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        new RaisedButton(
                          splashColor: Colors.white,
                          highlightColor: Colors.black,
                          elevation: 4.0,
                          color: Colors.red,
                          child: Text(
                            "Log In",
                            style: cardButtonStyle,
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0)),
                          onPressed: () =>
                              //Navigator.pushReplacementNamed(context, "/home")
                              loginProcess(context)
                        ),
                      ]),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future _showNotification() async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.Max, priority: Priority.High);
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, 'Login Success', 'Welcome to Procura!', platformChannelSpecifics);
  }

  Future onSelectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }

    await Navigator.pushReplacementNamed(context, "/home");
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
              Navigator.pushReplacementNamed(context, "/home");
            },
          )
        ],
      ),
    );
  }

}

var flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
