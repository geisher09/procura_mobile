import 'dart:io';
import 'package:flutter/material.dart';
import 'package:procura/Screens/Home_Admin/index.dart';
import 'package:procura/Screens/Login/index.dart';
import 'Routes2.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wifi/wifi.dart';
import 'package:get_ip/get_ip.dart';

Future<InternetAddress> get selfIP async {
  String ip = await Wifi.ip;
  return InternetAddress(ip);
}
  final String host = "http://192.168.22.9/ProcuraMobile";
void main() async {
  Widget _defaultHome = new LoginScreen();
  final prefs = await SharedPreferences.getInstance();
  final host2 = await selfIP;
  final Id = prefs.getString('id') ?? '0';
  print(host2);
  if (Id != '0') {
    _defaultHome = new Home_AdminScreen();
  }

  launchMain(dh: _defaultHome);
}