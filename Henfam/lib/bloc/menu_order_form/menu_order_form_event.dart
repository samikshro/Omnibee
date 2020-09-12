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
      'ItemAdded { menuItem: $menuItem , modifiers: $modifiers }';
}
