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

  String _getUserId() {
    String uid;
    BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          uid = state.user.uid;
        }
      },
    );
    return uid;
  }

  List<Order> getUserOrders() {
    return orders
        .where((order) =>
            ((order.uid == _getUserId()) && (_isOrderNotExpired(order))))
        .toList();
  }

  List<Order> getUserDeliveries() {
    return orders
        .where((order) =>
            ((order.runnerUid == _getUserId()) && (_isOrderNotExpired(order))))
        .toList();
  }

  bool _isOrderNotExpired(Order order) {
    return DateTime.now().millisecondsSinceEpoch <
        order.expirationTime.millisecondsSinceEpoch;
  }

  List<Order> getPrevUserOrders() {
    return expiredOrders
        .where((order) =>
            ((order.uid == _getUserId()) && _isExpiredAndAccepted(order)))
        .toList();
  }

  List<Order> getPrevUserDeliveries() {
    return expiredOrders
        .where((order) =>
            ((order.runnerUid == _getUserId()) && _isExpiredAndAccepted(order)))
        .toList();
  }

  bool _isExpiredAndAccepted(Order order) {
    return (order.isAccepted && !_isOrderNotExpired(order));
  }
}

class OrderStateLoadFailure extends OrderState {}
