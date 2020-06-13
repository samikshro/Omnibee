import 'package:Henfam/FoodModel.dart';

class MenuModel {
  final String restName;
  final String typeFood;
  final String hours;
  final String distance;
  final FoodModel food;

  MenuModel({this.restName, this.typeFood, this.hours, this.distance, this.food});

  static List<FoodModel> list = [
    MenuModel(
      
    ),
  ];
}