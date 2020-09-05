import 'models.dart';
import 'package:equatable/equatable.dart';

class Menu extends Equatable {
  final List<MenuCategory> categories;
  final List<MenuModifier> modifiers;

  Menu({this.categories, this.modifiers});

  @override
  List<Object> get props => [
        categories,
        modifiers,
      ];
}
