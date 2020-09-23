import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class OrderEntity extends Equatable {
  final String name;
  final String uid;
  final GeoPoint userCoordinates;
  final String restaurantName;
  final GeoPoint restaurantCoordinates;
  final List<Map<dynamic, dynamic>> basket;
  final String location;
  final String startTime;
  final String endTime;
  final Timestamp expirationTime;
  final bool isAccepted;
  final String runnerUid;
  final String restaurantImage;
  final String pmID;
  final String stripeAccountId;
  final String docID;

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
    this.runnerUid,
    this.restaurantImage,
    this.pmID,
    this.stripeAccountId,
    this.docID,
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
      "runner": runnerUid,
      "restaurant_pic": restaurantImage,
      "pmID": pmID,
      "stripeAccountId": stripeAccountId,
      "docID": docID,
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
        runnerUid,
        restaurantImage,
        pmID,
        stripeAccountId,
        docID,
      ];

  @override
  String toString() {
    return 'OrderEntity { name: $name, uid: $uid, user_coordinates: $userCoordinates, rest_name_used: $restaurantName, restaurant_coordinates: $restaurantCoordinates, basket: $basket, location: $location, start_time: $startTime, end_time: $endTime, expiration_time: $expirationTime, is_accepted: $isAccepted, runner: $runnerUid, restaurant_pic: $restaurantImage, pmID: $pmID, stripeAccountId: $stripeAccountId, docID: $docID }';
  }

  static OrderEntity fromJson(Map<String, Object> json) {
    return OrderEntity(
      json["name"] as String,
      json["uid"] as String,
      json["user_coordinates"] as GeoPoint,
      json["rest_name_used"] as String,
      json["restaurant_coordinates"] as GeoPoint,
      json["basket"] as List<Map<dynamic, dynamic>>,
      json["location"] as String,
      json["start_time"] as String,
      json["end_time"] as String,
      json["expiration_time"] as Timestamp,
      json["is_accepted"] as bool,
      json["runner_uid"] as String,
      json["restaurant_pic"] as String,
      json["pmID"] as String,
      json["stripeAccountId"] as String,
      json["docID"] as String,
    );
  }

  Map<String, Object> toDocument() {
    return {
      "user_id": {
        "name": name,
        "uid": uid,
        "user_coordinates": userCoordinates,
        "rest_name_used": restaurantName,
        "restaurant_coordinates": restaurantCoordinates,
        "basket": basket,
        "location": location,
        "delivery_window": {
          "start_time": startTime,
          "end_time": endTime,
        },
        "expiration_time": expirationTime,
        "is_accepted": isAccepted,
        "runner": runnerUid,
        "restaurant_pic": restaurantImage,
        "pmID": pmID,
        "stripeAccountId": stripeAccountId,
      }
    };
  }
}
