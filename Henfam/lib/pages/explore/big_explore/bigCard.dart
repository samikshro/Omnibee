import 'package:flutter/material.dart';

class BigCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const ListTile(
            leading: Icon(Icons.album),
            title: Text('Oiishi Bowl'),
            subtitle: Text('Olin Library: Deliver food to Sandra'),
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
