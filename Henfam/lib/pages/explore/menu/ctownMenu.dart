import 'package:flutter/material.dart';
import 'package:Henfam/models/ctownMenuModel.dart';
import 'ctownMenuPageHeader.dart';
import 'package:Henfam/pages/explore/menu/menuOrderForm.dart';

class CtownMenu extends StatefulWidget {
  final MenuModel restaurant;

  CtownMenu({this.restaurant});

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<CtownMenu> {
  //List<MenuModel> list = MenuModel.ctownList;

  _navigateAndGetOrderInfo(
      BuildContext context, int index, MenuModel restaurant) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.pushNamed(context, '/menu_order_form',
        arguments: FoodInfo(
          name: restaurant.food[index].name,
          desc: restaurant.food[index].desc,
          price: restaurant.food[index].price,
          addOns: restaurant.food[index].addOns,
          quantity: 1,
        ));

    // After the Selection Screen returns a result, hide any previous snackbars
    // and show the new result.
    Scaffold.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text("$result")));
  }

  @override
  Widget build(BuildContext context) {
    final MenuModel restaurant = ModalRoute.of(context).settings.arguments;

    return Scaffold(
        body: CustomScrollView(
      slivers: <Widget>[
        SliverPersistentHeader(
          pinned: false,
          floating: true,
          delegate: CtownMenuPageHeader(
            restaurant: restaurant,
            minExtent: 150.0,
            maxExtent: 250.0,
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            ExpansionTile(title: Text('Open until ' + restaurant.hours)),
            Container(
              height: 100.0 * restaurant.food.length,
              child: ListView.separated(
                separatorBuilder: (context, index) {
                  return Divider();
                },
                itemCount: restaurant.food.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      _navigateAndGetOrderInfo(context, index, restaurant);
                      // Navigator.pushNamed(context, '/menu_order_form',
                      //     arguments: FoodInfo(
                      //       name: list[0].food[index].name,
                      //       desc: list[0].food[index].desc,
                      //       price: list[0].food[index].price,
                      //       addOns: list[0].food[index].addOns,
                      //       quantity: 1,
                      //     ));
                    },
                    title: Text(restaurant.food[index].name),
                    subtitle: Wrap(direction: Axis.vertical, children: [
                      Text(
                        restaurant.food[index].desc,
                      ),
                      // SizedBox(width: 25),
                      Text("\$" + restaurant.food[index].price),
                    ]),
                    isThreeLine: true,
                  );
                },
              ),
            )
          ]),
        ),
      ],
    ));
  }
}
