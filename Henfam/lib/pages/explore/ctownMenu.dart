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
        //     body: SingleChildScrollView(
        //   scrollDirection: Axis.vertical,
        //   child: Column(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: <Widget>[
        //         Image.asset('assets/oiishi_bowl_pic1.png', fit: BoxFit.cover)
        //       ]),
        // )

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
          delegate: SliverChildListDelegate(
          [
            
            Container(
              height: 100.0 * list[0].food.length,
              child: ListView.builder(
              itemCount: list[0].food.length,
              itemBuilder: (context, index) {
                return ListTile(
                  // onTap: () {
                  //   Navigator.pushNamed(
                  //     context,
                  //     '/ctown',
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
          )]),
        ),
      ],

      // slivers: <Widget>[
      //   SliverAppBar(
      //     stretch: true,
      //     onStretchTrigger: () {
      //       return;
      //     },
      //     floating: false,
      //     //expandedHeight: 400.0,
      //     flexibleSpace: FlexibleSpaceBar(
      //       stretchModes: <StretchMode>[
      //         StretchMode.zoomBackground,
      //         StretchMode.blurBackground,
      //         StretchMode.fadeTitle,
      //       ],
      //       centerTitle: true,
      //       title: Text(list[0].restName),
      //       background: Stack(fit: StackFit.expand, children: [
      //         list[0].photo,
      //         // DecoratedBox(
      //         //     decoration: BoxDecoration(
      //         //   gradient: LinearGradient(
      //         //     begin: Alignment(0.0, 0.5),
      //         //     end: Alignment(0.0, 0.0),
      //         //     colors: <Color>[
      //         //       Color(0x60000000),
      //         //       Color(0x00000000),
      //         //     ],
      //         //   ),
      //         // )),
      //       ]),
      //     ),
      //   ),
      //   SliverList(
      //     delegate: SliverChildListDelegate(
      //       //Container(
      //       //height: 400.0,
      //       (context, index) => ListView.builder(
      //         itemCount: list[0].food.length,
      //         itemBuilder: (context, index) {
      //           return ListTile(
      //             // onTap: () {
      //             //   Navigator.pushNamed(
      //             //     context,
      //             //     '/chat',
      //             //     arguments: Data(name: list[index].contact.name),
      //             //   );
      //             // },
      //             title: Text(list[0].food[index].name),
      //             subtitle: Wrap(direction: Axis.vertical, children: [
      //               Text(list[0].food[index].desc),
      //               // SizedBox(width: 25),
      //               Text("\$" + list[0].food[index].price)
      //             ]),
      //             isThreeLine: true,
      //           );
      //         },
      //       ),

      //       //),
      //     ),
      //   ),
      // ],
    ));
  }
}
