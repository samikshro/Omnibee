part of 'menu_order_form_bloc.dart';

abstract class MenuOrderFormState extends Equatable {
  const MenuOrderFormState();

  @override
  List<Object> get props => [];
}

class MenuOrderFormLoadInProgress extends MenuOrderFormState {}

class MenuOrderFormLoadSuccess extends MenuOrderFormState {
  final MenuItem menuItem;
  final List<MenuModifier> modifiers;

  const MenuOrderFormLoadSuccess(this.menuItem, this.modifiers);

  @override
  List<Object> get props => [menuItem, modifiers];

  @override
  String toString() =>
      'MenuOrderFormLoadSuccess { menuItem: $menuItem, modifiers: $modifiers }';
}

class MenuOrderFormLoadFailure extends MenuOrderFormState {}
