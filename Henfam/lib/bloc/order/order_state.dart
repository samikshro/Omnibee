part of 'order_bloc.dart';

abstract class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

class OrderLoadInProgress extends OrderState {}

class OrderStateLoadSuccess extends OrderState {
  final List<Order> orders;

  const OrderStateLoadSuccess([this.orders = const []]);

  @override
  List<Object> get props => [orders];

  @override
  String toString() => 'OrderStateLoadSuccess { Order: $orders }';

  List<Order> getUserOrders(String uid) {
    return orders.where((order) => (order.uid == uid)).toList();
  }

  List<Order> getUserDeliveries(String uid) {
    return orders.where((order) => (order.runnerUid == uid)).toList();
  }
}

class OrderStateLoadFailure extends OrderState {}
