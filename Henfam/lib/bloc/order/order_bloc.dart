import 'dart:async';
import 'package:Henfam/models/order.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:Henfam/repository/orders_repository.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrdersRepository _ordersRepository;
  StreamSubscription _ordersSubscription;

  OrderBloc({@required OrdersRepository ordersRepository})
      : assert(ordersRepository != null),
        _ordersRepository = ordersRepository,
        super(OrderLoadInProgress());

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
    }
  }

  Stream<OrderState> _mapOrderLoadSuccessToState() async* {
    _ordersSubscription?.cancel();
    _ordersSubscription = _ordersRepository.orders().listen(
          (orders) => add(OrdersUpdated(orders)),
        );
  }

  Stream<OrderState> _mapOrdersUpdatedToState(OrdersUpdated event) async* {
    try {
      yield OrderStateLoadSuccess(event.orders);
    } catch (_) {
      yield OrderStateLoadFailure();
    }
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

  @override
  Future<void> close() {
    _ordersSubscription?.cancel();
    return super.close();
  }
}
