import 'package:flutter/material.dart';
import 'package:Henfam/widgets/largeTextSection.dart';
import 'package:Henfam/models/FoodModel.dart';
import 'package:Henfam/models/AddOnModel.dart';
import 'menuOrderForm.dart';

class BasketData {
  // final List<String> names;
  // final List<String> prices;
  // final List<String> requests;
  // final List<String> addons;
  // BasketData({this.names, this.prices, this.requests, this.addons});
  // final List<FoodInfo> orders;
  // BasketData({this.orders});
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

  @override
  Widget build(BuildContext context) {
    final BasketData args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.grey,
            title: Text(
              //_ordersToAddons(args.orders[0].addOns)
              'My Basket',
              // style: TextStyle(color: Colors.black),
            )),
        body: SafeArea(
            child: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: LargeTextSection("Items"),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  // Container(
                  //   height: 100.0 * args.orders.length, //args.names.length,
                  //   child: ListView.separated(
                  //     separatorBuilder: (context, index) {
                  //       return Divider();
                  //     },
                  //     itemCount: args.orders.length, //args.names.length,//
                  //     itemBuilder: (context, index) {
                  //       return ListTile(
                  //         onTap: () {},
                  //         trailing: Text("\$" +
                  //             args.orders[index]
                  //                 .price), //args.prices[index]),//
                  //         title: Text(
                  //             args.orders[index].name), //args.names[index]),
                  //         subtitle: Wrap(direction: Axis.vertical, children: [
                  //           Text(
                  //             // args.addons[index],
                  //             _ordersToAddons(args.orders[index].addOns),
                  //           ),
                  //         ]),
                  //         isThreeLine: true,
                  //       );
                  //     },
                  //   ),
                  // )
                ],
              ),
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
                    child: Text('Proceed to Request',
                        style: TextStyle(fontSize: 20.0)),
                    color: Colors.amberAccent,
                    onPressed: () {
                      Navigator.pushNamed(context, '/request');
                    },
                  ),
                ),
              ),
            )
          ],
        )));
  }
}
