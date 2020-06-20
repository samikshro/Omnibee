import 'package:flutter/material.dart';

import 'package:Henfam/models/FoodModel.dart';
import 'package:Henfam/pages/explore/restaurantCard.dart';
import 'AddOnModel.dart';

class MenuModel {
  final String restName;
  final List<String> typeFood;
  final String hours;
  final String distance;
  final List<FoodModel> food;
  final Image smallPhoto;
  final Image bigPhoto;

  MenuModel({
    this.restName,
    this.typeFood,
    this.hours,
    this.distance,
    this.food,
    this.smallPhoto,
    this.bigPhoto,
  });

  RestaurantCard displayRestaurantCard() {
    return RestaurantCard(this);
  }

  static List<AddOns> katsu_don_addons = [
    AddOns(
      name: 'Brown Rice',
      price: 1.50,
      chosen: false,
    ),
    AddOns(name: 'Red Pepper Flakes', price: 0.00, chosen: false),
  ];

  static List<FoodModel> oiishi_food = [
    FoodModel(
      name: 'Katsu Don',
      desc: 'Rice bowl topped with pork cutlet, egg, onion, and green onion',
      price: '9.99',
      addOns: katsu_don_addons,
    ),
    FoodModel(
      name: 'Oyako Don',
      desc: 'Rice bowl topped with chicken, egg, and onions',
      price: '9.99',
      addOns: katsu_don_addons,
    ),
    FoodModel(
      name: 'Miso Ramen',
      desc:
          'Ramen noodle in miso-based soup, corn, egg, pork, bamboo shoot and vegetables',
      price: '9.99',
      addOns: katsu_don_addons,
    ),
    FoodModel(
      name: 'Shoyu Don',
      desc:
          'Ramen noodle in soy sauce-based soup, egg, pork, bamboo shoot and vegetables',
      price: '9.99',
      addOns: katsu_don_addons,
    ),
  ];

  static List<MenuModel> ctownList = [
    MenuModel(
      restName: 'Oishii Bowl',
      typeFood: ['Asian', 'Japanese'],
      hours: '9PM',
      smallPhoto: Image(
        image: AssetImage('assets/oishiibowl.png'),
        fit: BoxFit.cover,
      ),
      bigPhoto: Image(
        image: AssetImage('assets/oishii_bowl_pic1.png'),
        fit: BoxFit.cover,
      ),
      food: oiishi_food,
    ),
    MenuModel(
      restName: 'Kung Fu Tea',
      typeFood: ['Beverages'],
      hours: '9PM',
      smallPhoto: Image(
        image: AssetImage('assets/kungfutea.png'),
        fit: BoxFit.cover,
      ),
      bigPhoto: Image(
        image: AssetImage('assets/kungfutea.png'),
        fit: BoxFit.cover,
      ),
      food: oiishi_food,
    ),
    MenuModel(
      restName: 'Insomnia Cookies',
      typeFood: ['Cookies', 'Desserts'],
      hours: '1AM',
      smallPhoto: Image(
        image: AssetImage('assets/insomnia.png'),
        fit: BoxFit.cover,
      ),
      bigPhoto: Image(
        image: AssetImage('assets/insomnia.png'),
        fit: BoxFit.cover,
      ),
      food: oiishi_food,
    ),
  ];

  static List<MenuModel> campusList = [
    MenuModel(
      restName: 'Libe Cafe',
      typeFood: ['Asian', 'Japanese'],
      hours: '9PM',
      smallPhoto: Image(
        image: AssetImage('assets/oishiibowl.png'),
        fit: BoxFit.cover,
      ),
      bigPhoto: Image(
        image: AssetImage('assets/oishii_bowl_pic1.png'),
        fit: BoxFit.cover,
      ),
      food: oiishi_food,
    ),
    MenuModel(
      restName: 'Rusty\'s',
      typeFood: ['Beverages'],
      hours: '9PM',
      smallPhoto: Image(
        image: AssetImage('assets/kungfutea.png'),
        fit: BoxFit.cover,
      ),
      bigPhoto: Image(
        image: AssetImage('assets/kungfutea.png'),
        fit: BoxFit.cover,
      ),
      food: oiishi_food,
    ),
  ];
}
