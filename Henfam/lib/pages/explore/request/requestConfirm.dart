import 'dart:math';

import 'package:Henfam/bloc/blocs.dart';
import 'package:Henfam/models/order.dart';
import 'package:Henfam/pages/explore/menu/menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RequestConfirm extends StatelessWidget {
  final date;
  final endDate;
  final uid;
  final String loc;
  final Position locCoords;
  final String name;
  final String pmID;

  RequestConfirm(this.date, this.endDate, this.uid, this.loc, this.locCoords,
      this.name, this.pmID);

  final firestoreInstance = Firestore.instance;

  String getDay(DateTime date) {
    final today = DateTime.now();
    return (today.day == date.day) ? "Today" : "Tomorrow";
  }

  List<String> _getTimeInfo(DateTime date, DateTime endDate) {
    var difference = endDate.difference(date);
    final expirationInterval = Duration(minutes: difference.inMinutes - 20);
    final expirationDate = date.add(expirationInterval);

    final formatter = DateFormat.jm();
    final startTime = formatter.format(date);
    final endTime = formatter.format(endDate);
    final expirationTime = formatter.format(expirationDate);
    List<String> lst = [];
    lst.add(startTime);
    lst.add(endTime);
    lst.add(expirationTime);
    return lst;
  }

  DateTime _getExpirationDate(DateTime date, DateTime endDate) {
    var difference = endDate.difference(date);
    final expirationInterval = Duration(minutes: difference.inMinutes - 20);
    final expirationDate = date.add(expirationInterval);
    return expirationDate;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BasketBloc, BasketState>(builder: (context, state1) {
      return BlocBuilder<RestaurantBloc, RestaurantState>(
          builder: (context, state2) {
        return (state1 is BasketLoadSuccess)
            ? ((state2 is RestaurantLoadSuccess)
                ? CupertinoActionSheet(
                    title: Text("Do you want to submit this order?",
                        style: TextStyle(fontSize: 22.0)),
                    message: Text(
                        "Delivery Window: " +
                            _getTimeInfo(date, endDate)[0] +
                            " - " +
                            _getTimeInfo(date, endDate)[1] +
                            ". Your order will EXPIRE at " +
                            _getTimeInfo(date, endDate)[2],
                        style: TextStyle(fontSize: 20.0)),
                    actions: <Widget>[
                      CupertinoActionSheetAction(
                        child: Text("Confirm"),
                        isDefaultAction: true,
                        onPressed: () {
                          BlocProvider.of<BasketBloc>(context)
                              .add(BasketReset());

                          BlocProvider.of<OrderBloc>(context).add(
                            OrderAdded(
                              Order(
                                name,
                                uid,
                                Point(locCoords.latitude, locCoords.longitude),
                                state2.restaurant.name,
                                Point(
                                  state2.restaurant.location[0],
                                  state2.restaurant.location[1],
                                ),
                                state1.jsonEncoding,
                                loc,
                                _getTimeInfo(date, endDate)[0],
                                _getTimeInfo(date, endDate)[1],
                                _getExpirationDate(date, endDate),
                                false,
                                false,
                                false,
                                null,
                                null,
                                state1.getPrice(),
                                state1.getOmnibeeFee(),
                                state1.getMinEarnings(),
                                state2.restaurant.bigImagePath,
                                pmID,
                                null,
                                null,
                              ),
                            ),
                          );
                          Menu.order = []; //clears order after submitting
                          Menu.onPressed =
                              () {}; //clears onPressed fcn after submitting
                          Navigator.popUntil(context,
                              ModalRoute.withName(Navigator.defaultRouteName));
                        },
                      ),
                    ],
                    cancelButton: CupertinoActionSheetAction(
                      child: Text("Cancel"),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  )
                : Container())
            : Container();
      });
    });
  }
}
