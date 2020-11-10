import 'dart:async';
import 'package:Henfam/models/models.dart';

abstract class OrdersRepository {
  Future<void> addOrder(Order order);

  Future<void> deleteOrder(Order order);

  Future<void> updateOrder(Order order);

  Stream<List<Order>> orders();

  Stream<List<Order>> expiredOrders();
}
