import 'dart:math';
import 'package:Henfam/entities/entities.dart';

import 'package:meta/meta.dart';

@immutable
class Order {
  final String name;
  final String uid;
  final Point userCoordinates;
  final String restaurantName;
  final Point restaurantCoordinates;
  final List<Map<dynamic, dynamic>> basket;
  final String location;
  final String startTime;
  final String endTime;
  final DateTime expirationTime;
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
      Point userCoordinates,
      String restaurantName,
      Point restaurantCoordinates,
      List<Map<dynamic, dynamic>> basket,
      String location,
      String startTime,
      String endTime,
      DateTime expirationTime,
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

  @override
  int get hashCode =>
      name.hashCode ^
      uid.hashCode ^
      userCoordinates.hashCode ^
      restaurantName.hashCode ^
      restaurantCoordinates.hashCode ^
      basket.hashCode ^
      location.hashCode ^
      startTime.hashCode ^
      endTime.hashCode ^
      expirationTime.hashCode ^
      isAccepted.hashCode ^
      runnerUid.hashCode ^
      restaurantImage.hashCode ^
      pmID.hashCode ^
      stripeAccountId.hashCode ^
      docID.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Order &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          uid == other.uid &&
          userCoordinates == other.userCoordinates &&
          restaurantName == other.restaurantName &&
          restaurantCoordinates == other.restaurantCoordinates &&
          basket == other.basket &&
          location == other.location &&
          startTime == other.startTime &&
          endTime == other.endTime &&
          expirationTime == other.expirationTime &&
          isAccepted == other.isAccepted &&
          runnerUid == other.runnerUid &&
          restaurantImage == other.restaurantImage &&
          pmID == other.pmID &&
          stripeAccountId == other.stripeAccountId &&
          docID == other.docID;

  @override
  String toString() {
    return 'Order { name: $name, uid: $uid, userCoordinates: $userCoordinates, restaurantName: $restaurantName, restaurantCoordinates: $restaurantCoordinates, basket: $basket, location: $location, startTime: $startTime, endTime: $endTime, expirationTime: $expirationTime, isAccepted: $isAccepted, runner: $runnerUid, restaurantImage: $restaurantImage, pmID: $pmID, stripeAccountId: $stripeAccountId, docID: $docID }';
  }

  OrderEntity toEntity() {
    return OrderEntity(
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

  static Order fromEntity(OrderEntity entity) {
    // TODO: CREATE BASKET MODEL
    return Order(
      entity.name,
      entity.uid,
      entity.userCoordinates,
      entity.restaurantName,
      entity.restaurantCoordinates,
      entity.basket,
      entity.location,
      entity.startTime,
      entity.endTime,
      entity.expirationTime,
      entity.isAccepted,
      entity.runnerUid,
      entity.restaurantImage,
      entity.pmID,
      entity.stripeAccountId,
      entity.docID,
    );
  }
}
