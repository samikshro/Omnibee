import 'package:Henfam/models/models.dart';
import 'package:flutter/material.dart';

class BigCard extends StatelessWidget {
  final Order order;

  BigCard(BuildContext context, {this.order});

  List<Widget> _itemsToOrder(Order order) {
    List<Widget> children = [];
    for (int i = 0; i < order.basket.length; i++) {
      children.add(ListTile(
        title: Text(
          order.basket[i]['name'],
        ),
        trailing: Text(order.basket[i]['price'].toStringAsFixed(2)),
      ));
    }
    return children;
  }

  @override
  Widget build(BuildContext context) {
    if (order.isAccepted == true) {
      return Container();
    }
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/accept_order', arguments: order);
      },
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
              title: Text(
                "${order.restaurantName} to ${order.location}",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              children: _itemsToOrder(order),
            ),
            Text(
              "Minimum Earnings: \$${order.minEarnings.toStringAsFixed(2)}",
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.normal),
              textAlign: TextAlign.right,
            ),
            Text(
              "Deliver Between: ${order.startTime} - ${order.endTime}\n",
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.normal),
              textAlign: TextAlign.left,
            ),
            Image(
              image: AssetImage(order.restaurantImage),
              fit: BoxFit.cover,
            ),
            ButtonBar(
              children: <Widget>[
                FlatButton(
                  child: const Text(
                    'VIEW',
                    style: TextStyle(fontSize: 18),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/accept_order',
                        arguments: order);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
