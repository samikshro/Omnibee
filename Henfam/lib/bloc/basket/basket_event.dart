part of 'basket_bloc.dart';

@immutable
abstract class BasketEvent extends Equatable {
  const BasketEvent();

  @override
  List<Object> get props => [];
}

class BasketLoaded extends BasketEvent {}

class MenuItemAdded extends BasketEvent {
  final MenuItem menuItem;

  const MenuItemAdded(this.menuItem);

  @override
  List<Object> get props => [menuItem];

  @override
  String toString() => 'MenuItemAdded { menuItem: $menuItem }';
}

class MenuItemDeleted extends BasketEvent {
  final MenuItem menuItem;

  const MenuItemDeleted(this.menuItem);

  @override
  List<Object> get props => [menuItem];

  @override
  String toString() => 'MenuItemDeleted { menuItem: $menuItem }';
}
