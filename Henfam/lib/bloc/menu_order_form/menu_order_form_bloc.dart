import 'dart:async';

import 'package:Henfam/models/menu_item.dart';
import 'package:Henfam/models/menu_modifier.dart';
import 'package:Henfam/models/models.dart';
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
    if (event is MenuOrderFormLoaded) {
      yield* _mapMenuOrderFormLoadedToState();
    } else if (event is ItemAdded) {
      yield* _mapMenuItemAddedToState(event);
    } else if (event is ModifierAdded) {
      yield* _mapModifierAddedToState(event);
    } else if (event is ModifierDeleted) {
      yield* _mapModifierDeletedToState(event);
    } else if (event is ModifierReset) {
      yield* _mapModifierResetToState(event);
    }
  }

  Stream<MenuOrderFormState> _mapMenuOrderFormLoadedToState() async* {
    try {
      yield MenuOrderFormLoadSuccess(null, null);
    } catch (_) {
      yield MenuOrderFormLoadFailure();
    }
  }

  Stream<MenuOrderFormState> _mapMenuItemAddedToState(ItemAdded event) async* {
    try {
      MenuItem item = MenuItem(
        event.menuItem.name,
        event.menuItem.description,
        event.menuItem.price,
        event.menuItem.modifiers,
        modifiersChosen: [],
      );
      yield MenuOrderFormLoadSuccess(item, event.modifiers);
    } catch (_) {
      yield MenuOrderFormLoadFailure();
    }
  }

  Stream<MenuOrderFormState> _mapModifierAddedToState(
      ModifierAdded event) async* {
    if (state is MenuOrderFormLoadSuccess) {
      final List<MenuModifier> oldModifiers =
          (state as MenuOrderFormLoadSuccess).modifiers;
      final MenuItem updatedMenuItem =
          (state as MenuOrderFormLoadSuccess).menuItem;
      updatedMenuItem.modifiersChosen.add(event.modifierItem);

      yield MenuOrderFormLoadSuccess(updatedMenuItem, oldModifiers);
    }
  }

  Stream<MenuOrderFormState> _mapModifierDeletedToState(
      ModifierDeleted event) async* {
    if (state is MenuOrderFormLoadSuccess) {
      final List<MenuModifier> oldModifiers =
          (state as MenuOrderFormLoadSuccess).modifiers;
      final MenuItem updatedMenuItem =
          (state as MenuOrderFormLoadSuccess).menuItem;
      updatedMenuItem.modifiersChosen.remove(event.modifierItem);

      yield MenuOrderFormLoadSuccess(updatedMenuItem, oldModifiers);
    }
  }

  Stream<MenuOrderFormState> _mapModifierResetToState(
      ModifierReset event) async* {
    if (state is MenuOrderFormLoadSuccess) {
      final List<MenuModifier> oldModifiers =
          (state as MenuOrderFormLoadSuccess).modifiers;
      final MenuItem updatedMenuItem =
          (state as MenuOrderFormLoadSuccess).menuItem;
      updatedMenuItem.modifiersChosen.clear();

      yield MenuOrderFormLoadSuccess(updatedMenuItem, oldModifiers);
    }
  }
}
