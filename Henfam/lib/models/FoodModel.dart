import 'AddOnModel.dart';

class FoodModel {
  final String name;
  final String desc;
  final String price;
  final List<AddOns> addOns;

  FoodModel({this.name, this.desc, this.price, this.addOns});
}
