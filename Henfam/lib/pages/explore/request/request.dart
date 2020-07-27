import 'package:Henfam/pages/explore/request/widgets/deliveryOptions.dart';
import 'package:Henfam/pages/explore/request/widgets/locationDetails.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Henfam/pages/explore/request/requestConfirm.dart';
import 'package:Henfam/pages/explore/menu/basketForm.dart';
import 'package:Henfam/auth/authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';

class Request extends StatefulWidget {
  BaseAuth auth = new Auth();
  @override
  _RequestState createState() => _RequestState();
}

class _RequestState extends State<Request> {
  var _deliveryDate = DateTime.now();
  var _deliveryRange = DateTime(0, 0, 0, 0, 30);
  String _location = '';
  Position _locationCoordinates = Position();

  void _setDeliveryDate(DateTime _newDate) {
    setState(() {
      _deliveryDate = _newDate;
    });
  }

  void _setDeliveryRange(DateTime _newRange) {
    setState(() {
      _deliveryRange = _newRange;
    });
  }

  void _setLocation(String loc, Position locationCoords) {
    setState(() {
      _location = loc;
      _locationCoordinates = locationCoords;
    });
  }

  Future<String> _getUserID() async {
    final result = await widget.auth.getCurrentUser();
    return result.uid;
  }

  // why is this hardcoded...?
  Future<String> _getUserName(String uid) async {
    Future<String> s = Firestore.instance
        .collection('users')
        .document(uid)
        .get()
        .then((DocumentSnapshot document) {
      return document['name'];
    });
    return s;
  }

  @override
  Widget build(BuildContext context) {
    final BasketData args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your Order',
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
                      DeliveryOptions(_setDeliveryDate, _setDeliveryRange),
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
                        'Submit Order',
                        style: TextStyle(
                            fontSize: 20.0,
                            color: Theme.of(context).scaffoldBackgroundColor),
                      ),
                      onPressed: () {
                        _getUserID().then((String s) {
                          _getUserName(s).then((String name) {
                            showCupertinoModalPopup(
                              context: context,
                              builder: (context) => RequestConfirm(
                                _deliveryDate,
                                _deliveryRange,
                                args,
                                s,
                                _location,
                                _locationCoordinates,
                                name,
                              ),
                            );
                          });
                        });
                      }),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
