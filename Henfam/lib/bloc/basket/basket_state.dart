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
    return PaymentService.getPCharge(price);
  }

  double getMinEarnings() {
    double price = _getItemsPrice();
    return PaymentService.getDelivererFee(price);
  }

  double getOmnibeeFee() {
    double price = _getItemsPrice();
    double omnibeeFee = PaymentService.getOmnibeeFee(price);
    print("Price in getOmnibeeFee (basket_state) is $omnibeeFee");
    return omnibeeFee;
  }
}

class BasketLoadFailure extends BasketState {}
