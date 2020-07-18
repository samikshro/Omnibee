import 'package:flutter/material.dart';
import 'package:Henfam/widgets/largeTextSection.dart';
import 'package:Henfam/models/FoodModel.dart';
import 'package:Henfam/models/AddOnModel.dart';
import 'package:geolocator/geolocator.dart';
import 'menuOrderForm.dart';

class BasketData {
  // final List<String> names;
  // final List<String> prices;
  // final List<String> requests;
  // final List<String> addons;
  // BasketData({this.names, this.prices, this.requests, this.addons});
  final List<FoodInfo> orders;
  final String restaurant_name;
  final Position restaurant_loc;
  BasketData({this.orders, this.restaurant_name, this.restaurant_loc});
}

class Basket extends StatefulWidget {
  @override
  _BasketState createState() => _BasketState();
}

class _BasketState extends State<Basket> {
  String _ordersToAddons(List<AddOns> list) {
    String s = '';
    for (int i = 0; i < list.length; i++) {
      s = s + list[i].name + "; ";
    }
    return s;
  }

  Widget _buildTile(BuildContext context, BasketData args, int index) {
    return ListTile(
      onTap: () {},
      trailing: Text("\$" + args.orders[index].price.toString()),
      title: Text(args.orders[index].name),
      subtitle: Wrap(direction: Axis.vertical, children: [
        // Text(
        //   // args.addons[index],
        //   _ordersToAddons(args.orders[index].addOns),
        // ),
      ]),
      isThreeLine: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final BasketData args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        appBar: AppBar(
            title: Text(
          // _ordersToAddons(args.orders[0].addOns)
          'My Basket',
        )),
        body: SafeArea(
            child: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: LargeTextSection("Items"),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => _buildTile(context, args, index),
                childCount: args.orders.length,
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: true,
              fillOverscroll:
                  false, // Set true to change overscroll behavior. Purely preference.
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: RaisedButton(
                    child: Text('Proceed to Request',
                        style: TextStyle(
                            fontSize: 20.0,
                            color: Theme.of(context).scaffoldBackgroundColor)),
                    onPressed: () {
                      Navigator.pushNamed(context, '/request', arguments: args);
                    },
                  ),
                ),
              ),
            )
          ],
        )));
  }
}
