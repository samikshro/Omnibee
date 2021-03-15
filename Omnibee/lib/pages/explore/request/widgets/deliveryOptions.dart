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

  static List _chooseTimeRange(TimeOfDay currentTime) {
    final today = DateTime.now();
    DateTime currentTimeToday = DateTime(
      today.year,
      today.month,
      today.day,
      currentTime.hour,
      currentTime.minute,
    );

    DateTime elevenAM = DateTime(
      today.year,
      today.month,
      today.day,
      11,
      0,
    );

    DateTime onePM = DateTime(
      today.year,
      today.month,
      today.day,
      13,
      0,
    );

    DateTime twoPM = DateTime(
      today.year,
      today.month,
      today.day,
      14,
      0,
    );

    DateTime sixPM = DateTime(
      today.year,
      today.month,
      today.day,
      18,
      0,
    );

    DateTime eightPM = DateTime(
      today.year,
      today.month,
      today.day,
      20,
      0,
    );

    DateTime ninePM = DateTime(
      today.year,
      today.month,
      today.day,
      21,
      0,
    );

    final int currentMs = currentTimeToday.millisecondsSinceEpoch;
    final int tenMinInMs = Duration(minutes: 10).inMilliseconds;

    DateTime currentRoundedTime = DateTime.fromMillisecondsSinceEpoch(
        currentMs + (tenMinInMs - (currentMs % tenMinInMs)));

    if (currentTimeToday.isBefore(onePM)) {
      // lunch period
      TimeOfDay startTime = (currentRoundedTime.isBefore(elevenAM))
          ? TimeOfDay(hour: elevenAM.hour, minute: elevenAM.minute)
          : TimeOfDay(
              hour: currentRoundedTime.hour, minute: currentRoundedTime.minute);
      return [
        startTime,
        TimeOfDay(hour: twoPM.hour, minute: twoPM.minute),
        true
      ];
    } else if (currentTimeToday.isAfter(onePM) &&
        currentTimeToday.isBefore(eightPM)) {
      // dinner period
      TimeOfDay startTime = (currentRoundedTime.isBefore(sixPM))
          ? TimeOfDay(hour: sixPM.hour, minute: sixPM.minute)
          : TimeOfDay(
              hour: currentRoundedTime.hour, minute: currentRoundedTime.minute);
      return [
        startTime,
        TimeOfDay(hour: ninePM.hour, minute: ninePM.minute),
        true
      ];
    } else {
      DateTime tomorrowElevenAM = elevenAM.add(new Duration(days: 1));
      TimeOfDay startTime = TimeOfDay(
          hour: tomorrowElevenAM.hour, minute: tomorrowElevenAM.minute);
      DateTime tomorrowTwoPM = twoPM.add(new Duration(days: 1));
      TimeOfDay endTime =
          TimeOfDay(hour: tomorrowTwoPM.hour, minute: tomorrowTwoPM.minute);
      return [startTime, endTime, false];
    }
  }

  // final TimeOfDay startTime = _roundTimeOfDay(TimeOfDay.now().add(minutes: 10));
  final List timeRange = _chooseTimeRange(TimeOfDay.now().add(minutes: 10));

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
            firstTime: timeRange[0], //start time
            lastTime: timeRange[1], //end time
            timeStep: 10,
            timeBlock: 30,
            onRangeCompleted: (range) {
              try {
                //TODO: do next day boolean
                bool sameDay = timeRange[2];

                final now = sameDay
                    ? new DateTime.now()
                    : new DateTime.now().add(Duration(days: 1));
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
