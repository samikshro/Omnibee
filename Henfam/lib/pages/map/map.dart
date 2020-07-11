import 'package:Henfam/pages/map/mapArgs.dart';
import 'package:Henfam/pages/map/positionModel.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';

class CustomMap extends StatefulWidget {
  @override
  _CustomMapState createState() => _CustomMapState();
}

class _CustomMapState extends State<CustomMap> {
  GoogleMapController mapController;

  Future<Position> getPosition() async {
    final geolocator = Geolocator()..forceAndroidLocationManager = true;
    final position = await geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return position;
  }

  PositionModel getRestaurantPosition() {
    return PositionModel.restaurantPosition;
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Position>(
      future: getPosition(),
      builder: (BuildContext context, AsyncSnapshot<Position> snapshot) {
        if (snapshot.hasData) {
          return GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              Navigator.pushNamed(context, '/expanded_map',
                  arguments: MapArgs(
                      _createMarkers(snapshot.data), getRestaurantPosition()));
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
                    markers: _createMarkers(snapshot.data),
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                        getRestaurantPosition().latitude,
                        getRestaurantPosition().longitude,
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

Set<Marker> _createMarkers(user_position) {
  final positions = PositionModel.mockPositionData;
  var markers = <Marker>[];

  for (var i = 0; i < positions.length; i++) {
    final newMarker = Marker(
      markerId: MarkerId(positions[i].name),
      position: LatLng(
        positions[i].latitude,
        positions[i].longitude,
      ),
      infoWindow: InfoWindow(title: positions[i].name),
      icon: BitmapDescriptor.defaultMarkerWithHue(
        BitmapDescriptor.hueOrange,
      ),
    );

    markers.add(newMarker);
  }

  markers.add(
    Marker(
      markerId: MarkerId('User'),
      position: LatLng(
        user_position.latitude,
        user_position.longitude,
      ),
      infoWindow: InfoWindow(title: 'User'),
      icon: BitmapDescriptor.defaultMarkerWithHue(
        BitmapDescriptor.hueOrange,
      ),
    ),
  );

  return markers.toSet();
}
