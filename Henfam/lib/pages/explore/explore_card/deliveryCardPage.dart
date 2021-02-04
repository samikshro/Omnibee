import 'package:Henfam/models/order.dart';
import 'package:Henfam/bloc/blocs.dart';
import 'package:Henfam/services/paymentService.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Henfam/widgets/mediumTextSection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DeliveryCardPage extends StatelessWidget {
  final double fontSize = 19;
  final double boldFontSize = 22;

  Widget _displayStatus(Order order, BuildContext context) {
    if (order.isDelivered) {
      return Center(
        child: Text(
          'Waiting for confirmation from recipient...',
          style: TextStyle(fontSize: fontSize),
        ),
      );
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

  static void launchURL(String s) async {
    String url = s;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget _callPhoneNumber(Order order, BuildContext context) {
    return Center(
      child: CupertinoButton(
        color: Theme.of(context).primaryColor,
        child: Text(
          "Call Requester",
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () {
          launchURL("tel:${order.phone}");
        },
      ),
    );
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
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
          child: Text(
            'Items:',
            style:
                TextStyle(fontWeight: FontWeight.bold, fontSize: boldFontSize),
          ),
        ),
        _getYourItems(order),
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
          child: Text(
              "Total Price: " +
                  (PaymentService.getTaxedPrice(subtotal)).toStringAsFixed(2),
              style: TextStyle(fontSize: fontSize)),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
          child: Text(
              "Earnings: " +
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

  List<Widget> _getAddOns(List<dynamic> addOns) {
    if (addOns.length == 0) {
      return [Container()];
    }

    List<Widget> output = [];
    addOns.forEach((addOn) {
      output.add(Padding(
        padding: EdgeInsets.fromLTRB(15, 10, 0, 10),
        child: Text(
          addOn,
          style: TextStyle(fontSize: fontSize),
        ),
      ));
    });

    return output;
  }

  Widget _getYourItems(Order order) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 5, 0, 10),
      child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: order.basket.length,
          itemBuilder: (BuildContext context, int index) {
            return ExpansionTile(
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              expandedAlignment: Alignment.bottomLeft,
              title: Text(
                order.basket[index]['name'],
                style: TextStyle(fontSize: fontSize),
              ),
              subtitle: Text(
                '\$${order.basket[index]['price']}',
                style: TextStyle(fontSize: fontSize),
              ),
              trailing: Icon(Icons.arrow_drop_down),
              children: _getAddOns(order.basket[index]['add_ons']),
            );
          }),
    );
  }

  Widget _getDeliveryWindow(Order order) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 5, 20, 10),
      child: Text(
        "Deliver from ${order.getDeliveryWindow()}",
        style: TextStyle(fontSize: fontSize),
      ),
    );
  }

  Widget _getDeliveryLocation(Order order) {
    List<String> wordList = order.location.split(',');
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 5, 0, 10),
      child: Text(
        wordList[0],
        style: TextStyle(fontSize: fontSize),
      ),
    );
  }

  Widget _getDeliveryInformation(Order order) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
          child: Text(
            'Delivery Window:',
            style:
                TextStyle(fontWeight: FontWeight.bold, fontSize: boldFontSize),
          ),
        ),
        _getDeliveryWindow(order),
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
          child: Text(
            'Destination:',
            style:
                TextStyle(fontWeight: FontWeight.bold, fontSize: boldFontSize),
          ),
        ),
        _getDeliveryLocation(order),
      ],
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
            _callPhoneNumber(order, context),
            _getDeliveryInformation(order),
            MediumTextSection('Order Information'),
            _getOrderInformation(order),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: _displayStatus(order, context),
            ),
          ],
        ),
      ),
    );
  }
}
