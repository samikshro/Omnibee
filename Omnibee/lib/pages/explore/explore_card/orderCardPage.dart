import 'dart:async';
import 'package:Omnibee/bloc/location/location_bloc.dart';
import 'package:Omnibee/models/order.dart';
import 'package:Omnibee/pages/explore/explore_card/widgets/callPhoneNumber.dart';
import 'package:Omnibee/pages/explore/explore_card/widgets/deliveryInstructions.dart';
import 'package:Omnibee/pages/explore/explore_card/widgets/deliveryInfo.dart';
import 'package:Omnibee/pages/explore/explore_card/widgets/displayItems.dart';
import 'package:Omnibee/services/paymentService.dart';
import 'package:Omnibee/widgets/mediumTextSection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Omnibee/bloc/blocs.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';

class OrderCardPage extends StatefulWidget {
  @override
  _OrderCardPageState createState() => _OrderCardPageState();
}

class _OrderCardPageState extends State<OrderCardPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  double fontSize = 19;
  double boldFontSize = 22;
  Completer<GoogleMapController> mapController = Completer();

  Widget _getOrderInformation(Order order) {
    double subtotal =
        order.getSubtotal(); //TODO ss: fix to get 2 decimal places
    return Padding(
      padding: const EdgeInsets.only(left: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Items:',
            style:
                TextStyle(fontWeight: FontWeight.bold, fontSize: boldFontSize),
          ),
          DisplayItems(order, fontSize),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text("Subtotal: \$$subtotal",
                style: TextStyle(fontSize: fontSize)),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(
                "Total Fees: \$" +
                    PaymentService.getTotalFees(subtotal).toStringAsFixed(2),
                style: TextStyle(fontSize: fontSize)),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(
                "Tax: \$" +
                    (PaymentService.getTaxedPrice(subtotal) - subtotal)
                        .toStringAsFixed(2),
                style: TextStyle(fontSize: fontSize)),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(
                "Total: \$" +
                    PaymentService.getPCharge(subtotal).toStringAsFixed(2),
                style: TextStyle(fontSize: fontSize)),
          ),
        ],
      ),
    );
  }

  Widget _controlButtons(Order order, BuildContext context) {
    if (order.isDelivered == true || order.isAccepted) {
      return Container();
    } else {
      return Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Center(
          child: CupertinoButton(
            color: Theme.of(context).primaryColor,
            child: Text(
              "Cancel Order",
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.normal,
              ),
            ),
            onPressed: () {
              BlocProvider.of<OrderBloc>(context).add(OrderDeleted(order));

              final snackBar = SnackBar(
                content: Text('Order successfully cancelled!'),
              );
              _scaffoldKey.currentState.showSnackBar(snackBar);
              Timer(Duration(seconds: 2), () {
                Navigator.pop(context);
              });
            },
          ),
        ),
      );
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController.complete(controller);
    // mapController = controller;
  }

  Widget _map(Order order, BuildContext context) {
    //BlocProvider.of<LocationBloc>(context).add(LocationChanged(position: position));
    LatLng _center =
        const LatLng(50.450324, -70.492587); // get position from locationBloc
    return SizedBox(
      width: MediaQuery.of(context).size.width, // or use fixed size like 200
      height: 400,
      child: GoogleMap(
        onMapCreated: _onMapCreated,
        gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
          Factory<OneSequenceGestureRecognizer>(() => EagerGestureRecognizer())
        ].toSet(),
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 17,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final int isDeliveryPage = 0;
    final Order order = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Order'),
      ),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.only(bottom: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            MediumTextSection("Delivery Information"),
            _map(order, context),
            if (!order.isExpired() &&
                order.isAccepted) //TODO: test these conditions
              CallPhoneNumber(order, fontSize, false),
            DeliveryInfo(order, fontSize, boldFontSize, isDeliveryPage, false),
            DeliveryInstructions(order, fontSize, boldFontSize),
            MediumTextSection("Order Information"),
            _getOrderInformation(order),
            _controlButtons(order, context),
          ],
        ),
      ),
    );
  }
}
