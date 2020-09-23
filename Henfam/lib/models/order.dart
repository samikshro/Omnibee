import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

@immutable
class Order {
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

  Order(
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

  Order copyWith(
      {String name,
      String uid,
      GeoPoint userCoordinates,
      String restaurantName,
      GeoPoint restaurantCoordinates,
      List<Map<dynamic, dynamic>> basket,
      String location,
      String startTime,
      String endTime,
      Timestamp expirationTime,
      bool isAccepted,
      String runnerUid,
      String restaurantImage,
      String pmID,
      String stripeAccountId,
      String docID}) {
    return Order(
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
    );
  }
}
