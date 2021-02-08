import 'package:Henfam/entities/entities.dart';

import 'package:meta/meta.dart';

@immutable
class User {
  final String uid;
  final int boosters;
  final double earnings;
  final String email;
  final String name;
  final int points;
  final int requests;
  final int runs;
  final String stripeAccountId;
  final String token;
  final bool stripeSetupComplete;
  final String phone;
  final double reimbursement;

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
    this.phone,
    this.reimbursement,
  );

  User copyWith(
      {String uid,
      int boosters,
      double earnings,
      String email,
      String name,
      int points,
      int requests,
      int runs,
      String stripeAccountId,
      String token,
      bool stripeSetupComplete,
      String phone,
      double reimbursement}) {
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
      phone,
      reimbursement,
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
      stripeSetupComplete.hashCode ^
      phone.hashCode ^
      reimbursement.hashCode;

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
          stripeSetupComplete == other.stripeSetupComplete &&
          phone == other.phone &&
          reimbursement == other.reimbursement;

  @override
  String toString() {
    return 'User { uid: $uid, boosters: $boosters, earnings: $earnings, email: $email, name: $name, points: $points, requests: $requests, runs: $runs, stripeAccountId: $stripeAccountId, token: $token, stripeSetupComplete: $stripeSetupComplete, phone: $phone, reimbursement: $reimbursement }';
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
      phone,
      reimbursement,
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
      entity.phone,
      entity.reimbursement,
    );
  }
}
