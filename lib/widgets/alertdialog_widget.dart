import 'package:flutter/material.dart';
import 'package:projectb/shared/string_texts.dart';

void showDialogWidget(
    context, String title, String content, String btnText, Function function) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.redAccent)),
              child: Text(btnText),
              onPressed: () {
                function();
                Navigator.of(context).pop();
              }),
          ElevatedButton(
            child: Text(closeText),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
