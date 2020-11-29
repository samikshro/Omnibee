import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String uid;
  final int boosters;
  final int earnings;
  final String email;
  final String name;
  final int points;
  final int requests;
  final int runs;
  final String stripeAccountId;
  final String token;
  final bool stripeSetupComplete;

  const UserEntity(
    this.uid,
    this.boosters,
    this.earnings,
    this.email,
    this.name,
    this.points,
    this.requests,
    this.runs,
    this.stripeAccountId,
    this.token,
    this.stripeSetupComplete,
  );

  Map<String, Object> toJson() {
    return {
      "uid": uid,
      "boosters": boosters,
      "earnings": earnings,
      "email": email,
      "name": name,
      "points": points,
      "requests": requests,
      "runs": runs,
      "stripeAccountId": stripeAccountId,
      "token": token,
      "stripeSetupComplete": stripeSetupComplete,
    };
  }

  @override
  List<Object> get props => [
        uid,
        boosters,
        earnings,
        email,
        name,
        points,
        requests,
        runs,
        stripeAccountId,
        token,
        stripeSetupComplete,
      ];

  @override
  String toString() {
    return 'UserEntity { uid: $uid, boosters: $boosters, earnings: $earnings, email: $email, name: $name, points: $points, requests: $requests, runs: $runs, stripeAccountId: $stripeAccountId, token: $token, stripeSetupComplete: $stripeSetupComplete }';
  }

  static UserEntity fromJson(Map<String, Object> json) {
    return UserEntity(
      json["uid"] as String,
      json["boosters"] as int,
      json["earnings"] as int,
      json["email"] as String,
      json["name"] as String,
      json["points"] as int,
      json["requests"] as int,
      json["runs"] as int,
      json["stripeAccountId"] as String,
      json["token"] as String,
      json["stripeSetupComplete"] as bool,
    );
  }

  Map<String, Object> toDocument() {
    return {
      "boosters": boosters,
      "earnings": earnings,
      "email": email,
      "name": name,
      "points": points,
      "requests": requests,
      "runs": runs,
      "stripeAccountId": stripeAccountId,
      "token": token,
      "stripeSetupComplete": stripeSetupComplete,
    };
  }

  static UserEntity fromSnapshot(DocumentSnapshot snap) {
    return UserEntity(
      snap.documentID,
      snap.data["boosters"],
      snap.data["earnings"],
      snap.data["email"],
      snap.data["name"],
      snap.data["points"],
      snap.data["requests"],
      snap.data["runs"],
      snap.data["stripeAccountId"],
      snap.data["token"],
      snap.data["stripeSetupComplete"],
    );
  }
}
