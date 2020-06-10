import 'package:flutter/material.dart';

class HelpCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.all(15.0),
        childAspectRatio: 6.0 / 9.0,
        children: _buildGridCards(5),
      ),
    );
  }

  // method to generate help with cards
  List<Card> _buildGridCards(int count) {
    List<Card> cards = List.generate(
      count,
      (int index) => Card(
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
    );

    return cards;
  }
}
