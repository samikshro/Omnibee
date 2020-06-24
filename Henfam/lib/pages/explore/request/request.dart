import 'package:Henfam/pages/explore/request/cancelRangeDropDown.dart';
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
  String _dropdownValue = '15';

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
        _date = DateTime(
          _date.year,
          _date.month,
          _date.day,
          _time.hour,
          _time.minute,
        );
      });
    }
  }

  Future<Null> _setCancelRange(String newVal) {
    setState(() {
      _dropdownValue = newVal;
    });
  }

  String _formatTime(DateTime date, TimeOfDay time) {
    final timeFormatter = DateFormat('jm');
    final d = DateTime(date.year, date.month, date.day, time.hour, time.minute);
    return "${timeFormatter.format(d)}";
  }

  String _formatTimeRange(DateTime date, TimeOfDay time) {
    final timeFormatter = DateFormat('jm');

    final minutesBefore = -(_timeWindow * 50 + 10).round();
    final range = Duration(minutes: minutesBefore);
    final lowerBound = date.add(range);

    String formattedUpperBound = timeFormatter.format(date);
    String formattedLowerBound = timeFormatter.format(lowerBound);

    return "$formattedLowerBound-$formattedUpperBound";
  }

  String _formatDate(DateTime date) {
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
        child: ExpansionTile(
          title: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              "Delivery Options",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    "When do you need it by?",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        _formatDate(_date),
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 40),
                        child: RaisedButton(
                          child: Text('Change date'),
                          onPressed: () {
                            _selectDate(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      _formatTime(_date, _time),
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 40),
                      child: RaisedButton(
                        child: Text('Change time'),
                        onPressed: () {
                          _selectTime(context);
                        },
                      ),
                    ),
                  ],
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
                  child: Text(
                    "Order will arrive between ${_formatTimeRange(_date, _time)}",
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 14,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: CancelRangeDropDown(_dropdownValue, _setCancelRange),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
