import 'package:Henfam/pages/explore/request/widgets/cancelRangeDropDown.dart';
import 'package:Henfam/widgets/mediumTextSection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class DeliveryOptions extends StatefulWidget {
  final Function setGlobalDate;
  final Function setGlobalRange;

  DeliveryOptions(this.setGlobalDate, this.setGlobalRange);

  @override
  _DeliveryOptionsState createState() => _DeliveryOptionsState(
        this.setGlobalDate,
        this.setGlobalRange,
      );
}

class _DeliveryOptionsState extends State<DeliveryOptions> {
  Function setGlobalDate;
  Function setGlobalRange;

  _DeliveryOptionsState(this.setGlobalDate, this.setGlobalRange);

  String _dropdownValue = '15';

  final _date = DateTime.now();

  Future<Null> _setCancelRange(String newVal) {
    setState(() {
      _dropdownValue = newVal;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        MediumTextSection('Delivery Options'),
        Divider(
          color: Colors.grey,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
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
            border: Border.all(color: Colors.black, width: 2),
            borderRadius: BorderRadius.all(
              const Radius.circular(20.0),
            ),
          ),
          child: SizedBox(
            height: 100,
            width: 350,
            child: CupertinoDatePicker(
              minuteInterval: 10,
              minimumDate: _date.add(Duration(minutes: 10 - _date.minute % 10)),
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
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            "Range",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 2),
            borderRadius: BorderRadius.all(
              const Radius.circular(20.0),
            ),
          ),
          child: SizedBox(
            height: 80,
            width: 350,
            child: CupertinoDatePicker(
              minuteInterval: 10,
              mode: CupertinoDatePickerMode.time,
              use24hFormat: true,
              minimumDate: DateTime(_date.year, _date.month, _date.day, 0, 30),
              maximumDate: DateTime(_date.year, _date.month, _date.day)
                  .add(Duration(hours: 4)),
              initialDateTime: DateTime(_date.year, _date.month, _date.day),
              onDateTimeChanged: (newRange) {
                setGlobalRange(newRange);
              },
            ),
          ),
        ),
        CancelRangeDropDown(_dropdownValue, _setCancelRange),
      ],
    );
    ;
  }
}
