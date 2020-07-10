import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:Henfam/pages/explore/menu/basketForm.dart';
import 'package:Henfam/pages/explore/menu/menuOrderForm.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RequestConfirm extends StatelessWidget {
  final date;
  final range;
  final BasketData args;

  RequestConfirm(this.date, this.range, this.args);

  final firestoreInstance = Firestore.instance;

  String getDay(DateTime date) {
    final today = DateTime.now();
    return (today.day == date.day) ? "Today" : "Tomorrow";
  }

  String getTimes(DateTime date, DateTime range) {
    final interval = Duration(hours: range.hour, minutes: range.minute);
    final endDate = date.add(interval);

    final formatter = DateFormat.jm();
    final startTime = formatter.format(date);
    final endTime = formatter.format(endDate);

    return '$startTime - $endTime';
  }

  _create_map_from_lst(List<FoodInfo> ords) {
    var lst = [];
    for (int i = 0; i < ords.length; i++) {
      lst.add({"name": ords[i].name, "price": ords[i].price});
    }
    return lst;
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      title: Text("Do you want to submit this order?",
          style: TextStyle(fontSize: 22.0)),
      message: Text("Delivery Window: " + getTimes(date, range),
          style: TextStyle(fontSize: 20.0)),
      actions: <Widget>[
        CupertinoActionSheetAction(
          child: Text("Confirm"),
          isDefaultAction: true,
          onPressed: () {
            firestoreInstance.collection("orders").add({
              "user_id": {
                "name": "Ada Lovelace",
                // Index Ada's groups in her profile
                "rest_name_used": "Oishii Bowl",
                "basket": [
                  args.orders
                  // {
                  //   "name": args.orders[0].name,
                  //   "price": args.orders[0].price,
                  // }
                  // {
                  //   "name": foodDoc.document['food'][foodDoc.index]['name'],
                  //   "price": foodDoc.document['food'][foodDoc.index]['price'],
                  // },
                ],
              }
            });
            Navigator.popUntil(
                context, ModalRoute.withName(Navigator.defaultRouteName));
          },
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        child: Text("Cancel"),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
