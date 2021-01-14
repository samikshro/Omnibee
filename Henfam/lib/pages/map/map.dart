import 'dart:math';

import 'package:Henfam/models/models.dart';
import 'package:Henfam/pages/map/mapArgs.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';

class CustomMap extends StatefulWidget {
  final List<Order> orders;
  final List<bool> selectedList;

  CustomMap(this.orders, this.selectedList);

  @override
  _CustomMapState createState() => _CustomMapState();
}

class _CustomMapState extends State<CustomMap> {
  GoogleMapController mapController;

  Future<List<Position>> getPositions() async {
    List<Position> positions = [];
    positions.add(await getUserPosition());
    positions.add(getRestaurantPosition());
    positions.addAll(getRequestPositions());

    return positions;
  }

  Future<Position> getUserPosition() async {
    final geolocator = Geolocator()..forceAndroidLocationManager = true;
    print("Before getting current position");
    final position = await geolocator.getCurrentPosition(
      //locationPermissionLevel: GeolocationPermission.locationWhenInUse,
      desiredAccuracy: LocationAccuracy.high,
    );
    print(
        "Latitude is ${position.latitude} and longitude ${position.longitude}");

    return position;
  }

  Position getRestaurantPosition() {
    print("Inside getrestaurantposition");
    Point coordinates = widget.orders[0].restaurantCoordinates;
    print(
        "restaurants: latitude is ${coordinates.x} and longitude is ${coordinates.y}");
    return Position(
      latitude: coordinates.x,
      longitude: coordinates.y,
    );
  }

  List<Position> getRequestPositions() {
    print("Inside getRequestPosition");

    List<Position> requestPositions = [];

    for (int i = 0; i < widget.orders.length; i++) {
      if (widget.selectedList[i] == true) {
        Point coordinates = widget.orders[i].restaurantCoordinates;
        print(
            "request: latitude is ${coordinates.x} and longitude is ${coordinates.y}");

        Position pos = Position(
          latitude: coordinates.x,
          longitude: coordinates.y,
        );
        requestPositions.add(pos);
      }
    }

    return requestPositions;
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    print("Entering build custom map");
    return FutureBuilder<List<Position>>(
      future: getPositions(),
      builder: (BuildContext context, AsyncSnapshot<List<Position>> snapshot) {
        if (snapshot.hasData) {
          return GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              Navigator.pushNamed(context, '/expanded_map',
                  arguments: MapArgs(
                      _createMarkers(
                        snapshot.data,
                      ),
                      snapshot.data[1]));
            },
            child: Hero(
              tag: 'map',
              child: SizedBox(
                height: 250,
                width: double.infinity,
                child: IgnorePointer(
                  child: GoogleMap(
                    myLocationButtonEnabled: false,
                    onMapCreated: _onMapCreated,
                    markers: _createMarkers(
                      snapshot.data,
                    ),
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                        snapshot.data[1].latitude,
                        snapshot.data[1].longitude,
                      ),
                      zoom: 14,
                    ),
                  ),
                ),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Column(
            children: <Widget>[
              Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Error: ${snapshot.error}'),
              )
            ],
          );
        } else {
          return Center(
            child: SizedBox(
              child: CircularProgressIndicator(),
              width: 60,
              height: 60,
            ),
          );
        }
      },
    );
  }
}

Set<Marker> _createMarkers(List<Position> positions) {
  print("Inside createmarkers");
  var markers = <Marker>[];

  for (var i = 0; i < positions.length; i++) {
    print("Inside loop createmarkers");
    final newMarker = Marker(
      markerId: MarkerId(i.toString()),
      position: LatLng(
        positions[i].latitude,
        positions[i].longitude,
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(
        BitmapDescriptor.hueOrange,
      ),
    );
    print("Adding marker to list");
    markers.add(newMarker);
  }
  print("Finished create markers");
  return markers.toSet();
}
