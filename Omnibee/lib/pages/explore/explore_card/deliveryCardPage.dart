import 'package:Omnibee/models/order.dart';
import 'package:Omnibee/bloc/blocs.dart';
import 'package:Omnibee/pages/explore/explore_card/widgets/callPhoneNumber.dart';
import 'package:Omnibee/pages/explore/explore_card/widgets/deliveryInstructions.dart';
import 'package:Omnibee/pages/explore/explore_card/widgets/deliveryInfo.dart';
import 'package:Omnibee/pages/explore/explore_card/widgets/displayItems.dart';
import 'package:Omnibee/services/paymentService.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Omnibee/widgets/mediumTextSection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DeliveryCardPage extends StatelessWidget {
  final double fontSize = 19;
  final double boldFontSize = 22;

  void _markOrderComplete(Order order, BuildContext context) {
    final snackBar = SnackBar(
      content: Text('Confirming delivery, please wait one moment....'),
    );
    Scaffold.of(context).showSnackBar(snackBar);

    double pCharge = order.price;
    double applicationFee = order.applicationFee;

    print(
        "MarkOrderComplete: pcharge is $pCharge and applicationFee is $applicationFee");

    PaymentService.paymentTransfer(
      order,
      context,
      pCharge,
      applicationFee,
      order.paymentMethodId,
      order.stripeAccountId,
    );
  }

  Widget _controlButtons(Order order, BuildContext context) {
    if (order.isDelivered) {
      return Container();
    } else {
      return Center(
        child: CupertinoButton(
          color: Theme.of(context).primaryColor,
          child: Text(
            "Mark Delivered",
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.normal,
            ),
          ),
          onPressed: () {
            BlocProvider.of<OrderBloc>(context).add(OrderMarkDelivered(order));
            _markOrderComplete(order, context);
            Navigator.pop(context);
          },
        ),
      );
    }
  }

  Widget _getOrderInformation(Order order) {
    double subtotal = order.getSubtotal();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
          child: Text(
            'Name:',
            style:
                TextStyle(fontWeight: FontWeight.bold, fontSize: boldFontSize),
          ),
        ),
        _getRequesterName(order),
        DeliveryInstructions(order, fontSize, boldFontSize),
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
          child: Text(
            'Change Order:',
            style:
                TextStyle(fontWeight: FontWeight.bold, fontSize: boldFontSize),
          ),
        ),
        Padding(
            padding: const EdgeInsets.fromLTRB(30, 5, 0, 10),
            child: RichText(
                text: TextSpan(children: [
              new TextSpan(
                text:
                    'If the item(s) the requester asked for are sold out, please call the requester. Ask if they want to cancel or change the order, and then fill out this ',
                style: new TextStyle(color: Colors.black, fontSize: 13),
              ),
              new TextSpan(
                text: 'form. ',
                style: new TextStyle(color: Colors.blue, fontSize: 13),
                recognizer: new TapGestureRecognizer()
                  ..onTap = () {
                    launch('https://runnerhelp.omnibee.io');
                  },
              ),
            ]))),
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
          child: Text(
            'Items:',
            style:
                TextStyle(fontWeight: FontWeight.bold, fontSize: boldFontSize),
          ),
        ),
        DisplayItems(order, fontSize),
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
          child: Text(
              "Total Price: \$" +
                  (PaymentService.getTaxedPrice(subtotal)).toStringAsFixed(2),
              style: TextStyle(fontSize: fontSize)),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
          child: Text(
              "Earnings: \$" +
                  PaymentService.getDelivererFee(subtotal).toStringAsFixed(2),
              style: TextStyle(fontSize: fontSize)),
        ),
      ],
    );
  }

  Widget _getRequesterName(Order order) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 5, 0, 10),
      child: Text(
        order.name,
        style: TextStyle(fontSize: fontSize),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final int isDeliveryPage = 1;
    final Order order = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Delivery',
          style: TextStyle(fontSize: fontSize),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            MediumTextSection('Delivery Information'),
            if (!order.isReceived) CallPhoneNumber(order, fontSize, true),
            DeliveryInfo(order, fontSize, boldFontSize, isDeliveryPage, true),
            MediumTextSection('Order Information'),
            _getOrderInformation(order),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: _controlButtons(order, context),
            ),
          ],
        ),
      ),
    );
  }
}
