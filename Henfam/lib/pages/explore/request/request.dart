import 'package:Henfam/bloc/blocs.dart';
import 'package:Henfam/pages/explore/request/widgets/deliveryOptions.dart';
import 'package:Henfam/pages/explore/request/widgets/locationDetails.dart';
import 'package:Henfam/services/paymentService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Henfam/pages/explore/request/requestConfirm.dart';
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
  bool _placeOrderDisabled = true;
  Position _locationCoordinates = Position();

  void _setDeliveryDate(DateTime _newDate) {
    setState(() {
      _deliveryDate = _newDate;
    });
  }

  void _setEndDeliveryDate(DateTime _newDate) {
    setState(() {
      _endDeliveryDate = _newDate;
    });
  }

  void _setLocation(String loc, Position locationCoords) {
    setState(() {
      _location = loc;
      _locationCoordinates = locationCoords;
      _placeOrderDisabled = false;
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
                        LocationDetails(_setLocation),
                        // PaymentSection(),
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
                          if (!_placeOrderDisabled) {
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
                                ),
                              );
                            });
                          } else {
                            return null;
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
