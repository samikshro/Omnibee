import 'package:Omnibee/widgets/infoButton.dart';
import 'package:Omnibee/widgets/mediumTextSection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:time_range/time_range.dart';
import 'package:intl/intl.dart';

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
  Widget expiration;

  _DeliveryOptionsState(this.setGlobalDate, this.setGlobalEndDate);

  static TimeOfDay _roundTimeOfDay(TimeOfDay currentTime) {
    final today = DateTime.now();
    DateTime currentTimeToday = DateTime(
      today.year,
      today.month,
      today.day,
      currentTime.hour,
      currentTime.minute,
    );

    final int currentMs = currentTimeToday.millisecondsSinceEpoch;
    final int tenMinInMs = Duration(minutes: 10).inMilliseconds;

    currentTimeToday = DateTime.fromMillisecondsSinceEpoch(
        currentMs + (tenMinInMs - (currentMs % tenMinInMs)));

    return TimeOfDay(
        hour: currentTimeToday.hour, minute: currentTimeToday.minute);
  }

  final TimeOfDay startTime = _roundTimeOfDay(TimeOfDay.now().add(minutes: 10));

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(15, 0, 10, 10),
            child: Text('NOTE: Your money is only sent if you get your food!',
                style: TextStyle(fontSize: 18)),
          ),
          Row(
            children: [
              SizedBox(
                width: 230,
                child: MediumTextSection('Delivery Window'),
              ),
              InfoButton(
                titleMessage: "Delivery Window",
                bodyMessage:
                    "Choose a time range for receiving your food.\n\nThe request will expire if no one accepts it before the expiration time (20 min before the end of the time range).",
                buttonMessage: "Okay",
                buttonSize: 25,
              ),
            ],
          ),
          Container(
              width: double.infinity,
              margin: EdgeInsets.fromLTRB(15, 0, 10, 10),
              child: expiration),
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
            textStyle: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 10,
              color: Colors.black87,
            ),
            activeTextStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 10,
              color: Colors.white,
            ),
            borderColor: Colors.black54,
            backgroundColor: Colors.transparent,
            activeBackgroundColor: Theme.of(context).buttonColor,
            firstTime: startTime,
            lastTime: TimeOfDay(hour: 23, minute: 59),
            timeStep: 10,
            timeBlock: 30,
            onRangeCompleted: (range) {
              try {
                final now = new DateTime.now();
                final endtime = DateTime(now.year, now.month, now.day,
                    range.end.hour, range.end.minute);
                setGlobalDate(DateTime(now.year, now.month, now.day,
                    range.start.hour, range.start.minute));
                setGlobalEndDate(endtime);
                final expiretime = endtime.subtract(new Duration(minutes: 20));
                setState(() => expiration = RichText(
                      text: TextSpan(
                          text: 'Request will expire at ',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                          children: <TextSpan>[
                            TextSpan(
                              text: DateFormat('h:mm aa MM/dd/yy')
                                  .format(expiretime),
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ]),
                    ));
              } catch (e) {
                print("Did not select valid time range");
              }
            },
          )
        ],
      ),
    );
  }
}
