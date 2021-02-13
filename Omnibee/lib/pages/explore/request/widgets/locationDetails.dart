import 'package:Omnibee/widgets/infoButton.dart';
import 'package:Omnibee/widgets/miniHeader.dart';
import 'package:Omnibee/widgets/mediumTextSection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_webservice/places.dart';

class LocationDetails extends StatefulWidget {
  final Function setLocation;
  final Function setDeliveryIns;
  final GlobalKey formKey;

  LocationDetails(
    this.setLocation,
    this.setDeliveryIns,
    this.formKey,
  );

  static final kGoogleApiKey = "AIzaSyB7KROHRO-PGbEc6EOnsBU2rsNIfxVNU1o";

  @override
  _LocationDetailsState createState() => _LocationDetailsState();
}

class _LocationDetailsState extends State<LocationDetails> {
  final kGoogleApiKey = "AIzaSyB7KROHRO-PGbEc6EOnsBU2rsNIfxVNU1o";
  String findAddressText = "Find address";
  bool _isDisposed = false;
  final myController = TextEditingController();

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
    myController.dispose();

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
          Row(
            children: [
              SizedBox(
                width: 240,
                child: MediumTextSection('Drop-off Location'),
              ),
              InfoButton(
                titleMessage: "Drop-off Location",
                bodyMessage:
                    "Choose where you want the food to be dropped off.",
                buttonMessage: "Okay",
                buttonSize: 25,
              ),
            ],
          ),
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
            child: Form(
              key: widget.formKey,
              child: TextFormField(
                maxLines: 3,
                autofocus: false,
                /* controller: myController,
                key: widget.formKey, */
                onSaved: (deliveryIns) {
                  print("\n\n DELIVERY INS are $deliveryIns");
                  widget.setDeliveryIns(deliveryIns);
                },
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
          ),
        ],
      ),
    );
  }
}
