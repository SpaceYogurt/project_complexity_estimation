import 'package:flutter/material.dart';

class Activity {
  String name;
  double from;
  double to;
  double probably;

  Activity(
      {@required this.name,
        @required this.from,
        @required this.to,
        @required this.probably});
}


class Project {
  String name;
  String desc;
  List<Activity> activities;

  Project(
      {@required this.name,
        @required this.desc,
        @required this.activities});
}
