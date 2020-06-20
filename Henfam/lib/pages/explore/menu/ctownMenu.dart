import 'package:flutter/material.dart';
import 'package:Henfam/models/ctownMenuModel.dart';
import 'ctownMenuPageHeader.dart';
import 'package:Henfam/pages/explore/menu/menuOrderForm.dart';

class CtownMenu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

bool viewbasket_enabled = false;

class _MenuState extends State<CtownMenu> {
  List<MenuModel> list = MenuModel.ctownList;

  Future _navigateAndGetOrderInfo(BuildContext context, int index) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final FoodInfo result = await Navigator.pushNamed(context, '/menu_order_form',
        arguments: FoodInfo(
          name: list[0].food[index].name,
          desc: list[0].food[index].desc,
          price: list[0].food[index].price,
          addOns: list[0].food[index].addOns,
          quantity: 1,
        ));

    // After the Selection Screen returns a result, hide any previous snackbars
    // and show the new result.
    Scaffold.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text("Added " + result.name + "!")
          // Text("$result")
          ));

    setState(() {
      viewbasket_enabled = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    var _onPressed;
    if (viewbasket_enabled) {
      _onPressed = () {
        Navigator.pushNamed(context, '/basket_form');
      };
    }

    return Scaffold(
        body: CustomScrollView(
      slivers: <Widget>[
        SliverPersistentHeader(
          pinned: false,
          floating: true,
          delegate: CtownMenuPageHeader(
            minExtent: 150.0,
            maxExtent: 250.0,
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            ExpansionTile(title: Text('Open until ' + list[0].hours)),
            Container(
              height: 100.0 * list[0].food.length,
              child: ListView.separated(
                separatorBuilder: (context, index) {
                  return Divider();
                },
                itemCount: list[0].food.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      _navigateAndGetOrderInfo(context, index);
                    },
                    title: Text(list[0].food[index].name),
                    subtitle: Wrap(direction: Axis.vertical, children: [
                      Text(
                        list[0].food[index].desc,
                      ),
                      // SizedBox(width: 25),
                      Text("\$" + list[0].food[index].price),
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
