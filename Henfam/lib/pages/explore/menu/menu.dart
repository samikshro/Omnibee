import 'package:flutter/material.dart';
import 'menuPageHeader.dart';
import 'package:Henfam/pages/explore/menu/menuOrderForm.dart';
import 'package:Henfam/pages/explore/menu/basketForm.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Menu extends StatefulWidget {
  // final MenuModel restaurant;
  final DocumentSnapshot document;
  static List<FoodInfo> order;

  //static bool viewbasket_enabled = false;
  Menu({this.document});

  @override
  _MenuState createState() => _MenuState();
}

bool _viewbasket_enabled = false;
var _onPressed;

class _MenuState extends State<Menu> {
  Future<FoodDocument> _navigateAndGetOrderInfo(BuildContext context, int index,
      DocumentSnapshot document, List<FoodInfo> order) async {
    //MenuModel restaurant) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.pushNamed(context, '/menu_order_form',
        arguments: FoodDocument(
          document: document,
          index: index,
          order: order,
        )) as FoodDocument;

    // After the Selection Screen returns a result, hide any previous snackbars
    // and show the new result.
    Scaffold.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(
          content: Text(
              "Added " + result.document['food'][result.index]['name'] + "!")));

    setState(() {
      _viewbasket_enabled = true;
    });
    print("here is length of result order in menu:" +
        result.order.length.toString());

    setState(() {
      Menu.order = result.order;
    });
    print("here is length of order in menu:" + Menu.order.length.toString());

    // print(result.name);
    print(result.document['food'][result.index]['name']);

    return result;
  }

  @override
  Widget build(BuildContext context) {
    final DocumentSnapshot document = ModalRoute.of(context).settings.arguments;

    return Scaffold(
        body: CustomScrollView(
      slivers: <Widget>[
        SliverPersistentHeader(
          pinned: false,
          floating: true,
          delegate: MenuPageHeader(
            document: document,
            minExtent: 150.0,
            maxExtent: 250.0,
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            ExpansionTile(
                title: Text('Open until ' + document['hours']['end_time'])),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) {
                  return Divider();
                },
                itemCount: document['food'].length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      _navigateAndGetOrderInfo(
                              context, index, document, Menu.order)
                          .then((FoodDocument ord) {
                        print(_viewbasket_enabled);

                        if (ord != null) {
                          // print(ord.document);
                          setState(() {
                            _onPressed = () {
                              Navigator.pushNamed(context, '/basket_form',
                                  arguments: BasketData(orders: ord.order));
                            };
                          });

                          print(_onPressed);
                        } else {
                          _onPressed = () {};
                        }
                      });
                    },
                    title: Text(document['food'][index]['name']),
                    subtitle: Wrap(direction: Axis.vertical, children: [
                      Text(document['food'][index]['desc']),
                      // SizedBox(width: 25),
                      Text("\$" + document['food'][index]['price'].toString()),
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
