import 'package:Omnibee/models/models.dart';
import 'package:flutter/material.dart';

class ExpandedDecouple extends StatefulWidget {
  final List<Order> orders;
  final List<bool> selectedList;
  final Function changeCheckBox;

  ExpandedDecouple(this.orders, this.selectedList, this.changeCheckBox);
  @override
  _ExpandedDecoupleState createState() => _ExpandedDecoupleState();
}

class _ExpandedDecoupleState extends State<ExpandedDecouple> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0),
      child: SizedBox(
        height: 140,
        child: Row(
          children: widget.orders.map((order) {
            int orderIndex = widget.orders.indexOf(order);
            return ProfileCheckBoxColumn(order, widget.selectedList[orderIndex],
                orderIndex, widget.changeCheckBox);
          }).toList(),
        ),
      ),
    );
  }
}

class ProfileCheckBoxColumn extends StatelessWidget {
  final Order order;
  final bool isSelected;
  final int requestIndex;
  final Function changeCheckBox;

  ProfileCheckBoxColumn(
    this.order,
    this.isSelected,
    this.requestIndex,
    this.changeCheckBox,
  );

  @override
  //TODO: add profile pics during signup, change beeperson
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 65,
            width: 65,
            child: Image.asset('assets/beeperson@2x.png'),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 10),
          ),
          Text(order.name),
          Checkbox(
              value: isSelected,
              onChanged: (val) {
                changeCheckBox(requestIndex, val);
              })
        ],
      ),
    );
  }
}
