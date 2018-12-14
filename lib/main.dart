import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:project_complexity_calculator/pages/new_project_page.dart';


void main() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            brightness: Brightness.light,
            primarySwatch: Colors.lightGreen,
            accentColor: Colors.lightGreenAccent,
            buttonColor: Colors.lightBlue),
        //home: ,
        routes: {
          '/': (BuildContext context) => NewProjectPage(),
          //  '/movies_list': (BuildContext context) => MoviesPage(),
        });
  }
}
