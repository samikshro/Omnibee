import 'package:Henfam/widgets/mediumTextSection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

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

  final _date = DateTime.now();
  final _endDate = DateTime.now().add(new Duration(hours: 1));

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        children: <Widget>[
          MediumTextSection('Delivery Window'),
          Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 25.0),
            child: Text(
              "Deliver from",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                const Radius.circular(20.0),
              ),
            ),
            child: SizedBox(
              height: 100,
              width: 350,
              child: CupertinoDatePicker(
                minuteInterval: 10,
                minimumDate:
                    _date.add(Duration(minutes: 10 - _date.minute % 10)),
                maximumDate: _date.add(Duration(days: 1)),
                initialDateTime:
                    _date.add(Duration(minutes: 10 - _date.minute % 10)),
                onDateTimeChanged: (newDate) {
                  setGlobalDate(newDate);
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 25.0),
            child: Text(
              "Deliver by",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                const Radius.circular(20.0),
              ),
            ),
            child: SizedBox(
              height: 100,
              width: 350,
              child: CupertinoDatePicker(
                minuteInterval: 10,
                minimumDate:
                    _endDate.add(Duration(minutes: 10 - _endDate.minute % 10)),
                maximumDate: _date.add(Duration(days: 1)),
                initialDateTime:
                    _endDate.add(Duration(minutes: 10 - _endDate.minute % 10)),
                onDateTimeChanged: (newDate) {
                  setGlobalEndDate(newDate);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
