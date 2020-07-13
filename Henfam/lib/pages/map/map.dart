import 'package:Henfam/pages/map/mapArgs.dart';
import 'package:Henfam/pages/map/positionModel.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';

class CustomMap extends StatefulWidget {
  List<Map<String, Object>> requesters;
  Map<String, Object> restaurant;

  CustomMap(this.requesters, this.restaurant);

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
                      _createMarkers(
                        snapshot.data,
                        widget.requesters,
                        widget.restaurant,
                      ),
                      getRestaurantPosition()));
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
                      widget.requesters,
                      widget.restaurant,
                    ),
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

Set<Marker> _createMarkers(user_position, requesters, restaurant) {
  final positions = PositionModel.mockPositionData;

  List<Marker> requesterMarkers = _createRequesterMarkers(requesters);
  List<Marker> userMarker = _createUserMarker(user_position);
  List<Marker> restaurantMarker = _createRestaurantMarker(restaurant);

  List<Marker> markers = [];
  markers.addAll(requesterMarkers);
  markers.addAll(userMarker);
  markers.addAll(restaurantMarker);

  return markers.toSet();
}

List<Marker> _createRestaurantMarker(restaurant) {
  var markers = <Marker>[];
  List<double> location = restaurant['location'];

  markers.add(
    Marker(
      markerId: MarkerId(restaurant['name']),
      position: LatLng(
        location[0],
        location[1],
      ),
      infoWindow: InfoWindow(title: restaurant['name']),
      icon: BitmapDescriptor.defaultMarkerWithHue(
        BitmapDescriptor.hueOrange,
      ),
    ),
  );
  return markers;
}

List<Marker> _createUserMarker(user_position) {
  var markers = <Marker>[];

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

  return markers;
}

List<Marker> _createRequesterMarkers(List<Map<String, Object>> requesters) {
  var markers = <Marker>[];

  for (var i = 0; i < requesters.length; i++) {
    List<double> location = requesters[i]['location'];
    if (requesters[i]['selected'] == true) {
      final newMarker = Marker(
        markerId: MarkerId(requesters[i]['name']),
        position: LatLng(
          location[0],
          location[1],
        ),
        infoWindow: InfoWindow(title: requesters[i]['name']),
        icon: BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueOrange,
        ),
      );

      markers.add(newMarker);
    }
  }
  return markers;
}
