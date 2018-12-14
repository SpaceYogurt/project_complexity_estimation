import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NewProjectPage extends StatefulWidget {
  final String title = "New Project";

  //final String title = "Project Evaluation and Review Technique";

  NewProjectPage({Key key}) : super(key: key);

  @override
  _NewProjectPageState createState() =>
      _NewProjectPageState();
}

class _NewProjectPageState
    extends State<NewProjectPage> {
  final Map<String, dynamic> _formData = {
    'kUI': null,
    'kAct': null,
  };

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _resultLabelText = "";
  final _uiTextController = TextEditingController();
  final _actTextController = TextEditingController();

  Widget _buildDescriptionTextContainer() {
    return Container(
      child: Text("Project's parameters",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18)),
    );
  }

  Widget _buildUiTextField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
      controller: _uiTextController,
      decoration: InputDecoration(labelText: 'UI'),
      validator: (String value) {
        if (value.isEmpty || !_isANumber(value)) {
          return 'Please enter a number';
        }
      },
      onSaved: (String value) {
        _formData['kUI'] = value;
      },
    );
  }

  Widget _buildActTextField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
      controller: _actTextController,
      decoration: InputDecoration(labelText: 'Act'),
      validator: (String value) {
        if (value.isEmpty || !_isANumber(value)) {
          return 'Please enter a number';
        }
      },
      onSaved: (String value) {
        _formData['kAct'] = value;
      },
    );
  }

  void _onUiChange() {}

  Widget _buildResultTextContainer() {
    return Container(
        child: _resultLabelText.isEmpty
            ? Text("You will see calculation result here...",
                style: TextStyle(color: Colors.grey.withOpacity(0.6)))
            : Text("Project duration is " + _resultLabelText,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)));
  }

  bool _isANumber(value) {
    return RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]').hasMatch(value);
  }

  void _showResult() {
    setState(() {
      if (_uiTextController.text.isEmpty || _actTextController.text.isEmpty) {
        _clearResult();
      } else {
        int result = int.parse(_uiTextController.text) +
            int.parse(_actTextController.text);
        print("duration is " + result.toString());
        _resultLabelText = result.toString();
      }
    });
  }

  void _clearResult() {
    _resultLabelText = "";
  }

  void _clearAndShowResult() {
    _clearResult();
    _showResult();
  }

  Widget _buildPageContent(BuildContext context) {
    // TODO some padding and alignment depending on the device display's parameters

    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;
    final double targetPadding = deviceWidth - targetWidth;

    return Row(
      children: <Widget>[
        Expanded(
          flex: 1, // 20%
          child: Container(),
        ),
        Expanded(
          flex: 8, // 60%
          child: Container(
            margin: EdgeInsets.all(10.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _buildDescriptionTextContainer(),
                  SizedBox(
                    height: 10.0,
                  ),
                  _buildUiTextField(),
                  _buildActTextField(),
                  SizedBox(
                    height: 10.0,
                  ),
                  RaisedButton(
                    child: Text('Calculate'),
                    textColor: Colors.white,
                    onPressed: _submitForm,
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                  _buildResultTextContainer(),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1, // 20%
          child: Container(),
        )
      ],
    );
  }

  Widget _buildPageContent1(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(50.0),
          child: Center(
            child: Text("Project's parameters",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(0.0),
          child: Container(
            //margin: EdgeInsets.all(10.0),
            child: bodyData(),
          ),
        ),
      ],
    );
  }

  void _submitForm() {
    if (!_formKey.currentState.validate()) {
      _clearResult();
      _showResult();
      return;
    }
    _formKey.currentState.save();
    _showResult();
  }

  Widget bodyData() {
    return DataTable(
        onSelectAll: (b) {},
        //sortColumnIndex: 1,
        sortAscending: true,
        columns: <DataColumn>[
          DataColumn(
            label: Text(
                "Name",
                textAlign: TextAlign.center,),
            numeric: false,
            onSort: (i, b) {
              print("$i $b");
              setState(() {
                acts.sort((a, b) => a.name.compareTo(b.name));
              });
            },
            //tooltip: "To display  name of the Name",
          ),
          DataColumn(
            label: Flexible(child: Text("From")),
            numeric: false,
            onSort: (i, b) {
              print("$i $b");
              setState(() {
                acts.sort((a, b) => a.from.compareTo(b.from));
              });
            },
            //tooltip: "To display last name of the Name",
          ),
          DataColumn(
            label: Flexible(child: Text("To")),
            numeric: false,
            onSort: (i, b) {
              print("$i $b");
              setState(() {
                acts.sort((a, b) => a.to.compareTo(b.to));
              });
            },
            //tooltip: "To display last name of the Name",
          ),
          DataColumn(
            label: Flexible(child: Text("Probably")),
            numeric: false,
            onSort: (i, b) {
              print("$i $b");
              setState(() {
                acts.sort((a, b) => a.probably.compareTo(b.probably));
              });
            },
            //tooltip: "To display last name of the Name",
          ),
        ],
        rows: acts
            .map(
              (acts) => DataRow(
                    cells: [
                      DataCell(
                        Text(acts.name),
                        showEditIcon: false,
                        placeholder: false,
                      ),
                      DataCell(
                        Text(acts.from.toString()),
                        showEditIcon: false,
                        placeholder: false,
                      ),
                      DataCell(
                        Text(acts.to.toString()),
                        showEditIcon: false,
                        placeholder: false,
                      ),
                      DataCell(
                        Text(acts.probably.toString()),
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
    final Widget pageContent = _buildPageContent(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: _buildPageContent1(context),
      ),
    );
  }
}

class Activity {
  String name;
  int from;
  int to;
  int probably;

  Activity({this.name, this.from,this.to,this.probably});
}

var acts = <Activity>[
  Activity(name: "UI", from: 1, to: 3, probably: 2),
  Activity(name: "Act", from: 2, to: 2, probably: 3),
  Activity(name: "Business obj", from: 3, to: 1, probably: 1),
];
