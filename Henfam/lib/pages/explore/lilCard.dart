import 'package:flutter/material.dart';
import 'package:Henfam/models/errandModel.dart';

class LilCard extends StatelessWidget {
  final String bigHenName;
  final String bigHenImage;
  final String timeFrame;
  final String location;
  final String destination;
  final ErrandType type;
  final int requestLimit;

  LilCard({
    this.bigHenName,
    this.bigHenImage,
    this.timeFrame,
    this.location,
    this.destination,
    this.type,
    this.requestLimit,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.album),
            title: Text("$location"),
            subtitle: Text('$bigHenName is  Deliver food to Sandra'),
          ),
          // Image.asset(

          // ),
          ButtonBar(
            children: <Widget>[
              FlatButton(
                child: const Text('SHARE'),
                onPressed: () {/* ... */},
              ),
              FlatButton(
                child: const Text('CHAT'),
                onPressed: () {/* ... */},
              ),
              FlatButton(
                child: const Text('EDIT'),
                onPressed: () {/* ... */},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
