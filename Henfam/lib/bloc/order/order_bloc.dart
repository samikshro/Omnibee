import 'dart:async';
import 'package:Henfam/bloc/auth/auth_bloc.dart';
import 'package:Henfam/models/models.dart';
import 'package:Henfam/models/order.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:Henfam/repository/orders_repository.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrdersRepository _ordersRepository;
  StreamSubscription _ordersSubscription;

  AuthBloc _authBloc;
  StreamSubscription _authSubscription;

  OrderBloc(
      {@required OrdersRepository ordersRepository,
      @required AuthBloc authBloc})
      : super(
          authBloc.state is Authenticated
              ? OrderStateLoadSuccess(
                  user: (authBloc.state as Authenticated).user,
                )
              : OrderLoadInProgress(),
        ) {
    assert(ordersRepository != null && authBloc != null);
    _ordersRepository = ordersRepository;
    _authBloc = authBloc;
    _authSubscription = authBloc.listen((state) {
      add(UpdateUser((state as Authenticated).user));
    });
    //super(OrderLoadInProgress());
  }

  @override
  Stream<OrderState> mapEventToState(OrderEvent event) async* {
    if (event is OrderLoaded) {
      yield* _mapOrderLoadSuccessToState();
    } else if (event is OrdersUpdated) {
      yield* _mapOrdersUpdatedToState(event);
    } else if (event is OrderAdded) {
      yield* _mapOrderAddedToState(event);
    } else if (event is OrderDeleted) {
      yield* _mapOrderDeletedToState(event);
    } else if (event is OrderModified) {
      yield* _mapOrderModifiedToState(event);
    } else if (event is UpdateUser) {
      yield* _mapUpdateUserToState(event);
    }
  }

  Stream<OrderState> _mapOrderLoadSuccessToState() async* {
    _ordersSubscription?.cancel();
    _ordersSubscription = _ordersRepository.orders().listen(
          (orders) => add(OrdersUpdated(orders)),
        );
    /* _authSubscription?.cancel();
    print("Before authsubscription initialize");
    print(_authBloc);
    _authSubscription = _authBloc.listen((state) {
      print("Adding UpdateUser event");
      add(UpdateUser((_authBloc.state as Authenticated).user));
    });
    print("After authsubscription initialize"); */
  }

  Stream<OrderState> _mapOrdersUpdatedToState(OrdersUpdated event) async* {
    yield OrderStateLoadSuccess(orders: event.orders);
  }

  Stream<OrderState> _mapOrderAddedToState(OrderAdded event) async* {
    _ordersRepository.addOrder(event.order);
  }

  Stream<OrderState> _mapOrderDeletedToState(OrderDeleted event) async* {
    _ordersRepository.deleteOrder(event.order);
  }

  Stream<OrderState> _mapOrderModifiedToState(OrderModified event) async* {
    _ordersRepository.updateOrder(event.order);
  }

  Stream<OrderState> _mapUpdateUserToState(UpdateUser event) async* {
    print("Updating user: ${event.user.uid}");
    yield OrderStateLoadSuccess(user: event.user);
  }

  @override
  Future<void> close() {
    _ordersSubscription?.cancel();
    _authSubscription?.cancel();
    return super.close();
  }
}
