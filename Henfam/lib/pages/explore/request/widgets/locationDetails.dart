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

  static final kGoogleApiKey = "AIzaSyDt39wypJeJDVQ82elS6Em94rJvR8Km58c";

  @override
  _LocationDetailsState createState() => _LocationDetailsState();
}

class _LocationDetailsState extends State<LocationDetails> {
  final kGoogleApiKey = "AIzaSyDt39wypJeJDVQ82elS6Em94rJvR8Km58c";
  String findAddressText = "Find address";

  GoogleMapsPlaces _places =
      GoogleMapsPlaces(apiKey: LocationDetails.kGoogleApiKey);

  Future<Null> updateLocation(Prediction p) async {
    if (p != null) {
      PlacesDetailsResponse detail =
          await _places.getDetailsByPlaceId(p.placeId);

      double lat = detail.result.geometry.location.lat;
      double lng = detail.result.geometry.location.lng;

      widget.setLocation(
        p.description,
        Position(latitude: lat, longitude: lng),
      );
    }
  }

  _updateButtonText(String loc) {
    findAddressText = "Found location: " + loc;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        MediumTextSection('Location Details'),
        Divider(),
        MiniHeader('Building / Place Name'),
        Padding(
          padding: const EdgeInsets.fromLTRB(26, 8, 10, 8),
          child: CupertinoButton(
            color: Theme.of(context).primaryColor,
            onPressed: () async {
              Prediction p = await PlacesAutocomplete.show(
                context: context,
                apiKey: kGoogleApiKey,
              );
              updateLocation(p);
              _updateButtonText(p.description);
            },
            child: Text(findAddressText),
          ),
        ),
        MiniHeader('Instructions for delivery'),
        Container(
          margin: EdgeInsets.all(15),
          child: TextField(
            maxLines: 3,
            decoration: InputDecoration(
              hintText: "e.g. Leave next to couch outside map room.",
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
    );
  }
}
