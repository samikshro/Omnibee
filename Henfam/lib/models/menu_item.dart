import 'package:equatable/equatable.dart';

class MenuItem extends Equatable {
  final String name;
  final double price;
  final List<MenuItem> addOns;

  MenuItem(this.name, this.price, this.addOns);

  @override
  List<Object> get props => [name, price, addOns];
}
