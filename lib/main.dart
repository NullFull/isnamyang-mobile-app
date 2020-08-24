import 'package:flutter/material.dart';

import 'package:isnamyang/screen/SplashScreen.dart';
import 'package:isnamyang/screen/ScanScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const appTitle = '남양유없';
  static const splashTitle = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(title: splashTitle),
      routes: {
        ScanScreen.routeName: (context) => ScanScreen(),
      },
    );
  }
}
