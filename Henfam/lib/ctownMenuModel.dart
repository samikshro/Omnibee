import 'package:flutter/material.dart';

import 'package:Henfam/FoodModel.dart';
import './restaurantCard.dart';

class MenuModel {
  final String restName;
  final List<String> typeFood;
  final String hours;
  final String distance;
  final List<FoodModel> food;
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

  static List<FoodModel> oiishi_food = [
    FoodModel(
        name: 'Katsu Don',
        desc: 'Rice bowl topped with pork cutlet, egg, onion, and green onion',
        price: '9.99'),
    FoodModel(
        name: 'Oyako Don',
        desc: 'Rice bowl topped with chicken, egg, and onions',
        price: "9.99"),
    FoodModel(
        name: 'Miso Ramen',
        desc:
            'Ramen noodle in miso-based soup, corn, egg, pork, bamboo shoot and vegetables',
        price: '9.99'),
    FoodModel(
        name: 'Shoyu Don',
        desc:
            'Ramen noodle in soy sauce-based soup, egg, pork, bamboo shoot and vegetables',
        price: '9.99'),
  ];

  static List<MenuModel> list = [
    MenuModel(
      restName: 'Oishii Bowl',
      typeFood: ['Asian', 'Japanese'],
      hours: '9PM',
      photo: Image(
        image: AssetImage('assets/oishiibowl.png'),
        fit: BoxFit.cover,
      ),
      food: oiishi_food,
    ),
    MenuModel(
      restName: 'Kung Fu Tea',
      typeFood: ['Beverages'],
      hours: '9PM',
      photo: Image(
        image: AssetImage('assets/kungfutea.png'),
        fit: BoxFit.cover,
      ),
      food: oiishi_food,
    ),
    MenuModel(
      restName: 'Insomnia Cookies',
      typeFood: ['Cookies', 'Desserts'],
      hours: '1AM',
      photo: Image(
        image: AssetImage('assets/insomnia.png'),
        fit: BoxFit.cover,
      ),
      food: oiishi_food,
    ),
  ];
}
