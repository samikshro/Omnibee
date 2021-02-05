part of 'order_bloc.dart';

abstract class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

class OrderLoadInProgress extends OrderState {}

//TODO: update definitions of expired. Change names
class OrderStateLoadSuccess extends OrderState {
  final List<Order> orders;
  final User user;

  const OrderStateLoadSuccess({
    this.orders = const [],
    this.user,
  });

  @override
  List<Object> get props => [orders];

  @override
  String toString() => 'OrderStateLoadSuccess { Orders: $orders, User $user }';

  List<Order> getUserOrders() {
    List<Order> userOrders = orders
        .where((order) => (order.uid == user.uid && !(order.isExpired())))
        .toList();

    return userOrders;
  }

  List<Order> getUserDeliveries() {
    return orders
        .where((order) => ((order.runnerUid == user.uid) &&
            (!order.isExpired() && !order.isReceived)))
        .toList();
  }

  // TODO: Fix previous orders & deliveries, need to change cards and card pages
  List<Order> getPrevUserOrders() {
    return orders
        .where((order) => ((order.uid == user.uid) && (order.isExpired())))
        .toList();
  }

  List<Order> getPrevUserDeliveries() {
    return orders
        .where((order) => ((order.runnerUid == user.uid) && order.isReceived))
        .toList();
  }

  List<Order> getRunnableDeliveries() {
    return orders
        .where((order) => (order.runnerUid == null) && !order.isExpired())
        .toList();
  }
}

class OrderStateLoadFailure extends OrderState {}
