import 'package:Henfam/widgets/miniHeader.dart';
import 'package:Henfam/widgets/mediumTextSection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_webservice/places.dart';

class LocationDetails extends StatefulWidget {
  final Function setLocation;

  LocationDetails(this.setLocation);

  static final kGoogleApiKey = "AIzaSyB7KROHRO-PGbEc6EOnsBU2rsNIfxVNU1o";

  @override
  _LocationDetailsState createState() => _LocationDetailsState();
}

class _LocationDetailsState extends State<LocationDetails> {
  final kGoogleApiKey = "AIzaSyB7KROHRO-PGbEc6EOnsBU2rsNIfxVNU1o";
  String findAddressText = "Find address";
  bool _isDisposed = false;

  GoogleMapsPlaces _places =
      GoogleMapsPlaces(apiKey: LocationDetails.kGoogleApiKey);

  Future<Null> updateLocation(Prediction p) async {
    PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(p.placeId);

    double lat = detail.result.geometry.location.lat;
    double lng = detail.result.geometry.location.lng;

    widget.setLocation(
      p.description,
      Position(latitude: lat, longitude: lng),
    );
  }

  _updateButtonText(String loc) {
    findAddressText = "Found location: " + loc;
  }

  @override
  void dispose() {
    super.dispose();
    _isDisposed = true;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          MediumTextSection('Drop-off Location'),
          Text('Where will you be located?'),
          Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: MiniHeader('Building / Place Name'),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(26, 8, 10, 8),
            child: CupertinoButton(
              color: Theme.of(context).primaryColor,
              onPressed: () async {
                Prediction p = await PlacesAutocomplete.show(
                  context: context,
                  apiKey: kGoogleApiKey,
                );
                if (p != null && !_isDisposed) {
                  updateLocation(p);
                  _updateButtonText(p.description);
                }
              },
              child: Text(findAddressText),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: MiniHeader('Instructions for delivery'),
          ),
          Container(
            margin: EdgeInsets.all(15),
            child: TextFormField(
              textInputAction: TextInputAction.done,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: "e.g. Apt 4G, Leave next to door outside.",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: BorderSide(
                    style: BorderStyle.solid,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
