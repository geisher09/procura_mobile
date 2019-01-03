import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/animation.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'dart:ui';
import 'package:flutter/rendering.dart';

import 'package:procura/Screens/Login/LoginForm.dart';



class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>{
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);

    TextStyle cardButtonStyle = Theme.of(context).textTheme.title.copyWith(
      fontSize: 16.0,
      color: Colors.white,
      letterSpacing: 0.3,
    );

    return new Scaffold(
      //resizeToAvoidBottomPadding: false,
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
              children: <Widget>[
                new Container(
                    height: MediaQuery.of(context).size.height/6
                ),
                new Container(
                  padding: EdgeInsets.only(left: 30.0, right: 30.0),
                  height: (queryData.size.height >= 650.0)?queryData.size.height/1.5:queryData.size.height/1.4,
                  child: new Card(
                    color: Colors.white,
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0)),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Column(children: <Widget>[
                        Container(
                          height: (queryData.size.height >= 570.0)?163.0:queryData.size.height/3.5,
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
                                          letterSpacing: 5.0
                                      ),
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
                        new Container(
                          height: MediaQuery.of(context).size.height/25,
                          child: FractionalTranslation(
                              translation: Offset(0.0, -2.0),
                              child: Text(
                                "Size ${MediaQuery.of(context).size.width} * ${MediaQuery.of(context).size.height}",
                                style: Theme.of(context).textTheme.title,
                              )),
                        ),
                        new FractionalTranslation(
                          translation: Offset(0.0, -0.3),
                          child: new FormContainer(),
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
                              Navigator.pushReplacementNamed(context, "/home"),
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
}
