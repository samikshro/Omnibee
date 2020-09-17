import 'dart:async';

import 'package:Henfam/models/menu_item.dart';
import 'package:Henfam/models/models.dart';
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
    } else if (event is BasketReset) {
      yield* _mapBasketResetToState(event);
    }
  }

  Stream<BasketState> _mapBasketLoadedToState() async* {
    try {
      yield BasketLoadSuccess([], []);
    } catch (_) {
      yield BasketLoadFailure();
    }
  }

  Stream<BasketState> _mapMenuItemAddedToState(MenuItemAdded event) async* {
    if (state is BasketLoadSuccess) {
      MenuItem item = MenuItem(
        event.menuItem.name,
        event.menuItem.description,
        event.menuItem.price,
        event.menuItem.modifiers,
        modifiersChosen: event.menuItem.cloneModifiersChosen(),
      );

      final List<MenuItem> updatedMenuItems =
          List.from((state as BasketLoadSuccess).menuItems)..add(item);
      final jsonEncoding = _toJson(updatedMenuItems);
      yield BasketLoadSuccess(updatedMenuItems, jsonEncoding);
    }
  }

  Stream<BasketState> _mapMenuItemDeletedToState(MenuItemDeleted event) async* {
    if (state is BasketLoadSuccess) {
      MenuItem deleteThis = List.from((state as BasketLoadSuccess).menuItems)
          .firstWhere(((item) =>
              (item.name == event.menuItem.name) &&
              (item.modifiersChosen == event.menuItem.modifiersChosen)));
      final List<MenuItem> updatedMenuItems =
          List.from((state as BasketLoadSuccess).menuItems)..remove(deleteThis);
      final jsonEncoding = _toJson(updatedMenuItems);
      yield BasketLoadSuccess(updatedMenuItems, jsonEncoding);
    }
  }

  Stream<BasketState> _mapBasketResetToState(BasketReset event) async* {
    if (state is BasketLoadSuccess) {
      yield BasketLoadSuccess([], []);
    }
  }

  List<Map> _toJson(List<MenuItem> menuItems) {
    List<Map> orders = [];
    if (menuItems == []) {
      return orders;
    }
    menuItems.forEach((MenuItem menuItem) {
      Map order = _getJsonEncoding(menuItem);
      orders.add(order);
    });
    return orders;
  }

  Map<String, dynamic> _getJsonEncoding(MenuItem menuItem) {
    return {
      'name': menuItem.name,
      'price': menuItem.price,
      'add_ons': _addOnsToStringList(menuItem)
    };
  }

  List<String> _addOnsToStringList(MenuItem menuItem) {
    List<String> addOnsStringList = [];

    menuItem.modifiersChosen.forEach((modifier) {
      addOnsStringList.add(modifier.name);
    });

    return addOnsStringList;
  }
}
