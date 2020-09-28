part of 'order_bloc.dart';

abstract class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

class OrderLoadInProgress extends OrderState {}

class OrderStateLoadSuccess extends OrderState {
  final List<Order> order;

  const OrderStateLoadSuccess([this.order = const []]);

  @override
  List<Object> get props => [Order];

  @override
  String toString() => 'OrderStateLoadSuccess { Order: $Order }';
}

class OrderStateLoadFailure extends OrderState {}
