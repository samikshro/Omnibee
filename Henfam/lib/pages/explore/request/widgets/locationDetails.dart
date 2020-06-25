import 'package:Henfam/pages/explore/request/widgets/miniHeader.dart';
import 'package:Henfam/widgets/mediumTextSection.dart';
import 'package:flutter/material.dart';

class LocationDetails extends StatelessWidget {
  final String location;

  LocationDetails(this.location);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        MediumTextSection('Location Details'),
        Divider(
          color: Colors.grey,
        ),
        MiniHeader('Building / Place Name'),
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 8, 0, 8),
          child: Text(
            location,
            style: TextStyle(
              fontSize: 22,
            ),
          ),
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
                  color: Colors.amber,
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
