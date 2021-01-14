import 'dart:async';
import 'package:Henfam/models/models.dart';

abstract class OrdersRepository {
  Future<void> addOrder(Order order);

  Future<void> deleteOrder(Order order);

  Future<void> updateOrder(Order order);

  Future<void> markOrderDelivered(Order order);

  Stream<List<Order>> orders();
}
