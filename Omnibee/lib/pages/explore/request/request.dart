import 'package:Omnibee/bloc/blocs.dart';
import 'package:Omnibee/pages/explore/request/widgets/deliveryOptions.dart';
import 'package:Omnibee/pages/explore/request/widgets/locationDetails.dart';
import 'package:Omnibee/services/paymentService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Omnibee/pages/explore/request/requestConfirm.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

class Request extends StatefulWidget {
  @override
  _RequestState createState() => _RequestState();
}

class _RequestState extends State<Request> {
  var _deliveryDate = DateTime.now();
  var _endDeliveryDate = DateTime.now().add(new Duration(hours: 1));
  String _location = '';
  String _deliveryIns = '';
  final _formKey = GlobalKey<FormState>();

  Map<String, bool> infoAdded = {
    'location': false,
    'deliveryDate': false,
    'endDeliveryDate': false
  };

  Position _locationCoordinates = Position();

  void _setDeliveryDate(DateTime _newDate) {
    setState(() {
      _deliveryDate = _newDate;
      infoAdded['deliveryDate'] = true;
    });
  }

  void _setEndDeliveryDate(DateTime _newDate) {
    setState(() {
      _endDeliveryDate = _newDate;
      infoAdded['endDeliveryDate'] = true;
    });
  }

  void _setLocation(String loc, Position locationCoords) {
    setState(() {
      _location = loc;
      _locationCoordinates = locationCoords;
      infoAdded['location'] = true;
    });
  }

  void _setDeliveryIns(String deliveryIns) {
    setState(() {
      _deliveryIns = deliveryIns;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'Your Request',
          ),
        ),
        body: SafeArea(
          child: CustomScrollView(
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Column(
                      children: <Widget>[
                        DeliveryOptions(_setDeliveryDate, _setEndDeliveryDate),
                        LocationDetails(
                          _setLocation,
                          _setDeliveryIns,
                          _formKey,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                fillOverscroll: true,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: RaisedButton(
                        child: Text(
                          'Place Request',
                          style: TextStyle(
                              fontSize: 20.0,
                              color: Theme.of(context).scaffoldBackgroundColor),
                        ),
                        onPressed: () {
                          _formKey.currentState.save();
                          if (infoAdded.containsValue(false)) {
                            //TODO: make this look better
                            showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return Column(children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 10),
                                      child: Text(
                                          'Please fill out the delivery time range and location fields!',
                                          style: TextStyle(fontSize: 18)),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 10),
                                    ),
                                    CupertinoButton(
                                        color: Theme.of(context).primaryColor,
                                        child: Text("Close"),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        }),
                                  ]);
                                });
                          } else {
                            PaymentService.paymentRequestWithCardForm()
                                .then((paymentMethod) {
                              showCupertinoModalPopup(
                                context: context,
                                builder: (context) => RequestConfirm(
                                  _deliveryDate,
                                  _endDeliveryDate,
                                  (state as Authenticated).user.uid,
                                  _location,
                                  _locationCoordinates,
                                  (state as Authenticated).user.name,
                                  paymentMethod.id,
                                  _deliveryIns,
                                ),
                              );
                            });
                          }
                        }),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
