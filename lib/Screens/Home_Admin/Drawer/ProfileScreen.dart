import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:procura/Components/custom_icons.dart';
import 'package:procura/Screens/Home_Admin/Drawer/SettingsScreen.dart';
import 'package:procura/Screens/Home_Admin/Drawer/samplesign.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({this.host, this.list, this.pic});
  final String host;
  final List list;
  final String pic;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    Widget ScaffoldPortrait() {
      return Scaffold(
//      appBar: AppBar(
//        iconTheme: IconThemeData(
//          color: Theme.of(context).brightness == Brightness.light
//              ? Colors.black
//              : Colors.white, //change your color here
//        ),
//        title: Text(
//          "My Profile",
//          style: new TextStyle(
//              color: Theme.of(context).brightness == Brightness.light
//                  ? Colors.black
//                  : Colors.white,
//              fontSize: 16.0,
//              fontWeight: FontWeight.w500,
//              letterSpacing: 0.5,
//              fontFamily: 'Montserrat'),
//        ),
//        centerTitle: true,
//        elevation: 0.0,
//        backgroundColor: Colors.transparent,
//      ),
        body: Container(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                //User's Details(name,pic,signature)
                Stack(
                  children: <Widget>[
                    FractionalTranslation(
                      translation: Offset(0.0, 0.0),
                      child: Container(
                        decoration: new BoxDecoration(
                          shape: BoxShape.rectangle,
                          image: new DecorationImage(
                            image: new NetworkImage(host + list[0]['user_image']),
                            fit: BoxFit.cover,
                          ),
                        ),
                        width: width,
                        height: width / 1.2,
                      ),
                    ),
                    FractionalTranslation(
                        translation: Offset(0.15, 0.65),
                        child: Container(
                          height: 40.0,
                          width: 40.0,
                          decoration: BoxDecoration(
                              color: Colors.grey[700], shape: BoxShape.circle),
                        )),
                    FractionalTranslation(
                      translation: Offset(0.0, 0.5),
                      child: IconButton(
                          icon: Icon(CustomIcons.uniE875),
                          iconSize: 20.0,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          color: Colors.white),
                    ),
                  ],
                ),
                Padding(
                  padding:
                  const EdgeInsets.only(top: 40.0, left: 10.0, right: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Stack(
                        alignment: AlignmentDirectional.center,
                        children: <Widget>[
                          FractionalTranslation(
                            translation: Offset(0.0, -0.4),
                            child: list[0]['user_signature'] == null
                                ? Container(
                                height: 80.0,
                                width: 200.0,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                          builder: (context) =>
                                              SignApp2(host: host, list: list)),
                                    );
                                  },
                                  child: Center(
                                    child: Text(
                                      'Signature not yet provided.\n'
                                          'Click here to create your signature',
                                      style: new TextStyle(
                                        color: Theme.of(context).brightness ==
                                            Brightness.light
                                            ? Colors.black
                                            : Colors.white,
                                        fontSize: 14.0,
                                        fontStyle: FontStyle.italic,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ))
                                : Container(
                              height: 80.0,
                              width: 180.0,
                              child: Image.network(
                                  host + list[0]['user_signature']),
                            ),
                          ),
                          FractionalTranslation(
                            translation: Offset(0.0, 0.0),
                            child: Text(
                              list[0]['name'],
                              style: new TextStyle(
                                  color: Theme.of(context).brightness ==
                                      Brightness.light
                                      ? Colors.black
                                      : Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.5,
                                  fontFamily: 'Lulo'),
                            ),
                          ),
                          FractionalTranslation(
                            translation: Offset(0.0, 1.0),
                            child: Text(
                              list[0]['username'],
                              style: new TextStyle(
                                  color: Theme.of(context).brightness ==
                                      Brightness.light
                                      ? Colors.black
                                      : Colors.white,
                                  fontSize: 17.0,
                                  letterSpacing: 0.5,
                                  fontFamily: 'Montserrat'),
                            ),
                          ),
                          FractionalTranslation(
                            translation: Offset(0.0, 2.0),
                            child: Text(
                              list[0]['user_types'],
                              style: new TextStyle(
                                color:
                                Theme.of(context).brightness == Brightness.light
                                    ? Colors.black
                                    : Colors.white,
                                fontSize: 17.0,
                                fontStyle: FontStyle.italic,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 20.0,
                      ),
                      Align(
                          alignment: Alignment.bottomCenter,
                          child: OutlineButton(
                            splashColor: Colors.blueGrey,
                            highlightedBorderColor: Colors.blueGrey,
                            //shape: StadiumBorder(),
                            borderSide: BorderSide(
                                width: 2.0,
                                color: Colors.blueGrey[700],
                                style: BorderStyle.solid),
                            child: Text(
                              'Edit Profile',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => SettingsScreen(host: host, list:list)),
                              );
                            },
                          ))
                    ],
                  ),
                ),
              ],
            )),
      );
    }

    Widget ScaffoldLandscape() {
      return Scaffold(
        body: Container(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                //User's Details(name,pic,signature)
                Stack(
                  children: <Widget>[
                    Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        FractionalTranslation(
                          translation: Offset(0.0, 0.0),
                          child: new Container(
                            decoration: new BoxDecoration(
                              image: new DecorationImage(
                                image: NetworkImage(host + list[0]['user_image']),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: new BackdropFilter(
                              filter:
                              new ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                              child: new Container(
                                width: width,
                                height: height / 2.0,
                                decoration: new BoxDecoration(
                                  color: Colors.white.withOpacity(0.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                        FractionalTranslation(
                          translation: Offset(0.0, 0.0),
                          child: new Container(
                            width: width / 2.0,
                            height: height / 2.0,
                            decoration: new BoxDecoration(
                              image: new DecorationImage(
                                image: NetworkImage(host + list[0]['user_image']),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    FractionalTranslation(
                        translation: Offset(0.15, 0.65),
                        child: Container(
                          height: 40.0,
                          width: 40.0,
                          decoration: BoxDecoration(
                              color: Colors.grey[700], shape: BoxShape.circle),
                        )),
                    FractionalTranslation(
                      translation: Offset(0.0, 0.5),
                      child: IconButton(
                        color: Colors.white,
                        icon: Icon(CustomIcons.uniE875),
                        iconSize: 20.0,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding:
                  const EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Stack(
                          alignment: AlignmentDirectional.center,
                          children: <Widget>[
                            FractionalTranslation(
                              translation: Offset(0.0, -0.4),
                              child: list[0]['user_signature'] == null
                                  ? Container(
                                  height: 80.0,
                                  width: 200.0,
                                  child: GestureDetector(
                                    onTap: () {},
                                    child: Center(
                                      child: Text(
                                        'Signature not yet provided.\n'
                                            'Click here to create your signature',
                                        style: new TextStyle(
                                          color: Theme.of(context).brightness ==
                                              Brightness.light
                                              ? Colors.black
                                              : Colors.white,
                                          fontSize: 14.0,
                                          fontStyle: FontStyle.italic,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ))
                                  : Container(
                                height: 80.0,
                                width: 180.0,
                                child: Image.network(
                                    host + list[0]['user_signature']),
                              ),
                            ),
                            FractionalTranslation(
                              translation: Offset(0.0, 0.0),
                              child: Text(
                                list[0]['name'],
                                style: new TextStyle(
                                    color: Theme.of(context).brightness ==
                                        Brightness.light
                                        ? Colors.black
                                        : Colors.white,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.5,
                                    fontFamily: 'Lulo'),
                              ),
                            ),
                            FractionalTranslation(
                              translation: Offset(0.0, 1.0),
                              child: Text(
                                list[0]['username'],
                                style: new TextStyle(
                                    color: Theme.of(context).brightness ==
                                        Brightness.light
                                        ? Colors.black
                                        : Colors.white,
                                    fontSize: 17.0,
                                    letterSpacing: 0.5,
                                    fontFamily: 'Montserrat'),
                              ),
                            ),
                            FractionalTranslation(
                              translation: Offset(0.0, 2.0),
                              child: Text(
                                list[0]['user_types'],
                                style: new TextStyle(
                                  color: Theme.of(context).brightness ==
                                      Brightness.light
                                      ? Colors.black
                                      : Colors.white,
                                  fontSize: 17.0,
                                  fontStyle: FontStyle.italic,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: 10.0,
                        ),
                        Align(
                            alignment: Alignment.bottomCenter,
                            child: OutlineButton(
                              splashColor: Colors.blueGrey,
                              highlightedBorderColor: Colors.blueGrey,
                              //shape: StadiumBorder(),
                              borderSide: BorderSide(
                                  width: 2.0,
                                  color: Colors.blueGrey[700],
                                  style: BorderStyle.solid),
                              child: Text(
                                'Edit Profile',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) => SettingsScreen(host: host, list: list)),
                                );
                              },
                            ))
                      ],
                    ),
                  ),
                ),
              ],
            )),
      );
    }

    return MediaQuery.of(context).orientation == Orientation.portrait
        ? ScaffoldPortrait()
        : ScaffoldLandscape();
  }
}
