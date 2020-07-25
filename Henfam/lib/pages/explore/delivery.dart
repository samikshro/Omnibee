import 'package:Henfam/pages/explore/helpcard.dart';
import 'package:Henfam/pages/explore/restaurantCard.dart';
import 'package:flutter/material.dart';

import 'package:Henfam/widgets/largeTextSection.dart';
import 'package:Henfam/models/menuModel.dart';
import 'package:Henfam/pages/explore/errandFee.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Delivery extends StatefulWidget {
  List<MenuModel> list;
  String headerCaption;
  Delivery({this.list, this.headerCaption});

  @override
  _DeliveryState createState() => _DeliveryState();
}

class _DeliveryState extends State<Delivery> {
  // var _location = "Olin Library";

  @override
  Widget build(BuildContext context) {
    final DeliveryArguments args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(args.headerCaption),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ErrandFee(),
            LargeTextSection("Choose a restaurant"),
            Column(children: [
              StreamBuilder(
                  stream: Firestore.instance.collection('menu').snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) return const Text('Loading....');
                    print("length of delivery doc steam: " +
                        snapshot.data.documents.length.toString());
                    return ListView.builder(
                        itemCount: snapshot.data.documents.length,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return RestaurantCard(context,
                              document: snapshot.data.documents[index]);
                        });
                  }),
            ]),
          ],
        ),
      ),
    );
  }
}
