import 'dart:math';

import 'package:flutter/material.dart';
import 'package:project_complexity_calculator/model.dart';
import 'package:project_complexity_calculator/pages/project_result.dart';
import 'package:project_complexity_calculator/widgets/dialogs.dart';

class NewProjectPage extends StatefulWidget {
  final String title = "Рассчёт трудоёмкости проекта";

  NewProjectPage({Key key}) : super(key: key);

  @override
  _NewProjectPageState createState() => _NewProjectPageState();
}

class _NewProjectPageState extends State<NewProjectPage> {
  final List<Activity> activities = <Activity>[];
  String _resultLabelText = "";
  String _warningLabelText = "";

  final Map<String, dynamic> _projectFormData = {
    'name': null,
    'desc': null,
  };

  Dialogs dialogs = new Dialogs();
  final GlobalKey<FormState> _projectFormKey = GlobalKey<FormState>();

  final _uiTextController = TextEditingController();
  final _actTextController = TextEditingController();

  Widget _buildResultTextContainer() {
    if (_resultLabelText.isEmpty) {
      return Center(
          child: Text("You will see calculation result here...",
              style: TextStyle(color: Colors.grey.withOpacity(0.6))));
    } else
      return Center(
          child: Text("Project duration is " + _resultLabelText,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)));
  }

  void _showResult() {
    var Es = <double>[];
    var CKOs = <double>[];
    activities.forEach((act) {
      var Ei = (act.from + 4 * act.probably + act.to) / 6;
      print(act.name + " " + Ei.toString());
      var CKOi = (act.to - act.from) / 6;
      print(act.name + " " + CKOi.toString());
      Es.add(Ei);
      CKOs.add(CKOi);
    });

    double resultE = 0.0;
    Es.forEach((Ei) {
      resultE += Ei;
    });

    double resultCKO = 0.0;
    CKOs.forEach((CKOi) {
      resultCKO += CKOi * CKOi;
    });

    double duration = (resultE + 2 * sqrt(resultCKO));

    setState(() {
      if (duration != 0.0) {
        _resultLabelText = (resultE + 2 * sqrt(resultCKO)).toString();
      } else {}
    });
  }

  Widget _buildNameTextField() {
    return TextFormField(
      //keyboardType: TextInputType.,
      //controller: _uiTextController,
      decoration: InputDecoration(labelText: 'Имя проекта'),
      validator: (String value) {
        if (value.isEmpty || value.length > 20) {
          return 'Введите имя длиной не более 20 символов';
        }
      },
      onSaved: (String value) {
        _projectFormData['name'] = value;
      },
    );
  }

  Widget _buildDescTextField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Краткое описание'),
      validator: (String value) {
        if (value.isEmpty || value.length > 30) {
          return 'Введите краткое описание длиной не более 30 символов';
        }
      },
      onSaved: (String value) {
        _projectFormData['desc'] = value;
      },
    );
  }

  Widget _buildPageContent(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(20.0),
          child: Center(
            child: Text("Параметры проекта",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 40.0),
          child: Form(
              key: _projectFormKey,
              child: Column(
                children: <Widget>[
                  _buildNameTextField(),
                  _buildDescTextField(),
                ],
              )),
        ),
        Center(
          // margin: EdgeInsets.all(0.0),
          child: Text("Задачи",
              textAlign: TextAlign.left,
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18)),
        ),
        activities.isEmpty
            ? Column(
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Text(
                      "Нажмите на \"Плюс\" чтобы добавить новую задачу",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              )
            : Padding(
                padding: const EdgeInsets.all(0.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      //margin: EdgeInsets.all(10.0),
                      child: bodyData(),
                    ),
                  ],
                ),
              ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.add,
                color: Colors.green,
              ),
              onPressed: () {
                _addNewActivity(context);
              },
            ),
            activities.isEmpty
                ? Container()
                : Container(
                    child: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          activities.removeLast();
                        });
                      },
                    ),
                  )
          ],
        ),
        Container(
          child: Text(
            _warningLabelText,
            style: TextStyle(color: Colors.red),
          ),
        ),
        SizedBox(
          height: 40.0,
        ),
        Container(
          //margin: EdgeInsets.all(20.0),
          child: Center(
            child: RaisedButton(
                child: Text(
                  "Посчитать",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: _calculateProject),
          ),
        ),
        SizedBox(
          height: 85.0,
        ),
        //_buildResultTextContainer()
      ],
    );
  }

  void _addNewActivity(BuildContext context) async {
    final Object result =
        await Navigator.pushNamed(context, "/add_new_activity");
    if (result != null) {
      var bar = result as Map<String, dynamic>;
      setState(() {
        activities.add(new Activity(
            name: bar["name"],
            from: bar["from"],
            to: bar["to"],
            probably: bar["probably"]));
      });
    }
    //dialogs.addNewActivity(context);
    /*setState(() {
      acts.add(new Activity(
          name: "Act1", from: 2, to: 4, probably: 3));
    });*/
  }

  void _calculateProject() {
    if (activities.isEmpty) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Подсчёт трудоёмкости не удался"),
              content: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text("Пожалуйста,добавьте задачи к проекту"),
              ),
            );
          });
      // _warningLabelText = "Please add some activities";
    } else {
      if (_projectFormKey.currentState.validate()) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProjectResultPage(project: Project(
                    name: _projectFormData["name"],
                    desc: _projectFormData["desc"],
                    activities: activities))));
      } else {
        print("invalid project");
        _showResult();
      }
    }
  }

  Widget bodyData() {
    return DataTable(
        onSelectAll: (b) {},
        //sortColumnIndex: 1,
        sortAscending: true,
        columns: <DataColumn>[
          DataColumn(
            label: Text(
              "Имя",
              textAlign: TextAlign.center,
            ),
            numeric: false,
            onSort: (i, b) {
              print("$i $b");
              setState(() {
                activities.sort((a, b) => a.name.compareTo(b.name));
              });
            },
            //tooltip: "To display  name of the Name",
          ),
          DataColumn(
            label: Flexible(child: Text("От")),
            numeric: false,
            onSort: (i, b) {
              print("$i $b");
              setState(() {
                activities.sort((a, b) => a.from.compareTo(b.from));
              });
            },
            //tooltip: "To display last name of the Name",
          ),
          DataColumn(
            label: Flexible(child: Text("До")),
            numeric: false,
            onSort: (i, b) {
              print("$i $b");
              setState(() {
                activities.sort((a, b) => a.to.compareTo(b.to));
              });
            },
            //tooltip: "To display last name of the Name",
          ),
          DataColumn(
            label: Flexible(child: Text("Вероятно")),
            numeric: false,
            onSort: (i, b) {
              print("$i $b");
              setState(() {
                activities.sort((a, b) => a.probably.compareTo(b.probably));
              });
            },
            //tooltip: "To display last name of the Name",
          ),
        ],
        rows: activities
            .map(
              (act) => DataRow(
                    cells: [
                      DataCell(
                        Text(act.name),
                        showEditIcon: false,
                        placeholder: false,
                      ),
                      DataCell(
                        Text(act.from.toString()),
                        showEditIcon: false,
                        placeholder: false,
                      ),
                      DataCell(
                        Text(act.to.toString()),
                        showEditIcon: false,
                        placeholder: false,
                      ),
                      DataCell(
                        Text(act.probably.toString()),
                        showEditIcon: false,
                        placeholder: false,
                      )
                    ],
                  ),
            )
            .toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      resizeToAvoidBottomPadding: false,
      body: Container(
        child: _buildPageContent(context),
      ),
    );
  }
}
