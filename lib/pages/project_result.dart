import 'package:flutter/material.dart';
import 'package:project_complexity_calculator/model.dart';

class ProjectResultPage extends StatefulWidget {
  final Project project;

  ProjectResultPage({Key key, @required this.project}) : super(key: key);

  @override
  _ProjectResultPageState createState() =>
      _ProjectResultPageState(project: project);
}

class _ProjectResultPageState extends State<ProjectResultPage> {
  final Project project;

  _ProjectResultPageState({@required this.project}) {}

  Widget _buildPageContent(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;
    final double targetPadding = deviceWidth - targetWidth;

    return Container(
      padding: EdgeInsets.all(targetPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Имя проекта - ",
                style: TextStyle(fontSize: 18),
              ),
              Text(
                "IT проект",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Трудоёмкость задач - ",
                style: TextStyle(fontSize: 18),
              ),
              Text(
                "1300 ч*ч",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Трудоёмкость проекта - ",
                style: TextStyle(fontSize: 18),
              ),
              Text(
                "40 ч*м",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Оптимальная прод-ть проекта - ",
                style: TextStyle(fontSize: 18),
              ),
              Text(
                "8.5 мес",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Средняя численность команды - ",
                style: TextStyle(fontSize: 18),
              ),
              Text(
                "5 чел",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              )
            ],
          ),// + widget.project.name != null ? widget.project.name : " "
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Результаты"), //widget.project.name
      ),
      resizeToAvoidBottomPadding: false,
      body: Container(
        child: _buildPageContent(context),
      ),
    );
  }
}
