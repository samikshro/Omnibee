import 'package:Omnibee/models/models.dart';
import 'package:flutter/material.dart';

class IconNameRow extends StatelessWidget {
  final List<Order> orders;
  final List<bool> selectedList;

  IconNameRow(this.orders, this.selectedList);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Row(
        children: orders.map((order) {
          if (selectedList[orders.indexOf(order)] == true) {
            return TinyIconAndName(order);
          }
          return Container();
        }).toList(),
      ),
    );
  }
}

// TODO: get rid of le beeperson
class TinyIconAndName extends StatelessWidget {
  final Order order;

  TinyIconAndName(this.order);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Image.asset('assets/beeperson.png'),
        Padding(
          padding: EdgeInsets.only(right: 5),
        ),
        Text(order.name),
        Padding(
          padding: EdgeInsets.only(right: 10),
        ),
      ],
    );
  }
}
