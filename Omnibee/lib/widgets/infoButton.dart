import 'package:flutter/material.dart';

class InfoButton extends StatelessWidget {
  final String titleMessage;
  final String bodyMessage;
  final String buttonMessage;
  final double buttonSize;

  InfoButton({
    @required this.titleMessage,
    @required this.bodyMessage,
    @required this.buttonMessage,
    @required this.buttonSize,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.info, size: buttonSize),
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text(
                    titleMessage,
                    style: TextStyle(),
                  ),
                  content: Text(
                    bodyMessage,
                    style: TextStyle(),
                  ),
                  actions: <Widget>[
                    FlatButton(
                      child: Text(
                        buttonMessage,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              });
        });
  }
}
