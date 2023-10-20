// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:homequest/Pages/AuthPages/ownerLogin.dart';
// import 'package:homequest/models/users.dart' as Users;

import 'firebaseService.dart';

class AuthService {
  late FToast fToast;

  showToast() {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.greenAccent,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check),
          SizedBox(
            width: 12.0,
          ),
          Text("This is a Custom Toast"),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2),
    );
  }

  static signupUser(String phone, String email, String password, String name,
      BuildContext context) async {
    try {
      // final user = User(email,name,phone);

      final _dbref = FirebaseDatabase.instance.ref();
      final _userRef = _dbref.child('users');

      UserCredential userCrential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      await FirebaseAuth.instance.currentUser!.updateDisplayName(name);
      await FirebaseAuth.instance.currentUser!.updateEmail(email);

      // ScaffoldMessenger.of(context)
      //     .showSnackBar(SnackBar(content: Text('Successful')));

      Fluttertoast.showToast(
          msg: "Account Created",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 16.0);

      final user = <String, dynamic>{
        'name': name,
        'email': email,
        'phone': phone,
        'uid': userCrential.user!.uid
      };

      

      _userRef.push().set(user);

      await FirestoreServices.saveUser(name, email, userCrential.user!.uid);

      FirebaseAuth.instance.signOut();

      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ownerLogin(),
          ));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Password Provided is too weak')));
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Email Provided already Exists')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  static signinUser(String email, password, BuildContext context) async {
    try {
      showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      );
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('No user Found with this Email')));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Password did not match')));
      }
    }
  }
}
