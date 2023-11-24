import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';

class FirestoreServices {
  static saveUser(String name, email, uid, phone) async {
    await FirebaseFirestore.instance
        .collection('users')
        .add({'uid': uid, 'fullname': name, 'email': email, 'phone': phone});
  }
}
