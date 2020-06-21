import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:Henfam/pages/explore/request/customSlider.dart';

class Request extends StatefulWidget {
  @override
  _RequestState createState() => _RequestState();
}

class _RequestState extends State<Request> {
  var _date = DateTime.now();
  var _time = TimeOfDay.now();
  var _timeWindow = 0.0;

  void _setTimeWindow(value) {
    setState(() {
      _timeWindow = value;
    });
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime.now(),
      lastDate: DateTime(2021),
    );

    if (picked != null && picked != _date) {
      setState(() {
        _date = picked;
      });
    }
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: _time,
    );

    if (picked != null && picked != _time) {
      setState(() {
        _time = picked;
      });
    }
  }

  String _formatTime(DateTime date, TimeOfDay time) {
    final timeFormatter = DateFormat('jm');

    final minutesBefore = -(_timeWindow * 50 + 10).round();
    final range = Duration(minutes: minutesBefore);
    final lowerBound = date.add(range);

    String formattedUpperBound = timeFormatter.format(date);
    String formattedLowerBound = timeFormatter.format(lowerBound);

    return "$formattedLowerBound-$formattedUpperBound";
  }

  String _formatDate(DateTime date, TimeOfDay time) {
    final dateFormatter = DateFormat('EEEE, MMMM d');
    String formattedDate = dateFormatter.format(date);
    return "$formattedDate";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text(
          'Your Request',
          // style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                "Delivery Options",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                "When do you want it by?",
                style: TextStyle(fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 40),
                    child: RaisedButton(
                      child: Text('Select Date'),
                      onPressed: () {
                        _selectDate(context);
                      },
                    ),
                  ),
                  RaisedButton(
                    child: Text('Select Time'),
                    onPressed: () {
                      _selectTime(context);
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                "How many minutes sooner can it arrive?",
                style: TextStyle(fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: CustomSlider(
                timeWindow: _timeWindow,
                setTimeWindow: _setTimeWindow,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(_formatTime(_date, _time),
                  style: TextStyle(fontSize: 12)),
            ),
          ],
        ),
      ),
    );
  }
}
