import 'dart:io';
import 'package:flutter/material.dart';
import 'package:procura/Screens/Home_Admin/index.dart';
import 'package:procura/Screens/Login/index.dart';
import 'Routes.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_ip/get_ip.dart';
import 'package:flutter/cupertino.dart';

void main() async {
  String host = 'http://192.168.22.5/Procura/mobile';
  final prefs = await SharedPreferences.getInstance();
  final Id = prefs.getString('id') ?? '0';
  print(host);
  Widget _defaultHome = new LoginScreen(host: host);
  if (Id != '0') {
    _defaultHome = new Home_AdminScreen(host: host);
  }

  launchMain(host: host, dh: _defaultHome);
}

//return new FutureBuilder<SharedPreferences>(
//future: SharedPreferences.getInstance(),
//builder:
//(BuildContext context, AsyncSnapshot<SharedPreferences> snapshot) {
//switch (snapshot.connectionState) {
//case ConnectionState.none:
//case ConnectionState.waiting:
//return new LoadingScreen();
//default:
//if (!snapshot.hasError) {
//@ToDo("Return a welcome screen")
//return snapshot.data.getBool("welcome") != null
//? new MainView()
//    : new LoadingScreen();
//} else {
//return new ErrorScreen(error: snapshot.error);
//}
//}
//},
//);
