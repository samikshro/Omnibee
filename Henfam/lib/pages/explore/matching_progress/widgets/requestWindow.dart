import 'package:Henfam/widgets/miniHeader.dart';
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
        Text(
          '${getDay(date)}\n${getTimes(date, range)}',
          style: TextStyle(fontSize: 24),
        ),
      ],
    );
  }
}
