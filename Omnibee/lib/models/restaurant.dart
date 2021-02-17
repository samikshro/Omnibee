import 'models.dart';
import 'package:equatable/equatable.dart';

class Restaurant extends Equatable {
  final String name;
  final Menu menu;
  final Map<String, String> hours;
  final List<double> location;
  final List<String> cuisineTypes;
  final String bigImagePath;
  final String smallImagePath;

  Restaurant({
    this.name,
    this.menu,
    this.hours,
    this.location,
    this.cuisineTypes,
    this.bigImagePath,
    this.smallImagePath,
  });

  @override
  List<Object> get props => [
        name,
        menu,
        hours,
        location,
        cuisineTypes,
        bigImagePath,
        smallImagePath,
      ];
}
