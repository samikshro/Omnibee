import 'package:flutter/material.dart';

class CustomTile extends StatelessWidget {
  final String label;
  final Function onTap;

  CustomTile({this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap();
        }
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
          side: BorderSide(
            color: Colors.black45,
          ),
        ),
        child: ListTile(
          title: Text(
            label,
            style: TextStyle(fontSize: 18),
          ),
          trailing: Icon(Icons.arrow_right),
        ),
      ),
    );
  }
}
