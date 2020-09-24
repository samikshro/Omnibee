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
  Future<void> updateTodo(Order order) {
    return orderCollection
        .document(order.docID)
        .updateData(order.toEntity().toDocument());
  }

  @override
  Future<void> markOrderComplete(Order order) {
    // TODO: implement markOrderComplete
    throw UnimplementedError();
  }
}
