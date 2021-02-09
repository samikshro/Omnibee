import 'dart:async';
import 'package:Henfam/models/order.dart';
import 'package:Henfam/pages/explore/explore_card/widgets/callPhoneNumber.dart';
import 'package:Henfam/pages/explore/explore_card/widgets/deliveryInstructions.dart';
import 'package:Henfam/pages/explore/explore_card/widgets/deliveryInfo.dart';
import 'package:Henfam/pages/explore/explore_card/widgets/displayItems.dart';
import 'package:Henfam/services/paymentService.dart';
import 'package:Henfam/widgets/mediumTextSection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Henfam/bloc/blocs.dart';

class OrderCardPage extends StatefulWidget {
  @override
  _OrderCardPageState createState() => _OrderCardPageState();
}

class _OrderCardPageState extends State<OrderCardPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  double fontSize = 19;
  double boldFontSize = 22;

  Widget _getOrderInformation(Order order) {
    double subtotal = order.getSubtotal();
    return Padding(
      padding: const EdgeInsets.only(left: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Items:',
            style:
                TextStyle(fontWeight: FontWeight.bold, fontSize: boldFontSize),
          ),
          DisplayItems(order, fontSize),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text("Subtotal: \$$subtotal",
                style: TextStyle(fontSize: fontSize)),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(
                "Total Fees: \$" +
                    PaymentService.getTotalFees(subtotal).toStringAsFixed(2),
                style: TextStyle(fontSize: fontSize)),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(
                "Tax: \$" +
                    (PaymentService.getTaxedPrice(subtotal) - subtotal)
                        .toStringAsFixed(2),
                style: TextStyle(fontSize: fontSize)),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(
                "Total: \$" +
                    PaymentService.getPCharge(subtotal).toStringAsFixed(2),
                style: TextStyle(fontSize: fontSize)),
          ),
        ],
      ),
    );
  }

  Widget _controlButtons(Order order, BuildContext context) {
    if (order.isDelivered == true || order.isAccepted) {
      return Container();
    } else {
      return Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Center(
          child: CupertinoButton(
            color: Theme.of(context).primaryColor,
            child: Text(
              "Cancel Order",
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.normal,
              ),
            ),
            onPressed: () {
              BlocProvider.of<OrderBloc>(context).add(OrderDeleted(order));

              final snackBar = SnackBar(
                content: Text('Order successfully cancelled!'),
              );
              _scaffoldKey.currentState.showSnackBar(snackBar);
              Timer(Duration(seconds: 2), () {
                Navigator.pop(context);
              });
            },
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final int isDeliveryPage = 0;
    final Order order = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Order'),
      ),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.only(bottom: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            MediumTextSection("Delivery Information"),
            if (!order.isExpired() &&
                order.isAccepted) //TODO: test these conditions
              CallPhoneNumber(order, fontSize, false),
            DeliveryInfo(order, fontSize, boldFontSize, isDeliveryPage),
            DeliveryInstructions(order, fontSize, boldFontSize),
            MediumTextSection("Order Information"),
            _getOrderInformation(order),
            _controlButtons(order, context),
          ],
        ),
      ),
    );
  }
}
