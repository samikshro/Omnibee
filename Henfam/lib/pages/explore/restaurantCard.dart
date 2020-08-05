import 'package:Henfam/bloc/blocs.dart';
import 'package:Henfam/models/restaurant.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RestaurantCard extends StatelessWidget {
  // final MenuModel restaurant;
  final DocumentSnapshot document;

  RestaurantCard(BuildContext context, {this.document}); //this.restaurant);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RestaurantBloc, RestaurantState>(
        builder: (context, state) {
      return GestureDetector(
        onTap: () {
          GeoPoint position = document['location'];
          List<double> location = [position.latitude, position.longitude];
          Restaurant selectedRestaurant = Restaurant(
            name: document['rest_name'],
            location: location,
            imagePath: document['big_photo'],
          );
          BlocProvider.of<RestaurantBloc>(context)
              .add(RestaurantUpdated(selectedRestaurant));
          Navigator.pushNamed(context, '/Menu', arguments: document);
        },
        child: Card(
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Row(
            children: <Widget>[
              //restaurant.smallPhoto,
              Image(
                image: AssetImage(document['small_photo']),
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(document['rest_name'],
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Padding(padding: EdgeInsets.only(bottom: 7)),
                    Text(document['type_food'].join(', ')),
                    Padding(padding: EdgeInsets.only(bottom: 7)),
                    Text(
                      "Open until " + document['hours']['end_time'],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
