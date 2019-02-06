import 'dart:io';
import 'package:flutter/material.dart';
import 'package:procura/Screens/Home_Admin/index.dart';
import 'package:procura/Screens/Login/index.dart';
import 'Routes.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_ip/get_ip.dart';
//final String host = "http://192.168.22.7/ProcuraMobile";
void main() async {
  final prefs = await SharedPreferences.getInstance();
  final Id = prefs.getString('id') ?? '0';
  String host = 'http://172.20.10.10/Procura/mobile';
  print(host);
  Widget _defaultHome = new LoginScreen(host: host);
  if (Id != '0') {
    _defaultHome = new Home_AdminScreen(host: host);
  }

  launchMain(host: host, dh: _defaultHome);
}