import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Henfam/models/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Henfam/bloc/blocs.dart';

class DeliveryCard extends StatelessWidget {
  final Order order;

  DeliveryCard(BuildContext context, {this.order});

  String _getEarnings() {
    double minEarnings = 0.0;
    for (int j = 0; j < order.basket.length; j++) {
      minEarnings += order.basket[j]['price'] * .33;
    }

    return minEarnings.toStringAsFixed(2);
  }

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
    if (order.isComplete()) return Container();
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
                subtitle: Text(order.restaurantName +
                    ": " +
                    order.startTime +
                    "-" +
                    order.endTime +
                    "\nEarnings: \$${_getEarnings()}"),
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
          Order modifiedOrder = order.copyWith(
            name: order.name,
            uid: order.uid,
            userCoordinates: order.userCoordinates,
            restaurantName: order.restaurantName,
            restaurantCoordinates: order.restaurantCoordinates,
            basket: order.basket,
            location: order.location,
            startTime: order.startTime,
            endTime: order.endTime,
            expirationTime: order.expirationTime,
            isAccepted: order.isAccepted,
            isDelivered: true,
            isReceived: order.isReceived,
            runnerUid: order.runnerUid,
            price: order.price,
            restaurantImage: order.restaurantImage,
            paymentMethodId: order.paymentMethodId,
            stripeAccountId: order.stripeAccountId,
            docID: order.docID,
          );
          BlocProvider.of<OrderBloc>(context).add(OrderModified(modifiedOrder));
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

    if (order.isDelivered) {
      buttons.removeAt(0);
      buttons.insert(
        0,
        Text('Waiting for confirmation...'),
      );
    }

    return buttons;
  }

  @override
  Widget build(BuildContext context) {
    return ButtonBar(
      alignment: MainAxisAlignment.spaceAround,
      children: _getButtons(),
    );
  }
}
