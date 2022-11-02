import "package:flutter/material.dart";
import "package:flutter/services.dart";

import './pages/Home.dart';
import "./pages/BisectionMethod.dart";
import "./pages/FalsePositionMethod.dart";
import "./pages/SecantMethod.dart";
import "./pages/NewtonRaphsonMethod.dart";

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);

  runApp(App());
}

class App extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.pink,
        primarySwatch: Colors.pink,
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.w500, height: 2),
              bodyText2: TextStyle(fontSize: 17, height: 1.6),
              headline1: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            ),
      ),
      initialRoute: "/",
      routes: {
        "/": (ctx) => Root(),
        BisectionMethod.routeName: (ctx) => BisectionMethod(),
        FalsePositionMethod.routeName: (ctx) => FalsePositionMethod(),
        SecantMethod.routeName: (ctx) => SecantMethod(),
        NewtonRaphsonMethod.routeName: (ctx) => NewtonRaphsonMethod(),
      },
    );
  }
}
