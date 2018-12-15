import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:procura/Screens/Login/index.dart';
import 'package:procura/Screens/Home_Admin/index.dart';
import 'package:dynamic_theme/dynamic_theme.dart';

void launchMain() => runApp(new Routes());

class Routes extends StatelessWidget {
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
          );
        }
    );
  }
}

class ProcuraRoutes<T> extends MaterialPageRoute<T> {
  ProcuraRoutes({WidgetBuilder builder, RouteSettings settings})
      : super(builder: builder, settings: settings);
}
