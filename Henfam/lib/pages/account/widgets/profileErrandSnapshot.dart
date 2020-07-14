import 'package:Henfam/pages/account/widgets/sectionHeader.dart';
import 'package:flutter/material.dart';

class ProfileErrandSnapshot extends StatelessWidget {
  final int numRuns;
  final int numRequests;
  final int numBoosters;

  ProfileErrandSnapshot({
    this.numRuns,
    this.numRequests,
    this.numBoosters,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Row(
        children: <Widget>[
          Expanded(
            child: Column(
              children: <Widget>[
                Text(
                  "Runs",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  "5",
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                Text(
                  "Requests",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  "3",
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                Text(
                  "Boosters",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  "2",
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(15, 8, 0, 0),
        child: RaisedButton(
          child: Text("View Errand History"),
          onPressed: () {},
        ),
      )
    ]);
  }
}
