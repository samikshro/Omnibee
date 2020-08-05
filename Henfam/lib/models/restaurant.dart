import 'package:equatable/equatable.dart';

class Restaurant extends Equatable {
  final String name;
  final List<double> location;
  final String imagePath;

  Restaurant({this.name, this.location, this.imagePath});

  @override
  List<Object> get props => [name, location, imagePath];
}
