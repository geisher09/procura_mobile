import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get_ip/get_ip.dart';
import 'package:procura/Screens/Home_Admin/HomeDashboard.dart';
import 'package:procura/Screens/Login/index.dart';
import 'package:procura/Screens/Home_Admin/index.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
void launchMain({String host, Widget dh}) => runApp(new Routes(host: host,dh: dh));

//void ipAdd() async{
//  String ipAdd = await GetIp.ipAddress;
//  List<String> splitId = ipAdd.split('.');
//  int lastnum = int.parse(splitId[3]);
//  lastnum -= 1;
//  String newIp = splitId[0] + '.' + splitId[1] + '.' + splitId[2] + '.$lastnum';
//  String host = 'http://$newIp/ProcuraMobile';
//  Routes(host:host);
//}
class Routes extends StatelessWidget {
  Routes({this.dh, this.host});
  final Widget dh;
  final String host;
  @override
  Widget build(BuildContext context) {
    return new DynamicTheme(
        defaultBrightness: Brightness.light,
        data: (brightness) => new ThemeData(
          brightness: brightness,
          fontFamily: 'Raleway'
        ),
        themedWidgetBuilder: (context, theme) {
          return new MaterialApp(
            title: "Procura Mobile App",
            theme: theme,
            debugShowCheckedModeBanner: false,
            home:
            dh,
            //LoginScreen(),
            onGenerateRoute: (RouteSettings settings) {
              switch (settings.name) {
                case '/login':
                  return new ProcuraRoutes(
                    builder: (_) => new LoginScreen(host: host),
                    settings: settings,
                  );

                case '/home':
                  return new ProcuraRoutes(
                    builder: (_) => new Home_AdminScreen(host: host),
                    //builder: (_) => new HomeDashboard(),
                    settings: settings,
                  );
              }
            },
          );
        }
    );
  }
}

class ProcuraRoutes<T> extends MaterialPageRoute<T> {
  ProcuraRoutes({WidgetBuilder builder, RouteSettings settings})
      : super(builder: builder, settings: settings);
}
