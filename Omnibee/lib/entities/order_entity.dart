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
  final String bigRestaurantImage;
  final String smallRestaurantImage;
  final String paymentMethodID;
  final String stripeAccountId;
  final String docID;
  final String runnerPhone;
  final String phone;
  final String deliveryIns;

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
      this.bigRestaurantImage,
      this.smallRestaurantImage,
      this.paymentMethodID,
      this.stripeAccountId,
      this.docID,
      this.runnerPhone,
      this.phone,
      this.deliveryIns);

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
      "big_restaurant_pic": bigRestaurantImage,
      "small_restaurant_pic": smallRestaurantImage,
      "paymentMethodID": paymentMethodID,
      "stripeAccountId": stripeAccountId,
      "docID": docID,
      "runnerPhone": runnerPhone,
      "phone": phone,
      "deliveryIns": deliveryIns,
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
        bigRestaurantImage,
        smallRestaurantImage,
        paymentMethodID,
        stripeAccountId,
        docID,
        runnerPhone,
        phone,
        deliveryIns,
      ];

  @override
  String toString() {
    return 'OrderEntity { name: $name, uid: $uid, user_coordinates: $userCoordinates, rest_name_used: $restaurantName, restaurant_coordinates: $restaurantCoordinates, basket: $basket, location: $location, start_time: $startTime, end_time: $endTime, expiration_time: $expirationTime, is_accepted: $isAccepted, is_delivered: $isDelivered, is_received: $isReceived, runner: $runnerUid, runner_name: $runnerName, price: $price, applicationFee: $applicationFee, minEarnings: $minEarnings, bigRestaurantImage: $bigRestaurantImage, smallRestaurantImage: $smallRestaurantImage, paymentMethodID: $paymentMethodID, stripeAccountId: $stripeAccountId, docID: $docID, runnerPhone: $runnerPhone, phone: $phone, deliveryIns: $deliveryIns }';
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
      json["big_restaurant_pic"] as String,
      json["small_restaurant_pic"] as String,
      json["paymentMethodID"] as String,
      json["stripeAccountId"] as String,
      json["docID"] as String,
      json["runnerPhone"] as String,
      json["phone"] as String,
      json["deliveryIns"] as String,
    );
  }

  static double _round(double val) {
    double mod = pow(10.0, 2);
    return ((val * mod).round().toDouble() / mod);
  }

  static Point _castToGeoPointAndReturnPoint(Object geopoint) {
    GeoPoint originalCoordinates = geopoint;
    return Point(
      originalCoordinates.latitude,
      originalCoordinates.longitude,
    );
  }

  static List<dynamic> _roundPricesTwoDecimals(List<dynamic> basket) {
    for (int i = 0; i < basket.length; i++) {
      basket[i]["price"] = _round(basket[i]["price"]);
    }
    return basket;
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
      "big_restaurant_pic": bigRestaurantImage,
      "small_restaurant_pic": smallRestaurantImage,
      "payment_method_id": paymentMethodID,
      "runner_phone": runnerPhone,
      "phone": phone,
      "deliveryIns": deliveryIns,
    };
  }

  static OrderEntity fromSnapshot(DocumentSnapshot snap) {
    return OrderEntity(
      snap.data['name'],
      snap.data['uid'],
      _castToGeoPointAndReturnPoint(
        snap.data['user_coordinates'],
      ),
      snap.data['rest_name_used'],
      _castToGeoPointAndReturnPoint(
        snap.data['restaurant_coordinates'],
      ),
      _roundPricesTwoDecimals(snap.data['basket']),
      snap.data['location'],
      snap.data['delivery_window']['start_time'],
      snap.data['delivery_window']['end_time'],
      _castToTimestampAndReturnDateTime(
        snap.data['expiration_time'],
      ),
      snap.data['is_accepted'],
      snap.data['is_delivered'],
      snap.data['is_received'],
      snap.data['runner'],
      snap.data['runner_name'],
      snap.data['price'],
      snap.data['applicationFee'],
      snap.data['min_earnings'],
      snap.data['big_restaurant_pic'],
      snap.data['small_restaurant_pic'],
      snap.data['payment_method_id'],
      snap.data['stripeAccountId'],
      snap.documentID,
      snap.data['runner_phone'],
      snap.data['phone'],
      snap.data['deliveryIns'],
    );
  }
}
