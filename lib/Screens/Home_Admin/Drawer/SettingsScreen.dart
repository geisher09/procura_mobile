import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:procura/Components/custom_icons.dart';
import 'package:procura/Screens/Home_Admin/Drawer/samplesign.dart';

class SettingsScreen extends StatefulWidget {
  final String host;
  final List list;
  SettingsScreen({this.host, this.list});
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  TextEditingController usernameController;
  TextEditingController nameController;
  TextEditingController passwordController;
  TextEditingController oldPasswordController = new TextEditingController();
  TextEditingController newPasswordController = new TextEditingController();
  void editData() {

  }
  void _changePassDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: AlertDialog(
            title: Text(
              'Change Password',
              style: TextStyle(fontFamily: 'Montserrat', fontSize: 13.0),
              textAlign: TextAlign.center,
            ),
            titlePadding: EdgeInsets.only(top: 15.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
            content: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0,20.0,10.0,0.0),
                  child: Container(
                    decoration: new BoxDecoration(
                      border: new Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                    child: TextFormField(
                      controller: oldPasswordController,
                      obscureText: true,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      decoration: new InputDecoration(
                        icon: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: new Icon(
                            CustomIcons.lock,
                            color: Colors.black,
                            size: 15.0,
                          ),
                        ),
                        border: InputBorder.none,
                        hintText: "Old Password",
                        hintStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 13.0,
                            fontWeight: FontWeight.w500),
                        contentPadding:
                        EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0,10.0,10.0,15.0),
                  child: Container(
                    decoration: new BoxDecoration(
                      border: new Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                    child: TextFormField(
                      controller: newPasswordController,
                      obscureText: true,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      decoration: new InputDecoration(
                        icon: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: new Icon(
                            CustomIcons.lock,
                            color: Colors.black,
                            size: 15.0,
                          ),
                        ),
                        border: InputBorder.none,
                        hintText: "New Password",
                        hintStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 13.0,
                            fontWeight: FontWeight.w500),
                        contentPadding:
                        EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new FlatButton(
                      child: new Text(
                        "Cancel",
                        style: TextStyle(
                            color: Colors.indigo[400],
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    new FlatButton(
                      color: Colors.indigo[500],
                      child: new Text(
                        "Save",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  @override
  void initState() {
    usernameController =
    new TextEditingController(text: widget.list[0]['username']);
    nameController = new TextEditingController(text: widget.list[0]['name']);
    passwordController =
    new TextEditingController(text: widget.list[0]['password']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.black
                : Colors.white, //change your color here
          ),
          title: Text(
            "Edit Profile",
            style: new TextStyle(
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.black
                    : Colors.white,
                fontSize: 18.0,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
                letterSpacing: 2.0),
          ),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        decoration: new BoxDecoration(
                          shape: BoxShape.circle,
                          image: new DecorationImage(
                            image: new NetworkImage(
                                widget.host + widget.list[0]['user_image']),
                            fit: BoxFit.cover,
                          ),
                        ),
                        width: MediaQuery.of(context).orientation ==
                            Orientation.portrait
                            ? height / 4.0
                            : width / 4.0,
                        height: MediaQuery.of(context).orientation ==
                            Orientation.portrait
                            ? height / 4.0
                            : width / 4.0,
                      ),
                      Positioned(
                        right: 1.0,
                        bottom: 1.0,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 15.0),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(20.0),
                            splashColor: Colors.indigo[400],
                            onTap: () {},
                            child: Container(
                              height: 40.0,
                              width: 40.0,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.indigo[800],
                                  border: Border.all(
                                    color: Theme.of(context).brightness ==
                                        Brightness.light
                                        ? Colors.white
                                        : Colors.grey[200],
                                    width: 1.5,
                                  )),
                              child: Icon(
                                CustomIcons.pencil,
                                size: 18.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: widget.list[0]['user_signature'] == null
                        ? Container(
                        height: 80.0,
                        width: 200.0,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => SignApp2(
                                      host: widget.host,
                                      list: widget.list)),
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
                        : Stack(
                      children: <Widget>[
                        Container(
                          height: 80.0,
                          width: 180.0,
                          child: Image.network(widget.host +
                              widget.list[0]['user_signature']),
                        ),
                        Positioned(
                          right: 1.0,
                          bottom: 1.0,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(20.0),
                            splashColor: Colors.indigo[400],
                            onTap: () {
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => SignApp2(
                                        host: widget.host,
                                        list: widget.list)),
                              );
                            },
                            child: Container(
                              height: 40.0,
                              width: 40.0,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.indigo[800],
                                  border: Border.all(
                                    color: Theme.of(context).brightness ==
                                        Brightness.light
                                        ? Colors.white
                                        : Colors.grey[200],
                                    width: 1.5,
                                  )),
                              child: Icon(
                                CustomIcons.pencil,
                                size: 18.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: Container(
                      width: MediaQuery.of(context).orientation ==
                          Orientation.portrait
                          ? width / 1.5
                          : width / 2.0,
                      child: new TextField(
                        controller: usernameController,
                        style: TextStyle(
                            fontSize: 15.0, fontWeight: FontWeight.bold),
                        decoration: new InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          labelText: 'USER NAME',
                          contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 10.0),
                          labelStyle:
                          TextStyle(fontSize: 16.0, letterSpacing: 1.0),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: Container(
                      width: MediaQuery.of(context).orientation ==
                          Orientation.portrait
                          ? width / 1.5
                          : width / 2.0,
                      child: new TextField(
                        controller: nameController,
                        style: TextStyle(
                            fontSize: 15.0, fontWeight: FontWeight.bold),
                        decoration: new InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          labelText: 'NAME',
                          contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 10.0),
                          labelStyle:
                          TextStyle(fontSize: 16.0, letterSpacing: 1.0),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: RaisedButton(
                        shape: StadiumBorder(),
                        color: Colors.indigo[700],
                        child: Padding(
                          padding:
                          const EdgeInsets.only(top: 15.0, bottom: 15.0),
                          child: Container(
                            width: MediaQuery.of(context).orientation ==
                                Orientation.portrait
                                ? width / 2.0
                                : width / 3.0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text(
                                  'Change Password',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.0),
                                ),
                                Icon(
                                  CustomIcons.pencil,
                                  size: 18.0,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                        onPressed: _changePassDialog),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
