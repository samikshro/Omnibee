import 'package:Henfam/models/models.dart';
import 'package:flutter/material.dart';

class DisplayItems extends StatelessWidget {
  final Order order;
  final double fontSize;

  DisplayItems(this.order, this.fontSize);

  List<Widget> _getAddOnsSpecialRequests(
    List<dynamic> addOns,
    String sRequest,
  ) {
    List<Widget> output = [];
    if (addOns.length != 0) {
      addOns.forEach((addOn) {
        output.add(
          Padding(
            padding: EdgeInsets.fromLTRB(15, 10, 0, 10),
            child: Text(addOn),
          ),
        );
      });
    }
    if (sRequest != null) {
      print("SRequests in displayItems: $sRequest");
      output.add(
        Padding(
          padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
          child: Text("Special Requests: $sRequest"),
        ),
      );
    }

    if (output.length == 0) {
      return [Container()];
    }

    return output;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 5, 0, 10),
      child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(), //TODO: test this out
          itemCount: order.basket.length,
          itemBuilder: (BuildContext context, int index) {
            return ExpansionTile(
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              expandedAlignment: Alignment.bottomLeft,
              title: Text(order.basket[index]['name'],
                  style: TextStyle(fontSize: fontSize)),
              subtitle: Text(
                '\$${order.basket[index]['price']}',
                // style: TextStyle(fontSize: fontSize),
              ),
              trailing: Icon(Icons.arrow_drop_down),
              children: _getAddOnsSpecialRequests(
                  order.basket[index]['add_ons'],
                  order.basket[index]['s_requests']),
            );
          }),
    );
  }
}
