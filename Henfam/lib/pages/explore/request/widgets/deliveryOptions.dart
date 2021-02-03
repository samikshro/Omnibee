import 'package:Henfam/widgets/mediumTextSection.dart';
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

  @override
  Widget build(BuildContext context) {
    // TODO: fix font sizes on smaller iphones if needed
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          MediumTextSection('Delivery Window'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Text('In what time range do you want your food?'),
          ),
          Container(
              width: double.infinity,
              margin: EdgeInsets.fromLTRB(15, 10, 10, 10),
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
              final endtime = DateTime(now.year, now.month, now.day,
                  range.end.hour, range.end.minute);
              setGlobalDate(DateTime(now.year, now.month, now.day,
                  range.start.hour, range.start.minute));
              setGlobalEndDate(endtime);
              final expiretime = endtime.subtract(new Duration(minutes: 20));
              setState(() => expiration = RichText(
                    text: TextSpan(
                        text: 'Note: Your request will ',
                        style: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.normal),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'expire ',
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: 'if no one accepts it at ',
                            style: TextStyle(
                                color: Colors.grey,
                                // fontSize: 20,
                                fontWeight: FontWeight.normal),
                          ),
                          TextSpan(
                            text: DateFormat('h:mm aa MM/dd/yy')
                                .format(expiretime),
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: ' (20m before final delivery time).',
                            style: TextStyle(
                                color: Colors.grey,
                                // fontSize: 20,
                                fontWeight: FontWeight.normal),
                          ),
                        ]),
                  ));

              // "Note: Your request will expire if no one accepts it at " +
              //     expiretime.toString() +
              //     " (20m before final delivery time).");
            },
          )
        ],
      ),
    );
  }
}
