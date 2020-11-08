import 'package:Henfam/bloc/basket/basket_bloc.dart';
import 'package:Henfam/bloc/menu_order_form/menu_order_form_bloc.dart';
import 'package:Henfam/bloc/restaurant/restaurant_bloc.dart';
import 'package:Henfam/models/menu_category.dart';
import 'package:Henfam/models/menu_item.dart';
import 'package:Henfam/models/menu_modifier.dart';
import 'package:Henfam/pages/explore/menu/menuPageHeader.dart';
import 'package:Henfam/widgets/largeTextSection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Henfam/pages/explore/menu/menuOrderForm.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Menu extends StatefulWidget {
  final DocumentSnapshot document;
  static List<FoodInfo> order;
  static var onPressed;
  Menu({this.document});
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  List<MenuModifier> _getMenuModifiers(
      Map<String, MenuModifier> allModifiers, MenuItem menuItem) {
    List<MenuModifier> modifiers = [];

    for (int index = 0; index < menuItem.modifiers.length; index++) {
      modifiers.add(allModifiers[menuItem.modifiers[index]]);
    }

    return modifiers;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RestaurantBloc, RestaurantState>(
        builder: (context, state) {
      return BlocBuilder<MenuOrderFormBloc, MenuOrderFormState>(
          builder: (context1, state1) {
        return (state is RestaurantLoadSuccess)
            ? WillPopScope(
                onWillPop: () async {
                  Menu.order = [];
                  return true;
                },
                child: Scaffold(
                  bottomNavigationBar: SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: RaisedButton(
                      child: Text('View Basket',
                          style: TextStyle(
                              fontSize: 20.0,
                              color:
                                  Theme.of(context).scaffoldBackgroundColor)),
                      onPressed: () {
                        BlocProvider.of<BasketBloc>(context)
                            .add(MenuItemDeleted(null));
                        Navigator.pushNamed(
                          context,
                          '/basket_form',
                        );
                      },
                    ),
                  ),
                  body: CustomScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    slivers: <Widget>[
                      SliverPersistentHeader(
                        pinned: false,
                        floating: true,
                        delegate: MenuPageHeader(
                          restaurant: state.restaurant,
                          minExtent: 150.0,
                          maxExtent: 250.0,
                        ),
                      ),
                      SliverList(
                        delegate: SliverChildListDelegate([
                          ExpansionTile(
                              title: Text('Open until ' +
                                  state.restaurant.hours['end_time'])),
                          ListView.separated(
                              physics: NeverScrollableScrollPhysics(),
                              separatorBuilder: (context, index) {
                                return Divider();
                              },
                              itemCount:
                                  state.restaurant.menu.getNumberCategories(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                MenuCategory category =
                                    state.restaurant.menu.categories[index];
                                return Column(
                                  children: [
                                    LargeTextSection(category.categoryName),
                                    Divider(),
                                    ListView.separated(
                                      physics: NeverScrollableScrollPhysics(),
                                      separatorBuilder: (context, index) {
                                        return Divider();
                                      },
                                      itemCount: category.getNumItems(),
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index2) {
                                        MenuItem menuItem =
                                            category.menuItems[index2];

                                        return ListTile(
                                          onTap: () {
                                            List<MenuModifier> modifiers =
                                                _getMenuModifiers(
                                                    state.restaurant.menu
                                                        .modifiers,
                                                    menuItem);

                                            BlocProvider.of<MenuOrderFormBloc>(
                                                    context1)
                                                .add(ItemAdded(
                                                    menuItem, modifiers));
                                            Navigator.pushNamed(
                                                context, '/menu_order_form');
                                          },
                                          title: Text(menuItem.name),
                                          subtitle: Wrap(
                                              direction: Axis.vertical,
                                              children: menuItem.description !=
                                                      null
                                                  ? [
                                                      Text(
                                                        menuItem.description,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                      Text("\$" +
                                                          menuItem.price
                                                              .toStringAsFixed(
                                                                  2)),
                                                    ]
                                                  : [
                                                      Text("\$" +
                                                          menuItem.price
                                                              .toString())
                                                    ]),
                                          isThreeLine: true,
                                        );
                                      },
                                    ),
                                  ],
                                );
                              }),
                        ]),
                      ),
                    ],
                  ),
                ),
              )
            : Container();
      });
    });
  }
}
