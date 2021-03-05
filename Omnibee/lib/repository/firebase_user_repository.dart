import 'dart:async';
import 'package:Omnibee/services/paymentService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'repositories.dart';
import 'package:Omnibee/models/models.dart';
import 'package:Omnibee/entities/entities.dart';

class FirebaseUserRepository implements UserRepository {
  final FirebaseAuth _firebaseAuth;
  final userCollection = Firestore.instance.collection('users');

  FirebaseUserRepository({FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  @override
  Future<bool> isAuthenticated() async {
    final currentUser = await _firebaseAuth.currentUser();
    return currentUser != null;
  }

  @override
  Future<User> signIn(String email, String password) async {
    try {
      AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser fUser = result.user;
      User user = await userCollection
          .document(fUser.uid)
          .get()
          .then((DocumentSnapshot document) {
        return User.fromEntity(UserEntity.fromSnapshot(document));
      });
      return user;
    } catch (e) {}
  }

  @override
  Future<List<String>> signUp(
      String name, String email, String password, String phone) async {
    AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    FirebaseUser user = result.user;

    userCollection.document(user.uid).setData({
      'name': name,
      'email': email,
      'runs': 0,
      'requests': 0,
      'boosters': 0,
      'earnings': 0.0,
      'points': 0,
      'stripe_setup_complete': false,
      'stripeAccountId': "",
      'phone': phone,
      'token': "",
      "reimbursement": 0.00,
    });

    return [email, password];
  }

  @override
  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  @override
  Future<void> incrementEarnings(User user, double newEarnings) async {
    double currentEarnings = user.earnings + newEarnings;

    double balance =
        await PaymentService.retrieveAccountBalance(user.stripeAccountId)
            .then((response) {
      double balance = 0;
      List<dynamic> z = response.data["pending"] as List<dynamic>;
      for (int i = 0; i < z.length; i++) {
        balance += z[i]["amount"];
      }
      return balance / 100;
    });
    return userCollection
        .document(user.uid)
        .updateData({'earnings': currentEarnings, 'reimbursement': balance});
  }

  @override
  Future<String> getUserId() async {
    return (await _firebaseAuth.currentUser()).uid;
  }

  @override
  Future<User> getUser() async {
    String uid = await getUserId();
    User user = await userCollection
        .document(uid)
        .get()
        .then((DocumentSnapshot document) {
      return User.fromEntity(UserEntity.fromSnapshot(document));
    });
    return user;
  }

  @override
  Future<User> getUserWUID(String uid) async {
    User user = await userCollection
        .document(uid)
        .get()
        .then((DocumentSnapshot document) {
      return User.fromEntity(UserEntity.fromSnapshot(document));
    });
    return user;
  }

  @override
  Future<void> sendEmailVerification() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    user.sendEmailVerification();
  }

  @override
  Future<bool> isEmailVerified() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user.isEmailVerified;
  }

  @override
  Stream<User> user(String uid) {
    print("BUILDING USER STREAM");
    return userCollection
        .document(uid)
        .snapshots()
        .map((doc) => User.fromEntity(UserEntity.fromSnapshot(doc)));
  }
}
