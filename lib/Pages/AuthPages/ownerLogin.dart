import 'package:carousel_slider/carousel_slider.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:homequest/Pages/AuthPages/signupPage.dart';
import 'package:homequest/services/authService.dart';
// import 'package:homequest/Pages/HomePages/buyerHomePage.dart';

// ignore: must_be_immutable
class ownerLogin extends StatefulWidget {
  ownerLogin({super.key});

  @override
  State<ownerLogin> createState() => _ownerLoginState();
}

class _ownerLoginState extends State<ownerLogin> {
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';

  CarouselController buttonCarouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    // final _formKey = GlobalKey<_ownerLoginState>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              // color: Colors.black,
              width: 700,
              margin: EdgeInsets.only(left: 90, right: 90),
              child: Text(
                "HomeQuest",
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(left: 80, right: 90),
              child: Text(
                "Log into your account",
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 20,
                    fontWeight: FontWeight.w200),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              //=========Email=========
              //color: Colors.black12,
              margin: EdgeInsets.only(left: 50, right: 50),
              child: TextFormField(
                key: ValueKey('Email'),
                validator: (value) {
                  if (value!.isEmpty || !value.contains('@')) {
                    return 'Please enter a valid email';
                  } else {
                    return null;
                  }
                },
                onSaved: (value) {
                  setState(() {
                    email = value!;
                  });
                },
                // controller: email,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email_rounded),
                    border: UnderlineInputBorder(),
                    labelText: "Email"),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              //=========Password=========
              //color: Colors.black12,
              margin: EdgeInsets.only(left: 50, right: 50),
              child: TextFormField(
                key: ValueKey('Password'),
                validator: (value) {
                  if (value!.length < 6) {
                    return 'Invalid Password';
                  }
                },
                onSaved: (value) {
                  setState(() {
                    password = value!;
                  });
                },
                obscureText: true,
                // controller: password,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.lock_rounded),
                  border: UnderlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              //==========Submit===========
              //color: Colors.black,
              margin: EdgeInsets.only(left: 45, right: 45),

              child: SizedBox(
                width: 600,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      AuthService.signinUser(email, password, context);
                    }
                  },
                  child: Text(
                    "Log In",
                    style: TextStyle(fontFamily: 'Poppins'),
                  ),
                  style: ElevatedButton.styleFrom(
                    elevation: 10,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 35,
            ),
            Container(
              margin: EdgeInsets.only(left: 110, right: 80),
              child: Row(
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        fontWeight: FontWeight.w200),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => signup(),
                          ));
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
