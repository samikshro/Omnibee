import 'package:Henfam/entities/entities.dart';

import 'package:meta/meta.dart';

@immutable
class User {
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

  User(
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

  User copyWith(
      {String uid,
      int boosters,
      int earnings,
      String email,
      String name,
      int points,
      int requests,
      int runs,
      String stripeAccountId,
      String token,
      bool stripeSetupComplete}) {
    return User(
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
    );
  }

  @override
  int get hashCode =>
      uid.hashCode ^
      boosters.hashCode ^
      earnings.hashCode ^
      email.hashCode ^
      name.hashCode ^
      points.hashCode ^
      requests.hashCode ^
      runs.hashCode ^
      stripeAccountId.hashCode ^
      token.hashCode ^
      stripeSetupComplete.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          uid == other.uid &&
          boosters == other.boosters &&
          earnings == other.earnings &&
          email == other.email &&
          name == other.name &&
          points == other.points &&
          requests == other.requests &&
          runs == other.runs &&
          stripeAccountId == other.stripeAccountId &&
          token == other.token &&
          stripeSetupComplete == other.stripeSetupComplete;

  @override
  String toString() {
    return 'User { uid: $uid, boosters: $boosters, earnings: $earnings, email: $email, name: $name, points: $points, requests: $requests, runs: $runs, stripeAccountId: $stripeAccountId, token: $token, stripeSetupComplete: $stripeSetupComplete }';
  }

  UserEntity toEntity() {
    return UserEntity(
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
    );
  }

  static User fromEntity(UserEntity entity) {
    return User(
      entity.uid,
      entity.boosters,
      entity.earnings,
      entity.email,
      entity.name,
      entity.points,
      entity.requests,
      entity.runs,
      entity.stripeAccountId,
      entity.token,
      entity.stripeSetupComplete,
    );
  }
}
