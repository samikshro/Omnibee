import 'package:Henfam/models/menuModel.dart';
import 'package:flutter/material.dart';

class DeliveryArguments {
  final String headerCaption;
  final List<MenuModel> menus;

  DeliveryArguments(this.headerCaption, this.menus);
}

class HelpCard extends StatelessWidget {
  final List<Map<String, Object>> activities;

  HelpCard(this.activities);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.count(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        crossAxisCount: 2,
        padding: EdgeInsets.all(15.0),
        childAspectRatio: 6.0 / 9.0,
        children: _buildGridCards(activities.length, context),
      ),
    );
  }

  List<MenuModel> _getMenu(int index) {
    return (index == 0) ? MenuModel.ctownList : MenuModel.campusList;
  }

  String _getCategoryCaption(int index) {
    return (index == 0) ? "Collegetown Food Delivery" : "Campus Food Delivery";
  }

  // method to generate help with cards
  List<GestureDetector> _buildGridCards(int count, BuildContext context) {
    List<GestureDetector> cards = List.generate(
      count,
      (int index) => GestureDetector(
        onTap: () {
          Navigator.pushNamed(
            context,
            '/Delivery',
            arguments: DeliveryArguments(
              _getCategoryCaption(index),
              _getMenu(index),
            ),
          );
        },
        child: Card(
          clipBehavior: Clip.antiAlias,
          margin: EdgeInsets.all(6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AspectRatio(
                aspectRatio: 12.0 / 11.0,
                child: activities[index]['picture'],
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      activities[index]['caption'],
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );

    return cards;
  }
}
