import 'package:Henfam/models/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CallPhoneNumber extends StatelessWidget {
  final Order order;
  final double boldFontSize;
  final bool isRunner;

  CallPhoneNumber(this.order, this.boldFontSize, this.isRunner);

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
    String buttonTxt = isRunner ? "Call Requester" : "Call Errand Runner";
    return Center(
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 10, 0, 20),
        child: CupertinoButton(
          color: Theme.of(context).primaryColor,
          child: Text(
            buttonTxt,
            style: TextStyle(
              fontSize: boldFontSize,
              fontWeight: FontWeight.bold,
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
      ),
    );
  }
}
