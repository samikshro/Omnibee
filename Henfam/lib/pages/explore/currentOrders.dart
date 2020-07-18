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

  Stream<QuerySnapshot> _getUserOrders(String uid) {
    final ordersRef = _firestore.collection('orders');
    return ordersRef.where('user_id.uid', isEqualTo: uid).snapshots();
  }

  Stream<QuerySnapshot> _getUserDeliveries(String uid) {
    final ordersRef = _firestore.collection('orders');
    return ordersRef.where('user_id.runner', isEqualTo: uid).snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
        future: _getUserId(),
        builder: (BuildContext context, AsyncSnapshot<String> uid) {
          if (uid.hasData) {
            return ListView(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: <Widget>[
                StreamBuilder(
                  stream: _getUserOrders(uid.data),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) return Text('Loading...');
                    return ExpansionTile(
                      title: Text('Your Orders'),
                      children: snapshot.data.documents
                          .map<Widget>((doc) => OrderCard(
                                context,
                                document: doc,
                              ))
                          .toList(),
                    );
                  },
                ),
                StreamBuilder(
                  stream: _getUserDeliveries(uid.data),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) return Text('Loading...');
                    return ExpansionTile(
                      title: Text('Your Deliveries'),
                      children: snapshot.data.documents
                          .map<Widget>((doc) => DeliveryCard(
                                context,
                                document: doc,
                              ))
                          .toList(),
                    );
                  },
                ),
              ],
            );
          } else {
            return Container();
          }
        });
  }
}
