import 'models.dart';
import 'package:equatable/equatable.dart';

class MenuModifier extends Equatable {
  final String header;
  final int maxSelectable;
  final List<ModifierItem> modifierItems;

  MenuModifier(this.header, this.maxSelectable, this.modifierItems);

  List<Object> get props => [
        this.header,
        this.maxSelectable,
        this.modifierItems,
      ];
}
