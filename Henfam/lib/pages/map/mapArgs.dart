import 'package:Henfam/pages/map/positionModel.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapArgs {
  Set<Marker> markers;
  PositionModel center;

  MapArgs(this.markers, this.center);
}
