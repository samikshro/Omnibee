import 'package:Henfam/widgets/mediumTextSection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:time_range/time_range.dart';

class DeliveryOptions extends StatefulWidget {
  final Function setGlobalDate;
  final Function setGlobalEndDate;

  DeliveryOptions(this.setGlobalDate, this.setGlobalEndDate);

  @override
  _DeliveryOptionsState createState() => _DeliveryOptionsState(
        this.setGlobalDate,
        this.setGlobalEndDate,
      );
}

class _DeliveryOptionsState extends State<DeliveryOptions> {
  Function setGlobalDate;
  Function setGlobalEndDate;

  _DeliveryOptionsState(this.setGlobalDate, this.setGlobalEndDate);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        children: <Widget>[
          MediumTextSection('Delivery Window'),
          Divider(),
          TimeRange(
            fromTitle: Text(
              'From',
              style: TextStyle(fontSize: 18, color: Colors.black54),
            ),
            toTitle: Text(
              'To',
              style: TextStyle(fontSize: 18, color: Colors.black54),
            ),
            titlePadding: 20,
            textStyle:
                TextStyle(fontWeight: FontWeight.normal, color: Colors.black87),
            activeTextStyle:
                TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            borderColor: Colors.black54,
            backgroundColor: Colors.transparent,
            activeBackgroundColor: Theme.of(context).buttonColor,
            firstTime: TimeOfDay.now(),
            lastTime: TimeOfDay(hour: 23, minute: 59),
            timeStep: 10,
            timeBlock: 30,
            onRangeCompleted: (range) {
              final now = new DateTime.now();
              setGlobalDate(DateTime(now.year, now.month, now.day,
                  range.start.hour, range.start.minute));
              setGlobalEndDate(DateTime(now.year, now.month, now.day,
                  range.end.hour, range.end.minute));
            },
          )
        ],
      ),
    );
  }
}
