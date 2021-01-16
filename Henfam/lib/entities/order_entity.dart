import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class OrderEntity extends Equatable {
  final String name;
  final String uid;
  final Point userCoordinates;
  final String restaurantName;
  final Point restaurantCoordinates;
  final List<dynamic> basket;
  final String location;
  final String startTime;
  final String endTime;
  final DateTime expirationTime;
  final bool isAccepted;
  final bool isDelivered;
  final bool isReceived;
  final String runnerUid;
  final String runnerName;
  final double price;
  final double applicationFee;
  final double minEarnings;
  final String restaurantImage;
  final String paymentMethodID;
  final String stripeAccountId;
  final String docID;
  final String runnerPhone;
  final String phone;

  const OrderEntity(
    this.name,
    this.uid,
    this.userCoordinates,
    this.restaurantName,
    this.restaurantCoordinates,
    this.basket,
    this.location,
    this.startTime,
    this.endTime,
    this.expirationTime,
    this.isAccepted,
    this.isDelivered,
    this.isReceived,
    this.runnerUid,
    this.runnerName,
    this.price,
    this.applicationFee,
    this.minEarnings,
    this.restaurantImage,
    this.paymentMethodID,
    this.stripeAccountId,
    this.docID,
    this.runnerPhone,
    this.phone,
  );

  Map<String, Object> toJson() {
    return {
      "name": name,
      "uid": uid,
      "user_coordinates": userCoordinates,
      "rest_name_used": restaurantName,
      "restaurant_coordinates": restaurantCoordinates,
      "basket": basket,
      "location": location,
      "start_time": startTime,
      "end_time": endTime,
      "expiration_time": expirationTime,
      "is_accepted": isAccepted,
      "is_delivered": isDelivered,
      "is_received": isReceived,
      "runner": runnerUid,
      "runner_name": runnerName,
      "price": price,
      "applicationFee": applicationFee,
      "min_earnings": minEarnings,
      "restaurant_pic": restaurantImage,
      "paymentMethodID": paymentMethodID,
      "stripeAccountId": stripeAccountId,
      "docID": docID,
      "runnerPhone": runnerPhone,
      "phone": phone
    };
  }

  @override
  List<Object> get props => [
        name,
        uid,
        userCoordinates,
        restaurantName,
        restaurantCoordinates,
        basket,
        location,
        startTime,
        endTime,
        expirationTime,
        isAccepted,
        isDelivered,
        isReceived,
        runnerUid,
        runnerName,
        price,
        applicationFee,
        minEarnings,
        restaurantImage,
        paymentMethodID,
        stripeAccountId,
        docID,
        runnerPhone,
        phone,
      ];

  @override
  String toString() {
    return 'OrderEntity { name: $name, uid: $uid, user_coordinates: $userCoordinates, rest_name_used: $restaurantName, restaurant_coordinates: $restaurantCoordinates, basket: $basket, location: $location, start_time: $startTime, end_time: $endTime, expiration_time: $expirationTime, is_accepted: $isAccepted, is_delivered: $isDelivered, is_received: $isReceived, runner: $runnerUid, runner_name: $runnerName, price: $price, applicationFee: $applicationFee, minEarnings: $minEarnings, restaurant_pic: $restaurantImage, paymentMethodID: $paymentMethodID, stripeAccountId: $stripeAccountId, docID: $docID, runnerPhone: $runnerPhone, phone: $phone }';
  }

  static OrderEntity fromJson(Map<String, Object> json) {
    return OrderEntity(
      json["name"] as String,
      json["uid"] as String,
      _castToGeoPointAndReturnPoint(json['user_coordinates']),
      json["rest_name_used"] as String,
      _castToGeoPointAndReturnPoint(json['restaurant_coordinates']),
      json["basket"] as List<Map<dynamic, dynamic>>,
      json["location"] as String,
      json["start_time"] as String,
      json["end_time"] as String,
      _castToTimestampAndReturnDateTime(json['expiration_time']),
      json["is_accepted"] as bool,
      json["is_delivered"] as bool,
      json["is_received"] as bool,
      json["runner_uid"] as String,
      json["runner_name"] as String,
      json["price"] as double,
      json["applicationFee"] as double,
      json["min_earnings"] as double,
      json["restaurant_pic"] as String,
      json["paymentMethodID"] as String,
      json["stripeAccountId"] as String,
      json["docID"] as String,
      json["runnerPhone"] as String,
      json["phone"] as String,
    );
  }

  static Point _castToGeoPointAndReturnPoint(Object geopoint) {
    GeoPoint originalCoordinates = geopoint;
    return Point(
      originalCoordinates.latitude,
      originalCoordinates.longitude,
    );
  }

  static DateTime _castToTimestampAndReturnDateTime(Object timestamp) {
    Timestamp expirationTime = timestamp;
    return DateTime.fromMillisecondsSinceEpoch(
      expirationTime.millisecondsSinceEpoch,
    );
  }

  Map<String, Object> toDocument() {
    return {
      "stripeAccountId": stripeAccountId,
      "is_delivered": isDelivered,
      "is_received": isReceived,
      "user_id": {
        "name": name,
        "uid": uid,
        "user_coordinates": GeoPoint(userCoordinates.x, userCoordinates.y),
        "rest_name_used": restaurantName,
        "restaurant_coordinates": GeoPoint(
          restaurantCoordinates.x,
          restaurantCoordinates.y,
        ),
        "basket": basket,
        "location": location,
        "delivery_window": {
          "start_time": startTime,
          "end_time": endTime,
        },
        "expiration_time": Timestamp.fromMillisecondsSinceEpoch(
          expirationTime.millisecondsSinceEpoch,
        ),
        "is_accepted": isAccepted,
        "runner": runnerUid,
        "runner_name": runnerName,
        "price": price,
        "applicationFee": applicationFee,
        "min_earnings": minEarnings,
        "restaurant_pic": restaurantImage,
        "payment_method_id": paymentMethodID,
        "runner_phone": runnerPhone,
        "phone": phone,
      }
    };
  }

  static OrderEntity fromSnapshot(DocumentSnapshot snap) {
    return OrderEntity(
      snap.data['user_id']['name'],
      snap.data['user_id']['uid'],
      _castToGeoPointAndReturnPoint(
        snap.data['user_id']['user_coordinates'],
      ),
      snap.data['user_id']['rest_name_used'],
      _castToGeoPointAndReturnPoint(
        snap.data['user_id']['restaurant_coordinates'],
      ),
      snap.data['user_id']['basket'],
      snap.data['user_id']['location'],
      snap.data['user_id']['delivery_window']['start_time'],
      snap.data['user_id']['delivery_window']['end_time'],
      _castToTimestampAndReturnDateTime(
        snap.data['user_id']['expiration_time'],
      ),
      snap.data['user_id']['is_accepted'],
      snap.data['is_delivered'],
      snap.data['is_received'],
      snap.data['user_id']['runner'],
      snap.data['user_id']['runner_name'],
      snap.data['user_id']['price'],
      snap.data['user_id']['applicationFee'],
      snap.data['user_id']['min_earnings'],
      snap.data['user_id']['restaurant_pic'],
      snap.data['user_id']['payment_method_id'],
      snap.data['stripeAccountId'],
      snap.documentID,
      snap.data['user_id']['runner_phone'],
      snap.data['user_id']['phone'],
    );
  }
}
