import 'package:Henfam/models/AddOnModel.dart';
import 'package:equatable/equatable.dart';

class MenuItem extends Equatable {
  final String name;
  final String description;
  final double price;
  final List<String> modifiers;
  final List<AddOns> addOns;

  MenuItem(this.name, this.description, this.price, this.modifiers,
      {this.addOns});

  @override
  List<Object> get props => [
        name,
        description,
        price,
        modifiers,
      ];
}
