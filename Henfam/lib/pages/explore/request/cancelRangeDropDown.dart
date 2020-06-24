import 'package:flutter/material.dart';

class CancelRangeDropDown extends StatelessWidget {
  final String dropdownValue;
  final Function setCancelRange;

  CancelRangeDropDown(this.dropdownValue, this.setCancelRange);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            "Request Window",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Text("Cancel request if not matched"),
        Row(
          children: <Widget>[
            DropdownButton<String>(
                value: dropdownValue,
                icon: Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                underline: Container(
                  height: 2,
                  color: Colors.black,
                ),
                onChanged: (String newValue) {
                  setCancelRange(newValue);
                },
                items: <String>['15', '30', '45', '60']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList()),
            Text(" minutes before delivery time"),
          ],
        )
      ],
    );
  }
}
