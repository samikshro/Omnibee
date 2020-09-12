import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Henfam/models/models.dart';

//PURPOSE OF FILE IS TO MAP FIREBASE MENU DATA TO MENU MODEL

class MenuFactory {
  static Menu constructMenu(DocumentSnapshot restaurantDoc) {
    List<Map> categoryData =
        List<Map>.from(restaurantDoc['menu']['categories']);
    List<MenuCategory> categories =
        MenuFactory.constructMenuCategory(categoryData);
    Map<String, MenuModifier> modifiers =
        MenuFactory.constructMenuModifiers(restaurantDoc['menu']['modifiers']);

    return Menu(categories: categories, modifiers: modifiers);
  }

  static List<MenuCategory> constructMenuCategory(List<Map> categoryData) {
    List<MenuCategory> categories = [];

    for (int index = 0; index < categoryData.length; index++) {
      Map currentCategory = categoryData[index];
      List<Map> currentItems = List<Map>.from(currentCategory['items']);

      MenuCategory category = MenuCategory(
        currentCategory['name_of_category'],
        MenuFactory.constructMenuItems(currentItems),
      );

      categories.add(category);
    }

    return categories;
  }

  static Map<String, MenuModifier> constructMenuModifiers(Map modifierData) {
    Map<String, MenuModifier> modifiers = {};

    modifierData.forEach((key, value) {
      MenuModifier modifier = MenuModifier(
        value['header'],
        value['max_select'],
        MenuFactory.constructModifierItems(List<Map>.from(value['items'])),
      );

      modifiers[key] = modifier;
    });

    return modifiers;
  }

  static List<ModifierItem> constructModifierItems(List<Map> itemData) {
    List<ModifierItem> modifierItems = [];

    for (int index = 0; index < itemData.length; index++) {
      Map currentItem = itemData[index];

      double price = currentItem['price'] is String
          ? double.parse(currentItem['price'])
          : currentItem['price'].toDouble();

      ModifierItem modifierItem = ModifierItem(
        name: currentItem['name'],
        description: currentItem['desc'],
        price: price,
      );

      modifierItems.add(modifierItem);
    }

    return modifierItems;
  }

  static List<MenuItem> constructMenuItems(List<Map> itemData) {
    List<MenuItem> menuItems = [];

    for (int index = 0; index < itemData.length; index++) {
      Map currentItem = itemData[index];

      List<String> modifiers = currentItem['modifiers'] != null
          ? List<String>.from(currentItem['modifiers'])
          : [];

      MenuItem item = MenuItem(
        currentItem['name'],
        currentItem['desc'],
        currentItem['price'].toDouble(),
        modifiers,
      );

      menuItems.add(item);
    }

    return menuItems;
  }
}
