import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';

class PaymentService {
  final HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(
    functionName: 'createPaymentIntent',
  );

  _confirmDialog(
      BuildContext context, String clientSecret, PaymentMethod paymentMethod) {
    var confirm = AlertDialog(
      title: Text("Confirm Payement"),
      content: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              "Make Payment",
              // style: TextStyle(fontSize: 25),
            ),
            Text("Charge amount:\$100")
          ],
        ),
      ),
      actions: <Widget>[
        new RaisedButton(
          child: new Text('CANCEL'),
          onPressed: () {
            Navigator.of(context).pop();
            final snackBar = SnackBar(
              content: Text('Payment Cancelled'),
            );
            Scaffold.of(context).showSnackBar(snackBar);
          },
        ),
        new RaisedButton(
          child: new Text('Confirm'),
          onPressed: () {
            Navigator.of(context).pop();
            _confirmPayment(context, clientSecret,
                paymentMethod); // function to confirm Payment
          },
        ),
      ],
    );
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return confirm;
        });
  }

  _confirmPayment(
      BuildContext context, String sec, PaymentMethod paymentMethod) {
    StripePayment.confirmPaymentIntent(
      PaymentIntent(clientSecret: sec, paymentMethodId: paymentMethod.id),
    ).then((val) {
      // addPaymentDetailsToFirestore(); //Function to add Payment details to firestore
      final snackBar = SnackBar(
        content: Text('Payment Successfull'),
      );
      Scaffold.of(context).showSnackBar(snackBar);
    });
  }

  void payment(BuildContext context, double dollars) {
    StripePayment.paymentRequestWithCardForm(CardFormPaymentRequest())
        .then((paymentMethod) {
      double amount =
          dollars * 100.0; // multipliying with 100 to change $ to cents
      callable
          .call(<String, dynamic>{'amount': amount, 'currency': 'usd'}).then(
              (response) {
        _confirmDialog(context, response.data["client_secret"],
            paymentMethod); //function for confirmation for payment
      });
    });
  }

  addCard(token) {
    FirebaseAuth.instance.currentUser().then((user) {
      Firestore.instance
          .collection('users')
          .document(user.uid)
          .collection('cards')
          .add({'tokenId': token}).then((val) {
        print('saved');
      });
    });
  }
}
