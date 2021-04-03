import 'package:Omnibee/models/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CallPhoneNumber extends StatelessWidget {
  final Order order;
  final double fontSize;
  final bool isRunner;

  CallPhoneNumber(this.order, this.fontSize, this.isRunner);

  static void launchURL(String s) async {
    String url = s;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    String callbuttonTxt = isRunner ? "Call Requester" : "Call Errand Runner";
    String textbuttonTxt = isRunner ? "Text Requester" : "Text Errand Runner";
    return Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
        child: Column(
          children: [
            CupertinoButton(
              color: Theme.of(context).primaryColor,
              child: Text(
                callbuttonTxt,
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.normal,
                ),
              ),
              onPressed: () {
                if (isRunner) {
                  launchURL("tel:${order.phone}");
                } else {
                  launchURL("tel:${order.runnerPhone}");
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: CupertinoButton(
                color: Theme.of(context).primaryColor,
                child: Text(
                  textbuttonTxt,
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                onPressed: () {
                  if (isRunner) {
                    launchURL("sms:${order.phone}");
                  } else {
                    launchURL("sms:${order.runnerPhone}");
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
