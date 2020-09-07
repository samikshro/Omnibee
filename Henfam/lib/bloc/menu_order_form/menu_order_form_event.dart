part of 'menu_order_form_bloc.dart';

abstract class MenuOrderFormEvent extends Equatable {
  const MenuOrderFormEvent();

  @override
  List<Object> get props => [];
}

class MenuOrderFormLoaded extends MenuOrderFormEvent {}

class ItemAdded extends MenuOrderFormEvent {
  final MenuItem menuItem;

  const ItemAdded(this.menuItem);

  @override
  List<Object> get props => [menuItem];

  @override
  String toString() => 'MenuItemAdded { menuItem: $menuItem }';
}
