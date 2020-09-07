part of 'menu_order_form_bloc.dart';

abstract class MenuOrderFormState extends Equatable {
  const MenuOrderFormState();

  @override
  List<Object> get props => [];
}

class MenuOrderFormLoadInProgress extends MenuOrderFormState {}

class MenuOrderFormLoadSuccess extends MenuOrderFormState {
  final MenuItem menuItem;

  const MenuOrderFormLoadSuccess(this.menuItem);

  @override
  List<Object> get props => [menuItem];

  @override
  String toString() => 'BasketLoadSuccess { menuItem: $menuItem}';
}

class MenuOrderFormLoadFailure extends MenuOrderFormState {}
