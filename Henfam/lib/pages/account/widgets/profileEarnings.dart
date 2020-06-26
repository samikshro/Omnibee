import 'package:Henfam/pages/account/widgets/sectionHeader.dart';
import 'package:flutter/material.dart';

class ProfileEarnings extends StatelessWidget {
  final double earnings;
  final double inAccount;

  ProfileEarnings(this.earnings, this.inAccount);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SectionHeader('Your Earnings'),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
              side: BorderSide(
                color: Colors.black45,
              ),
            ),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '\$${earnings.toString()}',
                            style: TextStyle(fontSize: 22),
                          ),
                          Text('Earned'),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 15, 0),
                      child: RaisedButton(
                        onPressed: () {},
                        child: Text('View'),
                      ),
                    )
                  ],
                ),
                Divider(
                  color: Colors.grey[400],
                  height: 20,
                  thickness: 1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 0, 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '\$${inAccount.toString()}',
                            style: TextStyle(fontSize: 22),
                          ),
                          Text('In Account'),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 15, 10),
                      child: RaisedButton(
                        onPressed: () {},
                        child: Text('Transfer'),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
