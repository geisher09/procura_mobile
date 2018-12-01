import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

void main() {
  //debugPaintSizeEnabled = true;
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new LoginPage(),
      theme: ThemeData(
          primaryColorBrightness: Brightness.dark, fontFamily: 'Raleway'),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  AnimationController _loginButtonController;
  Animation<double> _animation;



  @override
  void initState() {
    super.initState();
    _loginButtonController = new AnimationController(
        duration: new Duration(milliseconds: 3000), vsync: this);
  }

  @override
  Widget build(BuildContext context) {

    TextStyle cardButtonStyle = Theme.of(context).textTheme.title.copyWith(
      fontSize: 16.0,
      color: Colors.white,
      letterSpacing: 0.3,
    );


    return new Scaffold(
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
          new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Container(
                padding: EdgeInsets.only(left: 30.0, right: 30.0),
                child: new Card(
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0)),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 40.0),
                    child: Column(children: <Widget>[
                      Container(
                        height: 150.0,
                        width: 300.0,
                        decoration: new BoxDecoration(
                          image: new DecorationImage(
                            image: new AssetImage(
                                "assets/images/tup_gradient.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: new Stack(
                          children: <Widget>[
                            new Positioned(
                              left: 38.0,
                              top: 30.0,
                              child: new Text(
                                "PROCURA",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Montserrat',
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 5.0
                                ),
                              ),
                            ),
                            new Positioned(
                              left: 40.0,
                              top: 75.0,
                              child: new Text(
                                'Better Procurement System.',
                                style: new TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                            new Positioned(
                              left: 70.0,
                              top: 95.0,
                              child: new Text(
                                'Better Work Place.',
                                style: new TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
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
                        ),
                      ),
//                      new Padding(
//                        padding: const EdgeInsets.all(10.0),
//                        child: Text(
//                          "Tourist Spot",
//                          style: cardTitleStyle,
//                        ),
//                      ),

                      new RaisedButton(
                        elevation: 4.0,
                        color: Colors.blue,
                        child: Text(
                          "Log In",
                          style: cardButtonStyle,
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0)),
                        onPressed: () {},
                      )
                    ]),
                  ),
                ),
//                    child: new Column(
//                      crossAxisAlignment: CrossAxisAlignment.center,
//                      children: <Widget>[
//                        new TextFormField(
//                          decoration: new InputDecoration(
//                            labelText: "Enter Username",
//                          ),
//                          keyboardType: TextInputType.text,
//                        ),
//                        new TextFormField(
//                          scrollPadding: EdgeInsets.only(bottom: 10.0),
//                          decoration: new InputDecoration(
//                            labelText: "Enter Password",
//                          ),
//                          keyboardType: TextInputType.text,
//                          obscureText: true,
//                        ),
//                        //const SizedBox(height: 100.0,),
//                        new Container(
//                          width: 320.0,
//                          height: 40.0,
//                          alignment: FractionalOffset.center,
//                          decoration: new BoxDecoration(
//                            color: const Color.fromRGBO(0, 206, 209, 1.0),
//                            borderRadius: new BorderRadius.all(const Radius.circular(30.0)),
//                          ),
//                          child: new Text(
//                            "Log In",
//                            style: new TextStyle(
//                              color: Colors.white,
//                              fontSize: 13.0,
//                              fontWeight: FontWeight.w300,
//                              letterSpacing: 0.3,
//                            ),
//                          ),
//                        )
//                      ],
//                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
