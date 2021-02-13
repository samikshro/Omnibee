import 'package:Omnibee/pages/account/widgets/customTile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
                child: Text(
                    'For errors and feedback, please contact us by phone or email:\n\nhello@omnibee.io\n(607)269-8901',
                    style: TextStyle(fontSize: 18)),
              ),
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
