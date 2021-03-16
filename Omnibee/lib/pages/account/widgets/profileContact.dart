import 'package:Omnibee/pages/account/widgets/customTile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileContact extends StatelessWidget {
  final Function signOut;

  ProfileContact(this.signOut);

  Function _showHelpInfo(BuildContext context) {
    return () {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
                  child: RichText(
                      text: TextSpan(children: [
                    new TextSpan(
                      text: 'This is no Link, ',
                      style: new TextStyle(color: Colors.black),
                    ),
                    new TextSpan(
                      text: 'but this is',
                      style: new TextStyle(color: Colors.blue),
                      recognizer: new TapGestureRecognizer()
                        ..onTap = () {
                          launch('https://omnibee.io/faq');
                        },
                    ),
                  ])

                      //  Text(
                      //     "You can view a list of frequently asked questions <link to faq>here</link>. If you need more help, please contact us by phone or email. \n\nhello@omnibee.io\n(607)269-8901 (Urgent enquiries)",
                      //     // 'For errors and feedback, please contact us by phone or email:\n\nhello@omnibee.io\n(607)269-8901',
                      //     style: TextStyle(fontSize: 18)),

                      )),
              Center(
                child: CupertinoButton(
                    color: Theme.of(context).primaryColor,
                    child: Text("Close"),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              ),
            ],
          );
        },
      );
    };
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CustomTile(label: 'Help', onTap: _showHelpInfo(context)),
          CustomTile(label: 'Log out', onTap: signOut),
        ],
      ),
    );
  }
}
