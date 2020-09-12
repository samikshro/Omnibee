import 'dart:async';

import 'package:Henfam/models/menu_item.dart';
import 'package:Henfam/models/menu_modifier.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'menu_order_form_event.dart';
part 'menu_order_form_state.dart';

class MenuOrderFormBloc extends Bloc<MenuOrderFormEvent, MenuOrderFormState> {
  MenuOrderFormBloc() : super(MenuOrderFormLoadInProgress());

  @override
  Stream<MenuOrderFormState> mapEventToState(
    MenuOrderFormEvent event,
  ) async* {
    if (event is ItemAdded) {
      yield* _mapMenuItemAddedToState(event);
    }
  }

  Stream<MenuOrderFormState> _mapMenuItemAddedToState(ItemAdded event) async* {
    try {
      yield MenuOrderFormLoadSuccess(event.menuItem, event.modifiers);
    } catch (_) {
      yield MenuOrderFormLoadFailure();
    }
  }
}
