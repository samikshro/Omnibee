import 'package:Henfam/auth/authentication.dart';
import 'package:Henfam/pages/explore/deliveryCard.dart';
import 'package:Henfam/pages/explore/orderCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CurrentOrders extends StatelessWidget {
  final _firestore = Firestore.instance;
  BaseAuth _auth = Auth();

  Future<String> _getUserId() async {
    final user = await _auth.getCurrentUser();
    return user.uid;
  }

  Future<QuerySnapshot> _getUserOrders(String uid) {
    final ordersRef = _firestore.collection('orders');
    return ordersRef.where('user_id.uid', isEqualTo: uid).getDocuments();
  }

  Future<QuerySnapshot> _getUserDeliveries(String uid) {
    final ordersRef = _firestore.collection('orders');
    return ordersRef.where('user_id.runner', isEqualTo: uid).getDocuments();
  }

  Future<List<QuerySnapshot>> _getOrdersAndDeliveries() async {
    final uid = await _getUserId();
    final orders = await _getUserOrders(uid);
    final deliveries = await _getUserDeliveries(uid);
    return [orders, deliveries];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<QuerySnapshot>>(
        future: _getOrdersAndDeliveries(),
        builder:
            (BuildContext context, AsyncSnapshot<List<QuerySnapshot>> queries) {
          if (queries.hasData) {
            final orders = queries.data[0];
            final deliveries = queries.data[1];
            print(orders.documents.length);
            print(deliveries.documents.length);
            return ListView(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: <Widget>[
                ExpansionTile(
                  title: Text('Your Orders'),
                  children: orders.documents
                      .map((doc) => OrderCard(
                            context,
                            document: doc,
                          ))
                      .toList(),
                ),
                ExpansionTile(
                  title: Text('Your Deliveries'),
                  children: deliveries.documents
                      .map((doc) => DeliveryCard(
                            context,
                            document: doc,
                          ))
                      .toList(),
                )
              ],
            );
          } else {
            return Container();
          }
        });
  }
}
