import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:procura/Screens/Login/index.dart';

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
            return new ProcuraRoutes();
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
