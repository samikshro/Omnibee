part of 'basket_bloc.dart';

@immutable
abstract class BasketState extends Equatable {
  const BasketState();

  @override
  List<Object> get props => [];
}

class BasketLoadInProgress extends BasketState {}

class BasketLoadSuccess extends BasketState {
  final List<MenuItem> menuItems;
  final List<Map> jsonEncoding;

  const BasketLoadSuccess(this.menuItems, this.jsonEncoding);

  @override
  List<Object> get props => [menuItems];

  @override
  String toString() =>
      'BasketLoadSuccess { menuItems: $menuItems , jsonEncoding: $jsonEncoding}';
}

class BasketLoadFailure extends BasketState {}
