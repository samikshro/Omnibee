import 'dart:async';

import 'package:Henfam/models/menu_item.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'basket_event.dart';
part 'basket_state.dart';

class BasketBloc extends Bloc<BasketEvent, BasketState> {
  BasketBloc() : super(BasketLoadInProgress());

  @override
  Stream<BasketState> mapEventToState(
    BasketEvent event,
  ) async* {
    if (event is BasketLoaded) {
      yield* _mapBasketLoadedToState();
    } else if (event is MenuItemAdded) {
      yield* _mapMenuItemAddedToState(event);
    } else if (event is MenuItemDeleted) {
      yield* _mapMenuItemDeletedToState(event);
    }
  }

  Stream<BasketState> _mapBasketLoadedToState() async* {
    try {
      yield BasketLoadSuccess([]);
    } catch (_) {
      yield BasketLoadFailure();
    }
  }

  Stream<BasketState> _mapMenuItemAddedToState(MenuItemAdded event) async* {
    if (state is BasketLoadSuccess) {
      final List<MenuItem> updatedMenuItems =
          List.from((state as BasketLoadSuccess).menuItems)
            ..add(event.menuItem);
      yield BasketLoadSuccess(updatedMenuItems);
    }
  }

  Stream<BasketState> _mapMenuItemDeletedToState(MenuItemDeleted event) async* {
    if (state is BasketLoadSuccess) {
      final List<MenuItem> updatedMenuItems =
          List.from((state as BasketLoadSuccess).menuItems)
            ..remove(event.menuItem);
      yield BasketLoadSuccess(updatedMenuItems);
    }
  }
}
