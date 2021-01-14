import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stripe_payment/stripe_payment.dart';
import './lilMode.dart';

class Explore extends StatefulWidget {
  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  void _switchToBig() {
    Navigator.pushNamed(context, '/bigmode');
  }

  @override
  void initState() {
    super.initState();
    StripePayment.setOptions(StripeOptions(
        publishableKey:
            "pk_test_51HBOnhBJxTPXZlKXyxpYx1AuofRnDaDscu3mpP2pT7GLWkUkZc0vTXAEOo0hCevsSMPomSFTon4eiclxw9UZNB9Q00Qw2XOOPt",
        merchantId: "merchant.io.omnibee",
        androidPayMode: 'test'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Explore'),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10),
                ),
                CupertinoButton(
                  color: Theme.of(context).primaryColor,
                  child: Text(
                    "Run an Errand",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: _switchToBig,
                ),
              ],
            ),
            LilMode()
          ],
        ),
      ),
    );
  }
}
