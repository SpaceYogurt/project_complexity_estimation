import 'package:flutter/material.dart';


class Dialogs {

  addNewActivity(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Add new Activity"),
          content:  Container(
            height: MediaQuery.of(context).size.height * 0.6,
            width: MediaQuery.of(context).size.width * 0.6,
            child: Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                    labelText: "Name",
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: "From",
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: "To",
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: "Probably",
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }


}