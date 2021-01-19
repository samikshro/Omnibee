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
    print(state);
    print(authBloc.state);
    if (authBloc.state is Authenticated) {
      assert(ordersRepository != null && authBloc != null);
      _ordersRepository = ordersRepository;
      _authBloc = authBloc;
    }
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
    } else if (event is OrderMarkDelivered) {
      yield* _mapOrderMarkDeliveredToState(event);
    } else if (event is OrderMarkAccepted) {
      yield* _mapOrderMarkAcceptedToState(event);
    } else if (event is UpdateUser) {
      yield* _mapUpdateUserToState(event);
    } else if (event is OrderBlocClosed) {
      yield* _mapOrderBlocClosedToState(event);
    }
  }

  Stream<OrderState> _mapOrderLoadSuccessToState() async* {
    _authSubscription?.cancel();
    _authSubscription = _authBloc.listen((state) {
      if (state is Authenticated) {
        add(UpdateUser(state.user));
      }
      add(OrderLoaded());
    });

    _ordersSubscription?.cancel();
    _ordersSubscription = _ordersRepository.orders().listen(
          (orders) => add(OrdersUpdated(orders)),
        );
  }

  Stream<OrderState> _mapOrdersUpdatedToState(OrdersUpdated event) async* {
    User user = (state as OrderStateLoadSuccess).user;
    yield OrderStateLoadSuccess(orders: event.orders, user: user);
  }

  Stream<OrderState> _mapOrderAddedToState(OrderAdded event) async* {
    _ordersRepository.addOrder(event.order);
  }

  Stream<OrderState> _mapOrderDeletedToState(OrderDeleted event) async* {
    _ordersRepository.deleteOrder(event.order);
  }

  Stream<OrderState> _mapOrderMarkDeliveredToState(
      OrderMarkDelivered event) async* {
    _ordersRepository.markOrderDelivered(event.order);
  }

  Stream<OrderState> _mapOrderMarkAcceptedToState(
      OrderMarkAccepted event) async* {
    _ordersRepository.markOrderAccepted(event.order, event.runner);
  }

  Stream<OrderState> _mapUpdateUserToState(UpdateUser event) async* {
    yield OrderStateLoadSuccess(user: event.user);
  }

  Stream<OrderState> _mapOrderBlocClosedToState(OrderBlocClosed event) async* {
    yield OrderLoadInProgress();
  }

  @override
  Future<void> close() {
    print("order_bloc: close");
    _ordersSubscription?.cancel();
    _authSubscription?.cancel();
    return super.close();
  }
}
