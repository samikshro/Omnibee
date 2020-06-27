import 'package:Henfam/pages/explore/matching_progress/widgets/requestWindow.dart';
import 'package:flutter/material.dart';

class DateAndRange {
  DateTime date;
  DateTime range;

  DateAndRange(this.date, this.range);
}

class MatchingProgress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DateAndRange args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        appBar: AppBar(
          title: Text('Errand Request'),
          backgroundColor: Colors.grey,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(15),
              child: Text(
                'Matching in Progress...',
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.orange,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Text(
                'We will notify you once a runner is found!',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
            ),
            RequestWindow(args.date, args.range),
          ],
        ));
  }
}
