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

  const BasketLoadSuccess([this.menuItems = const []]);

  @override
  List<Object> get props => [menuItems];

  @override
  String toString() => 'BasketLoadSuccess { menuItems: $menuItems }';

  List<Map> toJson() {
    List<Map> orders = [];
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
    menuItem.addOns.forEach((addOn) {
      addOnsStringList.add(addOn.name);
    });
    return addOnsStringList;
  }
}

class BasketLoadFailure extends BasketState {}
