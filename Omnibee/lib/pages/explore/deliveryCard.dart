import 'package:Omnibee/services/paymentService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Omnibee/models/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Omnibee/bloc/blocs.dart';

class DeliveryCard extends StatelessWidget {
  final Order order;

  DeliveryCard(BuildContext context, {this.order});

  List<Widget> _itemsToOrder(Order order) {
    List<Widget> children = [];
    for (int i = 0; i < order.basket.length; i++) {
      children.add(ListTile(
        title: Text(
          order.basket[i]['name'],
        ),
        trailing: Text(order.basket[i]['price'].toString()),
      ));
    }
    return children;
  }

  @override
  Widget build(BuildContext context) {
    // if (order.isComplete()) return Container();
    return GestureDetector(
      onTap: () {},
      child: Card(
        margin: EdgeInsets.all(10.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 2.0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ExpansionTile(
                leading: Icon(Icons.fastfood),
                title: Text(order.name + ": " + order.restaurantName),
                subtitle: Text(order.getDeliveryWindow() +
                    "\nEarnings: \$${order.minEarnings.toStringAsFixed(2)}"),
                children: _itemsToOrder(order)),
            DeliveryCardButtonBar(order, context),
          ],
        ),
      ),
    );
  }
}

class DeliveryCardButtonBar extends StatelessWidget {
  final Order order;
  final BuildContext context;

  DeliveryCardButtonBar(this.order, this.context);

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

  List<Widget> _getButtons() {
    List<Widget> buttons = [
      RaisedButton(
        color: Color(0xffFD9827),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        child: const Text(
          'MARK DELIVERED',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
        onPressed: () {
          BlocProvider.of<OrderBloc>(context).add(OrderMarkDelivered(order));
          _markOrderComplete(order, context);
        },
      ),
      FlatButton(
        child: const Text(
          'VIEW DETAILS',
          style: TextStyle(fontSize: 18),
        ),
        onPressed: () {
          Navigator.pushNamed(context, '/delivery_card_page', arguments: order);
        },
      ),
    ];

    //TODO: keep here for testing purposes and then remove
    if (order.isDelivered) {
      buttons.removeAt(0);
      if (!order.isReceived) {
        buttons.insert(
          0,
          Text('Waiting for confirmation...'),
        );
      }
    }

    return buttons;
  }

  @override
  Widget build(BuildContext context) {
    return ButtonBar(
      alignment: order.isReceived
          ? MainAxisAlignment.end
          : MainAxisAlignment.spaceAround,
      children: _getButtons(),
    );
  }
}
