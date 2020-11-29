part of 'order_bloc.dart';

abstract class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

class OrderLoadInProgress extends OrderState {}

class OrderStateLoadSuccess extends OrderState {
  final List<Order> orders;
  final List<Order> expiredOrders;

  const OrderStateLoadSuccess(
      [this.orders = const [], this.expiredOrders = const []]);

  @override
  List<Object> get props => [orders];

  @override
  String toString() => 'OrderStateLoadSuccess { Orders: $orders }';

  List<Order> getUserOrders(String uid) {
    return orders
        .where((order) => ((order.uid == uid) && (_isOrderNotExpired(order))))
        .toList();
  }

  List<Order> getUserDeliveries(String uid) {
    return orders
        .where((order) =>
            ((order.runnerUid == uid) && (_isOrderNotExpired(order))))
        .toList();
  }

  bool _isOrderNotExpired(Order order) {
    return DateTime.now().millisecondsSinceEpoch <
        order.expirationTime.millisecondsSinceEpoch;
  }

  List<Order> getPrevUserOrders(String uid) {
    return expiredOrders
        .where((order) => ((order.uid == uid) && _isExpiredAndAccepted(order)))
        .toList();
  }

  List<Order> getPrevUserDeliveries(String uid) {
    return expiredOrders
        .where((order) =>
            ((order.runnerUid == uid) && _isExpiredAndAccepted(order)))
        .toList();
  }

  bool _isExpiredAndAccepted(Order order) {
    return (order.isAccepted && !_isOrderNotExpired(order));
  }
}

class OrderStateLoadFailure extends OrderState {}
