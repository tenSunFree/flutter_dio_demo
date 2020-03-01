import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dio_demo/home/home.dart';

Widget createApp() {
  return MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: HomePage(),
  );
}

class GlobalConfig {
  static bool isDebug = true;
}
