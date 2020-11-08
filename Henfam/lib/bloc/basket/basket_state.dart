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

  double _getItemsPrice() {
    double price = 0.0;
    menuItems.forEach((item) {
      price += item.price;
      item.modifiersChosen.forEach((modifier) {
        price += modifier.price;
      });
    });
    return price;
  }

  double getPrice() {
    double price = _getItemsPrice();
    double deliveryFee = .2 * price;
    double tax = .08 * (deliveryFee + price);
    double totalPrice = price + deliveryFee + tax;
    return double.parse(totalPrice.toStringAsFixed(2));
  }

  double getMinEarnings() {
    double price = _getItemsPrice();
    double minEarnings = .2 * price;
    return double.parse(minEarnings.toStringAsFixed(2));
  }
}

class BasketLoadFailure extends BasketState {}
