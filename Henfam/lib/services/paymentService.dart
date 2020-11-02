import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:Henfam/pages/account/profile.dart';

class PaymentService {
  static final HttpsCallable paymentIntent =
      CloudFunctions.instance.getHttpsCallable(
    functionName: 'createPaymentIntent',
  );

  static final HttpsCallable createConnAccount =
      CloudFunctions.instance.getHttpsCallable(
    functionName: 'payments-createConnectedAccount',
  );

  static final HttpsCallable createConnAccountLink =
      CloudFunctions.instance.getHttpsCallable(
    functionName: 'payments-createAccountLink',
  );

  static final HttpsCallable updateConnAccountLink =
      CloudFunctions.instance.getHttpsCallable(
    functionName: 'payments-updateAccountLink',
  );

  static final HttpsCallable paymentIntentTransfer =
      CloudFunctions.instance.getHttpsCallable(
    functionName: 'payments-createPaymentIntentTransfer',
  );

  static final HttpsCallable retrieveBalance =
      CloudFunctions.instance.getHttpsCallable(
    functionName: 'payments-retrieveBalance',
  );

  static void _printSuccess(BuildContext context) {
    // addPaymentDetailsToFirestore(); //Function to add Payment details to firestore
    final snackBar = SnackBar(
      content: Text('Removed order card'),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

  static void mergeOrder(DocumentSnapshot doc) {
    final db = Firestore.instance;
    print("merging!");
    db
        .collection('orders')
        .document(doc.documentID)
        .setData({'is_received': true}, merge: true);
  }

  static bool _paymentCallback(DocumentSnapshot doc, String status) {
    switch (status) {
      case "succeeded":
        {
          mergeOrder(doc);
          return true;
        }
        break;
      default:
        {
          return false;
        }
        break;
    }
  }

  static void _confirmPayment(DocumentSnapshot doc, BuildContext context,
      String sec, String paymentMethodID) async {
    StripePayment.confirmPaymentIntent(
      PaymentIntent(clientSecret: sec, paymentMethodId: paymentMethodID),
    ).then((val) {
      // addPaymentDetailsToFirestore(); //Function to add Payment details to firestore
      final snackBar = SnackBar(
        content: Text('Payment Successful'),
      );
      Scaffold.of(context).showSnackBar(snackBar);

      print("status: " + val.status);

      _paymentCallback(doc, val.status);
    }).catchError((error, stackTrace) {
      print("error!");
    }).whenComplete(() => _printSuccess(context));
  }

  static void payment(DocumentSnapshot doc, BuildContext context,
      double dollars, String paymentMethodID) async {
    double amount =
        dollars * 100.0; // multipliying with 100 to change $ to cents
    paymentIntent.call(<String, dynamic>{
      'amount': amount,
      'currency': 'usd',
      'paymentMethod': paymentMethodID,
    }).then((response) async {
      // _confirmDialog(context, response.data["client_secret"], paymentMethod);
      _confirmPayment(doc, context, response.data["client_secret"],
          paymentMethodID); //function for confirmation for payment
    });
  }

  static void paymentTransfer(
      DocumentSnapshot doc,
      BuildContext context,
      double dollars,
      double applicationFee,
      String paymentMethodID,
      String delivererAccountId) async {
    int amount = (dollars * 100).toInt();
    double appFeeAmount = applicationFee * 100;
    print("paymentTransfer");
    paymentIntentTransfer.call(<String, dynamic>{
      'amount': amount,
      'currency': 'usd',
      'paymentMethod': paymentMethodID,
      'fee_amount': appFeeAmount,
      'transfer_dest': delivererAccountId,
    }).then((response) async {
      // _confirmDialog(context, response.data["client_secret"], paymentMethod);
      _confirmPayment(doc, context, response.data["client_secret"],
          paymentMethodID); //function for confirmation for payment
    });
  }

  static void updateAccountLink(String accountId) {
    print("updateAccountLink");
    updateConnAccountLink.call(<String, dynamic>{
      'account_num': accountId,
    }).then((response) {
      print(response.data['url']);
      Profile.launchURL(response.data['url']);
    });
  }

  static void createAccountLink(String accountId) {
    print("createAccountLink");
    createConnAccountLink.call(<String, dynamic>{
      'account_num': accountId,
    }).then((response) {
      print(response.data['url']);
      Profile.launchURL(response.data['url']);
    });
  }

  static void createAccount(String email) {
    print("createAccount");
    createConnAccount.call(<String, dynamic>{
      'email': email,
    }).then((response) {
      FirebaseAuth.instance.currentUser().then((user) {
        Firestore.instance
            .collection('users')
            .document(user.uid)
            .updateData({'stripeAccountId': response.data["id"]});
        // .setData(
        //     {'stripeAccountId': response.data["id"]},
        //     merge: true);
      });
      createAccountLink(response.data["id"]);
    });
  }

  static Future<HttpsCallableResult> retrieveAccountBalance(String accountId) {
    return retrieveBalance.call(<String, dynamic>{
      'account_num': accountId,
    });

    // .then((response) {
    //   debugPrint("herehereher");
    //   print(response.data["pending"]);
    //   List<dynamic> z = response.data["pending"] as List<dynamic>;

    //   int balance = 0;
    //   for (int i = 0; i < z.length; i++) {
    //     balance += z[i]["amount"];
    //   }

    //   return balance;
    // });
  }
}
