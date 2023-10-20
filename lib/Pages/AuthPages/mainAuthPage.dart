import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:homequest/Pages/AuthPages/ownerLogin.dart';
import 'package:homequest/Pages/HomePages/buyerHomePage.dart';

class mainAuthPage extends StatelessWidget {
  const mainAuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return buyerHome();
          }else{
            return ownerLogin();
          }
        },
      ),
    );
    
  }
}
