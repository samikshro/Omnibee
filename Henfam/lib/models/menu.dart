import 'models.dart';
import 'package:equatable/equatable.dart';

class Menu extends Equatable {
  final List<MenuCategory> categories;
  final Map<String, MenuModifier> modifiers;

  Menu({this.categories, this.modifiers});

  int getNumberCategories() {
    return categories.length;
  }

  @override
  List<Object> get props => [
        categories,
        modifiers,
      ];
}
