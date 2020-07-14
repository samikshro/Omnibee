import 'package:Henfam/widgets/miniHeader.dart';
import 'package:Henfam/widgets/mediumTextSection.dart';
import 'package:flutter/material.dart';

class LocationDetails extends StatefulWidget {
  final Function setLocation;

  LocationDetails(this.setLocation);

  @override
  _LocationDetailsState createState() => _LocationDetailsState();
}

class _LocationDetailsState extends State<LocationDetails> {
  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        MediumTextSection('Location Details'),
        Divider(),
        MiniHeader('Building / Place Name'),
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 8, 0, 8),
          child: TextField(
              controller: myController,
              style: TextStyle(
                fontSize: 22,
              ),
              onChanged: (String s) => widget.setLocation(myController.text)),
        ),
        MiniHeader('Instructions for delivery'),
        Container(
          margin: EdgeInsets.all(15),
          child: TextField(
            maxLines: 3,
            decoration: InputDecoration(
              hintText: "e.g. Leave next to couch outside map room.",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(
                  style: BorderStyle.solid,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
