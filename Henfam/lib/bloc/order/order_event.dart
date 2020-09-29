part of 'order_bloc.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class OrderLoadSuccess extends OrderEvent {}

class OrderAdded extends OrderEvent {
  final Order order;

  const OrderAdded(this.order);

  @override
  List<Object> get props => [Order];

  @override
  String toString() => 'OrderAdded { Order: $Order }';
}

class OrdersUpdated extends OrderEvent {
  final List<Order> orders;

  const OrdersUpdated(this.orders);

  @override
  List<Object> get props => [Order];

  @override
  String toString() => 'OrderUpdated { Order: $Order }';
}

class OrderDeleted extends OrderEvent {
  final Order order;

  const OrderDeleted(this.order);

  @override
  List<Object> get props => [Order];

  @override
  String toString() => 'OrderDeleted { Order: $Order }';
}

class OrderModified extends OrderEvent {
  final Order order;

  const OrderModified(this.order);

  @override
  List<Object> get props => [Order];

  @override
  String toString() => 'OrderDeleted { Order: $Order }';
}
