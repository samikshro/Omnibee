import 'package:Henfam/services/paymentService.dart';
import 'package:flutter/material.dart';
import 'package:Henfam/models/models.dart';

class OrderCard extends StatelessWidget {
  final Order order;

  OrderCard(BuildContext context, {this.order});

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
                    order.endTime),
                children: _itemsToOrder(order)),
            Image(
              image: AssetImage("assets/oishii_bowl_pic1.png"),
              fit: BoxFit.cover,
            ),
            OrderCardButtonBar(order, context),
          ],
        ),
      ),
    );
  }
}

class OrderCardButtonBar extends StatelessWidget {
  final Order order;
  final BuildContext context;

  OrderCardButtonBar(this.order, this.context);

  MainAxisAlignment _getAlignment() {
    if (order.isDelivered != true) {
      return MainAxisAlignment.end;
    } else {
      return MainAxisAlignment.spaceAround;
    }
  }

  void _markOrderComplete(Order order, BuildContext context) {
    final snackBar = SnackBar(
      content: Text('Confirming delivery, please wait one moment....'),
    );
    Scaffold.of(context).showSnackBar(snackBar);
    double priceWithTax = 1.28 * order.price;
    priceWithTax = double.parse((priceWithTax).toStringAsFixed(2));
    double fees = (1.28 * order.price * .03) + .3;
    fees = double.parse((fees).toStringAsFixed(2));

    // PaymentService.paymentTransfer(order, context, priceWithTax + fees, fees,
    //     order.paymentMethodId, order.stripeAccountId);

    //TODO: we are taking fee from whole order, not the delivery fee itself
    double taxRate = 1.08;
    double omnibeeShare = 0.20;
    double goalPrice = ((taxRate + omnibeeShare) * order.price);
    double pCharge =
        double.parse(((goalPrice + 0.3) / 0.971).toStringAsFixed(2));
    double omnibeeFee =
        double.parse((omnibeeShare * goalPrice).toStringAsFixed(2));

    PaymentService.paymentTransfer(order, context, pCharge, omnibeeFee,
        order.paymentMethodId, order.stripeAccountId);
  }

  List<Widget> _getButtons(BuildContext context) {
    List<Widget> buttons = [
      FlatButton(
        child: const Text(
          'VIEW DETAILS',
          style: TextStyle(fontSize: 18),
        ),
        onPressed: () {
          Navigator.pushNamed(context, '/order_card_page', arguments: order);
        },
      ),
    ];

    if (order.isDelivered) {
      buttons.insert(
          0,
          RaisedButton(
            color: Color(0xffFD9827),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
            child: const Text(
              'CONFIRM DELIVERY',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            onPressed: () {
              _markOrderComplete(order, context);
            },
          ));
    }

    return buttons;
  }

  @override
  Widget build(BuildContext context) {
    return ButtonBar(
      alignment: _getAlignment(),
      children: _getButtons(context),
    );
  }
}
