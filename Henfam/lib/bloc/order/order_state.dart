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
    print("User id: ${user.uid}");
    print("User orders: $userOrders");
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

  List<Order> getPrevUserOrders() {
    return expiredOrders
        .where((order) =>
            ((order.uid == user.uid) && _isExpiredAndAccepted(order)))
        .toList();
  }

  List<Order> getPrevUserDeliveries() {
    return expiredOrders
        .where((order) =>
            ((order.runnerUid == user.uid) && _isExpiredAndAccepted(order)))
        .toList();
  }

  bool _isExpiredAndAccepted(Order order) {
    return (order.isAccepted && !_isOrderNotExpired(order));
  }
}

class OrderStateLoadFailure extends OrderState {}
