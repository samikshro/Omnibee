import 'package:flutter/material.dart';
import 'package:Henfam/models/menuModel.dart';
import 'menuPageHeader.dart';
import 'package:Henfam/pages/explore/menu/menuOrderForm.dart';
import 'package:Henfam/pages/explore/menu/basketForm.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Menu extends StatefulWidget {
  // final MenuModel restaurant;
  final DocumentSnapshot document;

  //static bool viewbasket_enabled = false;
  Menu({this.document});

  @override
  _MenuState createState() => _MenuState();
}

bool _viewbasket_enabled = false;
var _onPressed;
//List<FoodInfo> order;

class _MenuState extends State<Menu> {
  static List<FoodInfo> order;
  Future<FoodInfo> _navigateAndGetOrderInfo(
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
        )) as FoodInfo;


    // After the Selection Screen returns a result, hide any previous snackbars
    // and show the new result.
    Scaffold.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text("Added " + result.name + "!")));

    setState(() {
      _viewbasket_enabled = true;
    });

    print(result.name);

    return result;
  }

  @override
  Widget build(BuildContext context) {
    final MenuModel restaurant = ModalRoute.of(context).settings.arguments;
    Future<FoodInfo> res;

    return Scaffold(
        body: CustomScrollView(
      slivers: <Widget>[
        SliverPersistentHeader(
          pinned: false,
          floating: true,
          delegate: MenuPageHeader(
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
                      _navigateAndGetOrderInfo(context, index, restaurant)
                          .then((FoodInfo ord) {
                        print(_viewbasket_enabled);

                        if (ord != null) {
                          print(ord.name);
                          setState(() {
                            _onPressed = () {
                              Navigator.pushNamed(context, '/basket_form',
                                  arguments:
                                      BasketData(orders: [ord].toList()));
                            };
                          });

                          print(_onPressed);
                        } else {
                          _onPressed = () {};
                        }
                      });
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
        SliverFillRemaining(
          hasScrollBody: false,
          fillOverscroll:
              true, // Set true to change overscroll behavior. Purely preference.
          child: Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: double.infinity,
              height: 60,
              child: RaisedButton(
                child: Text('View Basket', style: TextStyle(fontSize: 20.0)),
                color: Colors.amberAccent,
                onPressed: _onPressed,
              ),
            ),
          ),
        )
      ],
    ));
  }
}
