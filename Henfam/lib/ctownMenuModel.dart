import 'package:flutter/material.dart';

import 'package:Henfam/FoodModel.dart';
import './restaurantCard.dart';

class MenuModel {
  final String restName;
  final List<String> typeFood;
  final String hours;
  final String distance;
  final FoodModel food;
  final Image photo;

  MenuModel({
    this.restName,
    this.typeFood,
    this.hours,
    this.distance,
    this.food,
    this.photo,
  });

  RestaurantCard displayRestaurantCard() {
    return RestaurantCard(
      photo,
      restName,
      typeFood,
      hours,
    );
  }

  static List<MenuModel> list = [
    MenuModel(
      restName: 'Oishii Bowl',
      typeFood: ['Asian', 'Japanese'],
      hours: '9PM',
      photo: Image(
        image: AssetImage('assets/oishiibowl.png'),
      ),
    ),
    MenuModel(
      restName: 'Kung Fu Tea',
      typeFood: ['Beverages'],
      hours: '9PM',
      photo: Image(
        image: AssetImage('assets/kungfutea.png'),
      ),
    ),
    MenuModel(
      restName: 'Insomnia Cookies',
      typeFood: ['Cookies', 'Desserts'],
      hours: '1AM',
      photo: Image(
        image: AssetImage('assets/insomnia.png'),
      ),
    ),
  ];
}
