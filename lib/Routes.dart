import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:procura/Screens/Login/index.dart';
import 'package:procura/Screens/Home_Admin/index.dart';
import 'package:dynamic_theme/theme_switcher_widgets.dart';

class Routes {
  Routes() {
    //debugPaintSizeEnabled = true;
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
        .then((_) {
      runApp(new MaterialApp(
        title: "Procura Mobile App",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            brightness: Brightness.dark,
            fontFamily: 'Raleway'
        ),
        home: new LoginScreen(),
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
