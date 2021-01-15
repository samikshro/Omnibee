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
  final User user;

  const OrderStateLoadSuccess({
    this.orders = const [],
    this.expiredOrders = const [],
    this.user,
  });

  @override
  List<Object> get props => [orders];

  @override
  String toString() => 'OrderStateLoadSuccess { Orders: $orders }';

  List<Order> getUserOrders() {
    List<Order> userOrders = orders
        .where(
            (order) => (order.uid == user.uid && (_isOrderNotExpired(order))))
        .toList();

    return userOrders;
  }

  List<Order> getUserDeliveries() {
    return orders
        .where((order) =>
            ((order.runnerUid == user.uid) && (_isOrderNotExpired(order))))
        .toList();
  }

  bool _isOrderNotExpired(Order order) {
    return DateTime.now().millisecondsSinceEpoch <
        order.expirationTime.millisecondsSinceEpoch;
  }

  // TODO: Fix previous orders & deliveries, need to change cards and card pages
  List<Order> getPrevUserOrders() {
    return [];
    /* return orders
        .where((order) =>
            ((order.uid == user.uid) && _isExpiredAndAccepted(order)))
        .toList(); */
  }

  List<Order> getPrevUserDeliveries() {
    return [];
    /*return orders
        .where((order) =>
            ((order.runnerUid == user.uid) && _isExpiredAndAccepted(order)))
        .toList(); */
  }

  List<Order> getRunnableDeliveries() {
    return orders
        .where(
            (order) => (order.runnerUid == null) && _isOrderNotExpired(order))
        .toList();
  }
}

class OrderStateLoadFailure extends OrderState {}
