import 'dart:async';
import 'package:Henfam/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'repositories.dart';
import 'package:Henfam/entities/entities.dart';

class FirebaseOrdersRepository implements OrdersRepository {
  final orderCollection = Firestore.instance.collection('orders');

  @override
  Future<void> addOrder(Order order) {
    return orderCollection.add(order.toEntity().toDocument());
  }

  @override
  Future<void> deleteOrder(Order order) {
    return orderCollection.document(order.docID).delete();
  }

  @override
  Future<void> updateOrder(Order order) {
    return orderCollection
        .document(order.docID)
        .updateData(order.toEntity().toDocument());
  }

  @override
  Stream<List<Order>> orders() {
    return orderCollection.snapshots().map((snapshot) {
      return snapshot.documents
          .where((doc) => _isOrderNotExpired(doc))
          .map((doc) => Order.fromEntity(OrderEntity.fromSnapshot(doc)))
          .toList();
    });
  }

  bool _isOrderNotExpired(DocumentSnapshot doc) {
    Timestamp expirationTime = doc['user_id']['expiration_time'];
    return Timestamp.now().millisecondsSinceEpoch <
        expirationTime.millisecondsSinceEpoch;
  }
}
