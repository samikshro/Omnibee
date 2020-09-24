import 'dart:async';
import 'package:Henfam/models/models.dart';

abstract class OrdersRepository {
  Future<void> addOrder(Order order);

  Future<void> deleteOrder(Order order);

  Future<void> updateTodo(Order order);

  Future<void> markOrderComplete(Order order);
}
