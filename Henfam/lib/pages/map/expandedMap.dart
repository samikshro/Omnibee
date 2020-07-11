import 'package:Henfam/pages/map/mapArgs.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ExpandedMap extends StatefulWidget {
  @override
  _ExpandedMapState createState() => _ExpandedMapState();
}

class _ExpandedMapState extends State<ExpandedMap> {
  GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    final MapArgs args = ModalRoute.of(context).settings.arguments;
    return Hero(
      tag: 'map',
      child: GoogleMap(
        myLocationButtonEnabled: false,
        onMapCreated: _onMapCreated,
        markers: args.markers,
        initialCameraPosition: CameraPosition(
          target: LatLng(args.center.latitude, args.center.longitude),
          zoom: 14,
        ),
      ),
    );
  }
}
