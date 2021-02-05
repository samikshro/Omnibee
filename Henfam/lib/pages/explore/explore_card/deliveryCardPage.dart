import 'package:Henfam/models/order.dart';
import 'package:Henfam/bloc/blocs.dart';
import 'package:Henfam/pages/explore/explore_card/widgets/callPhoneNumber.dart';
import 'package:Henfam/pages/explore/explore_card/widgets/deliveryInstructions.dart';
import 'package:Henfam/pages/explore/explore_card/widgets/deliveryInfo.dart';
import 'package:Henfam/pages/explore/explore_card/widgets/displayItems.dart';
import 'package:Henfam/services/paymentService.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Henfam/widgets/mediumTextSection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DeliveryCardPage extends StatelessWidget {
  final double fontSize = 19;
  final double boldFontSize = 22;

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
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () {
            BlocProvider.of<OrderBloc>(context).add(OrderMarkDelivered(order));
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
    final Order order = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your Delivery',
          style: TextStyle(fontSize: fontSize),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            MediumTextSection('Delivery Information'),
            CallPhoneNumber(order, boldFontSize, true),
            DeliveryInfo(order, fontSize, boldFontSize),
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
