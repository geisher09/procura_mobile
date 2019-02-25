import 'dart:async';
import 'dart:io';
import 'package:async/async.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:procura/Components/custom_icons.dart';
import 'package:procura/Screens/Home_Admin/Drawer/SettingsScreen2.dart';
import 'package:procura/Screens/Home_Admin/Drawer/samplesign.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:procura/Screens/Home_Admin/Drawer/uploadPic.dart';

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
  TextEditingController newPassword2Controller = new TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeyop = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeynp = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeynp2 = GlobalKey<FormState>();
  bool _autoValidate = false;
  String _rem;

  @override
  void initState() {
    usernameController =
        new TextEditingController(text: widget.list[0]['username']);
    nameController = new TextEditingController(text: widget.list[0]['name']);
    passwordController =
        new TextEditingController(text: widget.list[0]['password']);
    super.initState();
  }

  Future<String> checkPassword() async {
    final response = await http.post("${widget.host}/accountCheck.php", body: {
      "id": '2',
      "uid": widget.list[0]['id'],
      "password": oldPasswordController.text
    });
    final response2 = await http.delete("${widget.host}/accountCheck.php");
    print('PASS: ' + oldPasswordController.text);
    print(response.body);
    return (response.body);
  }

  Future<String> checkUsername() async {
    final response = await http.post("${widget.host}/accountCheck.php", body: {
      "id": '1',
      "uid": widget.list[0]['id'],
      "username": usernameController.text
    });
    print('USERNAME: ' + usernameController.text);
    print(response.body);
    return (response.body);
  }

  void editAccount() {
    var url = "${widget.host}/updateAccount.php";
    http.post(url, body: {
      "id": widget.list[0]['id'],
      "username": usernameController.text,
      "name": nameController.text,
    });
  }

  void editPass() {
    var url = "${widget.host}/updatePassword.php";
    http.post(url, body: {
      "id": widget.list[0]['id'],
      "password": newPassword2Controller.text,
    });
  }

  File _image;
  Future getImageGallery() async {
    var imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = imageFile;
    });
  }

  Future getImageCamera() async {
    var imageFile = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = imageFile;
    });
  }
  void _validateInputs() async {
    if (_formKey.currentState.validate() && _formKey2.currentState.validate()) {
      if (usernameController.text == widget.list[0]['username']) {
        print('same uname okay edit');
        editAccount();
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
      } else {
        final response = await http.post("${widget.host}/accountCheck.php",
            body: {
              "id": '1',
              "uid": widget.list[0]['id'],
              "username": usernameController.text
            });
        print('USERNAME: ' + usernameController.text);
        print(response.body);
        if (response.body == 'correct_username') {
          print('okay uname okay edit');
          editAccount();
          Navigator.of(context).pushNamedAndRemoveUntil(
              '/home', (Route<dynamic> route) => false);
        }
      }
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }

  void _validatePass() async {
    if (_formKeyop.currentState.validate() &&
        _formKeynp.currentState.validate() &&
        _formKeynp2.currentState.validate()) {
      final response = await http.post("${widget.host}/accountCheck.php",
          body: {
            "id": '2',
            "uid": widget.list[0]['id'],
            "password": oldPasswordController.text
          });
      print('PASS: ' + oldPasswordController.text);
      print(response.body);
      if ((newPasswordController.text == newPassword2Controller.text) &&
          (response.body == 'correct_password')) {
        print('okay edit pass');
        editPass();
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
      }
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
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
                  padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0.0),
                  child: Container(
                    decoration: new BoxDecoration(
                      border: new Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                    child: Form(
                      key: _formKeyop,
                      autovalidate: _autoValidate,
                      child: TextFormField(
                        controller: oldPasswordController,
                        obscureText: true,
                        validator: (String arg) {
                          if (arg.length < 1) {
                            return 'you need to enter a password';
                          } else {
                            return null;
                          }
                        },
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
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 5.0),
                  child: Container(
                    decoration: new BoxDecoration(
                      border: new Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                    child: Form(
                      key: _formKeynp,
                      autovalidate: _autoValidate,
                      child: TextFormField(
                        controller: newPasswordController,
                        obscureText: true,
                        validator: (String arg) {
                          if (arg.length < 5) {
                            return 'Password should be more than 4 characters';
                          } else {
                            return null;
                          }
                        },
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
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 15.0),
                  child: Container(
                    decoration: new BoxDecoration(
                      border: new Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                    child: Form(
                      key: _formKeynp2,
                      autovalidate: _autoValidate,
                      child: TextFormField(
                        controller: newPassword2Controller,
                        obscureText: true,
                        validator: (String arg) {
                          if (arg.length < 5) {
                            return 'The new password should match this one';
                          } else {
                            return null;
                          }
                        },
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
                          hintText: "Re-enter New Password",
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
                        _validatePass();
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
  Widget build(BuildContext context) {
    String _name;
    String _uname;
    List splithost = widget.host.split('/');
    String newHost = 'http://${splithost[2]}/Procura/storage/app/public/';
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
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.indigo,
                          style: BorderStyle.solid,
                          width: 3.0,
                        ),
                        borderRadius: BorderRadius.circular(15.0)),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: <Widget>[
                          _image == null
                              ? Container(
                                  decoration: new BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: new DecorationImage(
                                      image: new NetworkImage(newHost +
                                          widget.list[0]['user_image']),
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
                                )
                              : Container(
                                  decoration: new BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: new DecorationImage(
                                      image: FileImage(_image),
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
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: new RaisedButton(
                              color: Colors.teal[600],
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Icon(
                                    Icons.image,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    "Select from Gallery",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              onPressed: () {
                                getImageGallery();
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 15.0),
                            child: new RaisedButton(
                              color: Colors.teal[600],
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Icon(
                                    Icons.camera_alt,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    "Use Camera",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              onPressed: () {
                                getImageCamera();
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: RaisedButton(
                              shape: BeveledRectangleBorder(),
                              color: Colors.indigo[700],
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 15.0, bottom: 15.0),
                                child: Container(
                                  width: MediaQuery.of(context).orientation ==
                                          Orientation.portrait
                                      ? width / 2.0
                                      : width / 3.0,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Text(
                                        'Save changes',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.0),
                                      ),
                                      Icon(
                                        FontAwesomeIcons.save,
                                        size: 18.0,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              onPressed: _image == null
                                  ? () async {
                                      Navigator.of(context)
                                          .pushNamedAndRemoveUntil('/home',
                                              (Route<dynamic> route) => false);
                                    }
                                  : () {
                                      uploadPic(widget.host, widget.list, _image);
                                      Navigator.of(context)
                                          .pushNamedAndRemoveUntil('/home',
                                              (Route<dynamic> route) => false);
                                    },
                            ),
                          ),
                        ],
                      ),
                    ),
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
                                child: Image.network(
                                    newHost + widget.list[0]['user_signature']),
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
                    padding: const EdgeInsets.only(top: 15.0),
                    child: RaisedButton(
                        shape: StadiumBorder(),
                        color: Colors.indigo[700],
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
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
                  Container(
                    height: 20.0,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.indigo,
                          style: BorderStyle.solid,
                          width: 3.0,
                        ),
                        borderRadius: BorderRadius.circular(15.0)),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: <Widget>[
                          /* Container(
                            decoration: new BoxDecoration(
                              border: new Border.all(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                            ),
                            child: Form(
                              key: _formKey,
                              autovalidate: _autoValidate,
                              child: TextFormField(
                                controller: usernameController,
                                obscureText: false,
                                validator: (String arg) {
                                  if (arg.length < 1) {
                                    return 'You need to enter your username';
                                  }else {
                                    return null;
                                  }
                                },
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
                                decoration: new InputDecoration(
                                  icon: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0),
                                    child: new Icon(
                                      CustomIcons.lock,
                                      color: Colors.black,
                                      size: 15.0,
                                    ),
                                  ),
                                  border: InputBorder.none,
                                  hintText: "username",
                                  hintStyle: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.w500),
                                  contentPadding: EdgeInsets.fromLTRB(
                                      10.0, 10.0, 20.0, 10.0),
                                ),
                              ),
                            )
                          ),*/
                          Padding(
                            padding: const EdgeInsets.only(top: 25.0),
                            child: Container(
                              width: MediaQuery.of(context).orientation ==
                                      Orientation.portrait
                                  ? width / 1.5
                                  : width / 2.0,
                              child: Form(
                                key: _formKey,
                                autovalidate: _autoValidate,
                                child: TextFormField(
                                  controller: usernameController,
                                  obscureText: false,
                                  validator: (String arg) {
                                    if (arg.length < 1) {
                                      return 'You need to enter your username';
                                    } else {
                                      return null;
                                    }
                                  },
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold),
                                  decoration: new InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    labelText: 'USER NAME',
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.0, 15.0, 20.0, 10.0),
                                    labelStyle: TextStyle(
                                        fontSize: 16.0, letterSpacing: 1.0),
                                  ),
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
                              child: Form(
                                key: _formKey2,
                                autovalidate: _autoValidate,
                                child: TextFormField(
                                  controller: nameController,
                                  obscureText: false,
                                  validator: (String arg) {
                                    if (arg.length < 1) {
                                      return 'You need to enter your name';
                                    } else {
                                      return null;
                                    }
                                  },
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold),
                                  decoration: new InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    labelText: 'NAME',
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.0, 15.0, 20.0, 10.0),
                                    labelStyle: TextStyle(
                                        fontSize: 16.0, letterSpacing: 1.0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 25.0),
                            child: RaisedButton(
                              shape: BeveledRectangleBorder(),
                              color: Colors.indigo[700],
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 15.0, bottom: 15.0),
                                child: Container(
                                  width: MediaQuery.of(context).orientation ==
                                          Orientation.portrait
                                      ? width / 2.0
                                      : width / 3.0,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Text(
                                        'Save changes',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.0),
                                      ),
                                      Icon(
                                        FontAwesomeIcons.save,
                                        size: 18.0,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              onPressed: () {
                                _validateInputs();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
