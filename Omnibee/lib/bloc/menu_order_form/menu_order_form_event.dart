part of 'menu_order_form_bloc.dart';

abstract class MenuOrderFormEvent extends Equatable {
  const MenuOrderFormEvent();

  @override
  List<Object> get props => [];
}

class MenuOrderFormLoaded extends MenuOrderFormEvent {}

class ItemAdded extends MenuOrderFormEvent {
  final MenuItem menuItem;
  final List<MenuModifier> modifiers;

  const ItemAdded(this.menuItem, this.modifiers);

  @override
  List<Object> get props => [menuItem, modifiers];

  @override
  String toString() =>
      'ItemAdded { menuItem: $menuItem , hasModifiersChosen: ${(menuItem.modifiersChosen.length != 0).toString()}, modifiers: $modifiers }';
}

class ModifierAdded extends MenuOrderFormEvent {
  final ModifierItem modifierItem;

  const ModifierAdded(this.modifierItem);

  @override
  List<Object> get props => [modifierItem];

  @override
  String toString() => 'ModifierAdded { modifierItem: ${modifierItem.name} }';
}

class ModifierDeleted extends MenuOrderFormEvent {
  final ModifierItem modifierItem;

  const ModifierDeleted(this.modifierItem);

  @override
  List<Object> get props => [modifierItem];

  @override
  String toString() => 'ModifierDeleted { modifierItem: ${modifierItem.name} }';
}

class ModifierReset extends MenuOrderFormEvent {}
