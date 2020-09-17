import 'package:equatable/equatable.dart';

class ModifierItem extends Equatable {
  final String name;
  final String description;
  final double price;

  ModifierItem({this.name, this.description, this.price});

  List<Object> get props => [
        name,
        description,
        price,
      ];

  ModifierItem copy() {
    return ModifierItem(name: name, description: description, price: price);
  }
}
