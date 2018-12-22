import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NewActivityPage extends StatefulWidget {
  final String title = "Новая задача";

  NewActivityPage({Key key}) : super(key: key);

  @override
  _NewActivityPageState createState() => _NewActivityPageState();
}

class _NewActivityPageState extends State<NewActivityPage> {
  final Map<String, dynamic> _addActivityFormData = {
    'name': null,
    'from': null,
    'to': null,
    'probably': null,
  };

  final GlobalKey<FormState> _addActivityFormKey = GlobalKey<FormState>();

  bool _isANumber(value) {
    return RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]').hasMatch(value);
  }

  Widget _buildNameTextField() {
    return TextFormField(
      //keyboardType: TextInputType.,
      //controller: _uiTextController,
      decoration: InputDecoration(labelText: 'Имя'),
      validator: (String value) {
        if (value.isEmpty || value.length > 30) {
          return 'Введите имя длиной не более 30 символов';
        }
      },
      onSaved: (String value) {
        _addActivityFormData['name'] = value;
      },
    );
  }

  Widget _buildFromTextField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
      //controller: _uiTextController,
      decoration: InputDecoration(labelText: 'От'),
      validator: (String value) {
        if (value.isEmpty || !_isANumber(value)) {
          return 'Введите число';
        }
      },
      onSaved: (String value) {
        _addActivityFormData['from'] = double.parse(value);
      },
    );
  }

  Widget _buildToTextField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
      //controller: _uiTextController,
      decoration: InputDecoration(labelText: 'До'),
      validator: (String value) {
        if (value.isEmpty || !_isANumber(value)) {
          return 'Введите число';
        }
      },
      onSaved: (String value) {
        _addActivityFormData['to'] = double.parse(value);
      },
    );
  }

  Widget _buildProbablyTextField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
      //controller: _uiTextController,
      decoration: InputDecoration(labelText: 'Вероятно'),
      validator: (String value) {
        if (value.isEmpty || !_isANumber(value)) {
          return 'Введите число';
        }
      },
      onSaved: (String value) {
        _addActivityFormData['probably'] = double.parse(value);
      },
    );
  }

  Widget _buildPageContent(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.9;
    final double targetPadding = deviceWidth - targetWidth;

    return Container(
      padding: EdgeInsets.all(targetPadding),
      child: Form(
        key: _addActivityFormKey,
        child: Column(
          children: <Widget>[
            Center(
              child: Text("Информация о задаче",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              height: 20,
            ),
            _buildNameTextField(),
            _buildFromTextField(),
            _buildToTextField(),
            _buildProbablyTextField(),
            SizedBox(
              height: 20,
            ),
            RaisedButton(child: Text("Добавить задачу"),
                onPressed: _submitActivityForm),
          ],
        ),
      ),
    );
  }

  void _submitActivityForm() {
    if (!_addActivityFormKey.currentState.validate()) {
      print("not correct act");
    }else {
      _addActivityFormKey.currentState.save();
      print("saving act");
      Navigator.pop(context,_addActivityFormData);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Widget pageContent = _buildPageContent(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
        resizeToAvoidBottomPadding : false,
        body: Container(
        child: _buildPageContent(context),
      ),
    );
  }
}
