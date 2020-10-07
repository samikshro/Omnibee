import 'package:Henfam/models/order.dart';
import 'package:Henfam/widgets/mediumTextSection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:Henfam/bloc/blocs.dart';

class OrderCardPage extends StatefulWidget {
  @override
  _OrderCardPageState createState() => _OrderCardPageState();
}

class _OrderCardPageState extends State<OrderCardPage> {
  String _getExpirationTime(Order order) {
    DateTime time = order.expirationTime;
    final DateFormat formatter = DateFormat('jm');
    final String formatted = formatter.format(time);
    return formatted;
  }

  String _getDeliveryLocation(Order order) {
    String location = order.location;
    List<String> wordList = location.split(',');
    return wordList[0];
  }

  String _getDeliveryWindow(Order order) {
    String startTime = order.startTime;
    String endTime = order.endTime;
    return "$startTime to $endTime";
  }

  Widget _stillWaitingForMatch(Order order) {
    if (order.isAccepted) {
      return Container(child: Text('You have been paired with a big bee!'));
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Waiting for a Big Bee...'),
          Padding(
            padding: EdgeInsets.only(top: 10),
          ),
          Text('Order will expire at ${_getExpirationTime(order)}'),
          Padding(
            padding: EdgeInsets.only(top: 10),
          ),
        ],
      );
    }
  }

  Widget _getYourItems(Order order) {
    return Padding(
      padding: EdgeInsets.fromLTRB(30, 10, 0, 0),
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: order.basket.length,
          itemBuilder: (BuildContext context, int index) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(order.basket[index]['name']),
                (index == order.basket.length - 1)
                    ? Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: Text('\$${order.price.toString()}'),
                      )
                    : Container(),
              ],
            );
          }),
    );
  }

  Widget _getDeliveryInformation(Order order) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Drop-off Location:',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Text(_getDeliveryLocation(order)),
          ),
          Text(
            'Delivery Window:',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Text(_getDeliveryWindow(order)),
          ),
          Text(
            'Status:',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: _stillWaitingForMatch(order),
          ),
        ],
      ),
    );
  }

  Widget _getOrderInformation(Order order) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Your items:',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          _getYourItems(order),
        ],
      ),
    );
  }

  Widget _controlButtons(Order order, BuildContext context) {
    if (order.isDelivered) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(15, 20, 0, 0),
        child: Center(
          child: Text('Order delivered!'),
        ),
      );
    } else if (order.isAccepted) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(15, 20, 0, 0),
        child: Center(
          child: Text('Order is on the way!'),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Center(
          child: CupertinoButton(
            color: Theme.of(context).primaryColor,
            child: Text(
              "Cancel Order",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () {
              BlocProvider.of<OrderBloc>(context).add(OrderDeleted(order));
              Navigator.pop(context);
            },
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Order order = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Order'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          MediumTextSection('Delivery Information'),
          _getDeliveryInformation(order),
          MediumTextSection('Order Information'),
          _getOrderInformation(order),
          _controlButtons(order, context),
        ],
      ),
    );
  }
}
