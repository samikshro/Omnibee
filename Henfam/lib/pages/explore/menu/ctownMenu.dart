import 'package:flutter/material.dart';
import 'package:Henfam/models/ctownMenuModel.dart';
import 'ctownMenuPageHeader.dart';
import 'package:Henfam/pages/explore/menu/menuOrderForm.dart';

class CtownMenu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<CtownMenu> {
  List<MenuModel> list = MenuModel.ctownList;

  @override
  Widget build(BuildContext context) {
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
                      Navigator.pushNamed(context, '/menu_order_form',
                          arguments: FoodInfo(
                            name: list[0].food[index].name,
                            desc: list[0].food[index].desc,
                            price: list[0].food[index].price,
                            addOns: list[0].food[index].addOns,
                            quantity: 1,
                          ));
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
      ],
    ));
  }
}