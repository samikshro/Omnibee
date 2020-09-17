import 'package:Henfam/models/menu_modifier.dart';
import 'package:Henfam/models/models.dart';
import 'package:equatable/equatable.dart';

class MenuItem extends Equatable {
  final String name;
  final String description;
  final double price;
  final List<String> modifiers;
  final List<ModifierItem> modifiersChosen;

  MenuItem(this.name, this.description, this.price, this.modifiers,
      {this.modifiersChosen});

  @override
  List<Object> get props => [
        name,
        description,
        price,
        modifiers,
      ];

  void setModifiersChosen(List<ModifierItem> selectedItems) {
    modifiersChosen.clear();
    modifiersChosen.addAll(selectedItems);
  }

  List<ModifierItem> cloneModifiersChosen() {
    List<ModifierItem> copy = [];
    modifiersChosen.forEach((modifier) {
      copy.add(modifier.copy());
    });

    return copy;
  }
}
