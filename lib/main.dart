import 'dart:io';
import 'package:flutter/material.dart';
import 'package:procura/Screens/Home_Admin/index.dart';
import 'package:procura/Screens/Login/index.dart';
import 'Routes2.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_ip/get_ip.dart';



  final String host = "http://192.168.22.8/ProcuraMobile";
void main() async {
  Widget _defaultHome = new LoginScreen();
  final prefs = await SharedPreferences.getInstance();
  String ipAdd = await GetIp.ipAddress;
  final Id = prefs.getString('id') ?? '0';
  print(ipAdd);
  if (Id != '0') {
    _defaultHome = new Home_AdminScreen();
  }

  launchMain(dh: _defaultHome);
}