import 'package:Henfam/models/order.dart';
import 'package:Henfam/widgets/mediumTextSection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:Henfam/bloc/blocs.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderCardPage extends StatefulWidget {
  @override
  _OrderCardPageState createState() => _OrderCardPageState();
}

class _OrderCardPageState extends State<OrderCardPage> {
  double fontSize = 16;

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

  Widget _getStatus(Order order) {
    if (order.isReceived) {
      return Container(child: Text('Your order was completed!', style: TextStyle(fontSize: fontSize),));
    } else if (order.isExpired()) {
      return Container(child: Text('Your order expired before being accepted.', style: TextStyle(fontSize: fontSize),));
    } else if (order.isAccepted) {
      return Container(child: Text('Your order is on the way!', style: TextStyle(fontSize: fontSize),));
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Waiting for a Big Bee...', style: TextStyle(fontSize: fontSize),),
          Padding(
            padding: EdgeInsets.only(top: 10),
          ),
          Text('Order will expire at ${_getExpirationTime(order)}', style: TextStyle(fontSize: fontSize),),
          Padding(
            padding: EdgeInsets.only(top: 10),
          ),
        ],
      );
    }
  }

  List<Widget> _getAddOns(List<dynamic> addOns) {
    if (addOns.length == 0) {
      return [Container()];
    }

    List<Widget> output = [];
    addOns.forEach((addOn) {
      output.add(Padding(
        padding: EdgeInsets.fromLTRB(15, 10, 0, 10),
        child: Text(addOn),
      ));
    });

    return output;
  }

  Widget _getYourItems(Order order) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 5, 0, 10),
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: order.basket.length,
          itemBuilder: (BuildContext context, int index) {
            return ExpansionTile(
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              expandedAlignment: Alignment.bottomLeft,
              title: Text(order.basket[index]['name']),
              subtitle: Text(
                '\$${order.price.toString()}',
              ),
              trailing: Icon(Icons.arrow_drop_down),
              children: _getAddOns(order.basket[index]['add_ons']),
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
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: fontSize),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Text(_getDeliveryLocation(order), style: TextStyle(fontSize: fontSize)),
          ),
          Text(
            'Delivery Window:',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: fontSize),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Text(order.getDeliveryWindow(), style: TextStyle(fontSize: fontSize)),
          ),
          Text(
            'Status:',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: fontSize),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: _getStatus(order),
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
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: fontSize),
          ),
          _getYourItems(order),
        ],
      ),
    );
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
          "Call Errand Runner",
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () {
          launchURL("tel:${order.runnerPhone}");
        },
      ),
    );
  }

  Widget _controlButtons(Order order, BuildContext context) {
    if (order.isDelivered == true) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(15, 20, 0, 0),
        child: Center(
          child: Text('Order delivered!'),
        ),
      );
    } else if (order.isAccepted ) {
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
          if (order.isAccepted && !order.isExpired())
            _callPhoneNumber(order, context),
          _getDeliveryInformation(order),
          MediumTextSection('Order Information'),
          _getOrderInformation(order),
          _controlButtons(order, context),
        ],
      ),
    );
  }
}
