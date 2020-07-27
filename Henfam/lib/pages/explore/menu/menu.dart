import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'menuPageHeader.dart';
import 'package:Henfam/pages/explore/menu/menuOrderForm.dart';
import 'package:Henfam/pages/explore/menu/basketForm.dart';
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
  Future<FoodDocument> _navigateAndGetOrderInfo(BuildContext context, int index,
      DocumentSnapshot document, List<FoodInfo> order) async {
    final result = await Navigator.pushNamed(context, '/menu_order_form',
        arguments: FoodDocument(
          document: document,
          index: index,
          order: order,
        )) as FoodDocument;

    // After the Selection Screen returns a result, hide any previous snackbars
    // and show the new result.
    if (result != null) {
      Scaffold.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(
            backgroundColor: Theme.of(context).accentColor,
            elevation: 10.0,
            content: Text(
                "Added " + result.document['food'][result.index]['name'] + "!"),
            duration: Duration(milliseconds: 100)));

      setState(() {
        Menu.order = result.order;
      });
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    final DocumentSnapshot document = ModalRoute.of(context).settings.arguments;

    return WillPopScope(
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
                        color: Theme.of(context).scaffoldBackgroundColor)),
                onPressed: Menu.onPressed,
              ),
            ),
            body: CustomScrollView(
              physics: AlwaysScrollableScrollPhysics(),
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
                        title: Text(
                            'Open until ' + document['hours']['end_time'])),
                    ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
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
                              if (ord != null) {
                                setState(() {
                                  Menu.onPressed = () {
                                    GeoPoint point = document['location'];
                                    Navigator.pushNamed(
                                      context,
                                      '/basket_form',
                                      arguments: BasketData(
                                        orders: ord.order,
                                        restaurant_name: document['rest_name'],
                                        restaurant_loc: Position(
                                          latitude: point.latitude,
                                          longitude: point.longitude,
                                        ),
                                        restaurant_pic: document['big_photo'],
                                      ),
                                    );
                                  };
                                });
                              } else {
                                Menu.onPressed = () {};
                              }
                            });
                          },
                          title: Text(document['food'][index]['name']),
                          subtitle: Wrap(direction: Axis.vertical, children: [
                            Text(document['food'][index]['desc']),
                            Text("\$" +
                                document['food'][index]['price'].toString()),
                          ]),
                          isThreeLine: true,
                        );
                      },
                    )
                  ]),
                ),
              ],
            )));
  }
}
