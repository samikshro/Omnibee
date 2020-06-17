import 'package:flutter/material.dart';
import 'ctownMenuModel.dart';

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
        physics: const BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            stretch: true,
            onStretchTrigger: () {
              return;
            },
            expandedHeight: 200.0,
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: <StretchMode>[
                StretchMode.zoomBackground,
                StretchMode.blurBackground,
                StretchMode.fadeTitle,
              ],
              centerTitle: true,
              title: Text(list[0].restName),
              background: Stack(fit: StackFit.expand, children: [
                list[0].photo,
                // DecoratedBox(
                //     decoration: BoxDecoration(
                //   gradient: LinearGradient(
                //     begin: Alignment(0.0, 0.5),
                //     end: Alignment(0.0, 0.0),
                //     colors: <Color>[
                //       Color(0x60000000),
                //       Color(0x00000000),
                //     ],
                //   ),
                // )),
              ]),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Expanded(
                child: Container(
                  height: 400.0,
                  child: ListView.builder(
                    itemCount: list[0].food.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        // onTap: () {
                        //   Navigator.pushNamed(
                        //     context,
                        //     '/chat',
                        //     arguments: Data(name: list[index].contact.name),
                        //   );
                        // },
                        title: Text(list[0].food[index].name),
                        subtitle: Wrap(direction: Axis.vertical, children: [
                          Text(list[0].food[index].desc),
                          // SizedBox(width: 25),
                          Text("\$" + list[0].food[index].price)
                        ]),
                        isThreeLine: true,
                      );
                    },
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
