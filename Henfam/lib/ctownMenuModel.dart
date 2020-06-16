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
}
