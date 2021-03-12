import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stripe_payment/stripe_payment.dart';
import './lilMode.dart';

class Explore extends StatefulWidget {
  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  @override
  void initState() {
    super.initState();
    StripePayment.setOptions(StripeOptions(
        publishableKey:
            "pk_live_51HBOnhBJxTPXZlKX6lttyaTTTKJnYgdiLzDOVMKGoc2Y9Qfjju9SrunA5j8uJmpq7uuVtBFTzc5eA54dW9vvVYfx00FHpgEPHe",
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
                    onPressed: () {
                      Navigator.pushNamed(context, '/bigmode');
                    }),
              ],
            ),
            LilMode()
          ],
        ),
      ),
    );
  }
}
