import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:procura/Screens/Login/index.dart';
import 'package:procura/Screens/Home_Admin/index.dart';

class Routes {
  Routes() {
    //debugPaintSizeEnabled = true;
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
        .then((_){
    runApp(new MaterialApp(
      title: "Procura Mobile App",
      debugShowCheckedModeBanner: false,
      home: new LoginScreen(),
        theme: ThemeData(
            primaryColorBrightness: Brightness.dark, fontFamily: 'Raleway'),
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/login':
            return new ProcuraRoutes(
              builder: (_) => new LoginScreen(),
              settings: settings,
            );

          case '/home':
            return new ProcuraRoutes(
              builder: (_) => new Home_AdminScreen(),
              settings: settings,
            );
        }
      },
    ));
    });
  }
}

class ProcuraRoutes<T> extends MaterialPageRoute<T> {
  ProcuraRoutes({WidgetBuilder builder, RouteSettings settings})
      : super(builder: builder, settings: settings);
}
