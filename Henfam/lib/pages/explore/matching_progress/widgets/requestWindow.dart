import 'package:Henfam/widgets/miniHeader.dart';
import 'package:Henfam/widgets/raisedGradientButton.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RequestWindow extends StatelessWidget {
  final date;
  final range;

  RequestWindow(this.date, this.range);

  String getDay(DateTime date) {
    final today = DateTime.now();
    return (today.day == date.day) ? "Today" : "Tomorrow";
  }

  String getTimes(DateTime date, DateTime range) {
    final interval = Duration(hours: range.hour, minutes: range.minute);
    final endDate = date.add(interval);

    final formatter = DateFormat.jm();
    final startTime = formatter.format(date);
    final endTime = formatter.format(endDate);

    return '$startTime - $endTime';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Divider(
          color: Colors.grey,
        ),
        MiniHeader('Request Window'),
        Divider(
          color: Colors.grey,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Text(
            '${getDay(date)}\n${getTimes(date, range)}',
            style: TextStyle(fontSize: 24),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              RaisedGradientButton(
                child: Text(
                  'Edit Window',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                gradient: LinearGradient(
                  colors: [Colors.orange, Colors.amber],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                width: 160,
                onPressed: () {},
              ),
              RaisedGradientButton(
                child: Text(
                  'Cancel Request',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                gradient: LinearGradient(
                  colors: [Colors.red, Colors.pink],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                width: 160,
                onPressed: () {},
              )
            ],
          ),
        ),
      ],
    );
  }
}
