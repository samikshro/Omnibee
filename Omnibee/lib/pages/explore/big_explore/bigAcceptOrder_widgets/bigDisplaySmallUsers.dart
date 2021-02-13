import 'package:Omnibee/models/order.dart';
import 'package:Omnibee/pages/explore/big_explore/bigAcceptOrder_widgets/bigIconNameRow.dart';
import 'package:flutter/material.dart';

class DisplaySmallUsers extends StatelessWidget {
  final bool isExpanded;
  final List<Order> orders;
  final List<bool> selectedList;

  DisplaySmallUsers(this.isExpanded, this.orders, this.selectedList);

  @override
  Widget build(BuildContext context) {
    if (!isExpanded) {
      return Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: (IconNameRow(orders, selectedList)),
      );
    } else {
      return Container();
    }
  }
}
