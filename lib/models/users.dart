import 'package:cloud_firestore/cloud_firestore.dart';

class HomeUser {
  String? uid;
  String? email;
  String? fullName;
  String? phone;

  HomeUser({this.uid, this.email, this.fullName, this.phone});

  factory HomeUser.fromSnapshot(DocumentSnapshot snapshot) {
    return HomeUser(
        uid: snapshot.get("uid") as String,
        fullName: snapshot.get('fullname') as String,
        phone: snapshot.get('phone') as String,
        email: snapshot.get('email') as String);
  }
}
