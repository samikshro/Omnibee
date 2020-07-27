import 'package:flutter/material.dart';
import 'package:Henfam/widgets/largeTextSection.dart';
import 'package:geolocator/geolocator.dart';
import 'menuOrderForm.dart';

class BasketData {
  final List<FoodInfo> orders;
  final String restaurant_name;
  final Position restaurant_loc;
  final String restaurant_pic;
  BasketData({
    this.orders,
    this.restaurant_name,
    this.restaurant_loc,
    this.restaurant_pic,
  });
}

class Basket extends StatefulWidget {
  @override
  _BasketState createState() => _BasketState();
}

class _BasketState extends State<Basket> {
  List<Widget> _displayAddOns(item) {
    List<Widget> addOns = [];
    if (item.addOns != null) {
      for (int i = 0; i < item.addOns.length; i++) {
        addOns.add(Text(item.addOns[i]));
      }
    }

    return addOns;
  }

  Widget _buildTile(BuildContext context, BasketData args, int index) {
    return ListTile(
      onTap: () {},
      trailing: Text("\$" + args.orders[index].price.toString()),
      title: Text(args.orders[index].name),
      subtitle: Wrap(
        direction: Axis.vertical,
        children: _displayAddOns(args.orders[index]),
      ),
      isThreeLine: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final BasketData args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        bottomNavigationBar: SizedBox(
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
          ],
        )));
  }
}
