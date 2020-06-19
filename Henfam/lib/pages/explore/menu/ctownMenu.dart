import 'package:flutter/material.dart';
import 'package:Henfam/models/ctownMenuModel.dart';
import 'ctownMenuPageHeader.dart';

class CtownMenu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<CtownMenu> {
  List<MenuModel> list = MenuModel.list;

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
                      Navigator.pushNamed(
                        context,
                        '/ctown',
                        arguments: Data(name: list[index].contact.name),
                      );
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
