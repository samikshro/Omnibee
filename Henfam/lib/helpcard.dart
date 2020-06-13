import 'package:Henfam/ctownDelivery.dart';
import 'package:flutter/material.dart';

class HelpCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: IgnorePointer(
        child: GridView.count(
          shrinkWrap: true,
          crossAxisCount: 2,
          padding: EdgeInsets.all(15.0),
          childAspectRatio: 6.0 / 9.0,
          children: _buildGridCards(5, context),
        ),
      ),
    );
  }

  // method to generate help with cards
  List<FlatButton> _buildGridCards(int count, BuildContext context) {
    List<FlatButton> cards = List.generate(
      count,
      (int index) => FlatButton(
        onPressed: () {
          Navigator.pushNamed(context, '/ctowndelivery');
        },
        child: Card (
          clipBehavior: Clip.antiAlias,
          margin: EdgeInsets.all(6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AspectRatio(
                aspectRatio: 12.0 / 11.0,
                child: Image.network(
                  'https://www.bbcgoodfood.com/sites/default/files/recipe-collections/collection-image/2018/01/burrito-bowl_1.jpg',
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Getting food from x',
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
