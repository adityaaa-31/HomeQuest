// import 'dart:math';
import 'package:flutter/material.dart';
import 'package:homequest/Pages/AuthPages/ownerLogin.dart';
import 'package:homequest/services/authService.dart';

class signup extends StatefulWidget {
  const signup({super.key});

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  final _formKey = GlobalKey<FormState>();

  final emailValid = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  String fullname = '';
  String email = '';
  String password = '';
  String phone = '';

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 137, 236, 150),
      body: Container(
        width: double.infinity,
        //color: Colors.black,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
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
                height: 19,
              ),
              Container(
                margin: EdgeInsets.only(left: 45, right: 45),
                child: Text(
                  "Sign Up for a new account",
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18,
                      fontWeight: FontWeight.w200),
                ),
              ),
              SizedBox(
                height: 100,
              ),
              Container(
                //color: Colors.black12,
                margin: EdgeInsets.only(left: 45, right: 45),
                child: TextFormField(
                  key: ValueKey('Name'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a valid name';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    setState(() {
                      fullname = value!;
                    });
                  },
                  // controller: emailController,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      border: UnderlineInputBorder(),
                      labelText: "Full Name"),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                //color: Colors.black12,
                margin: EdgeInsets.only(left: 45, right: 45),
                child: TextFormField(
                  // controller: passwordController,
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
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email_rounded),
                    border: UnderlineInputBorder(),
                    labelText: 'Email',
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                //color: Colors.black12,
                margin: EdgeInsets.only(left: 45, right: 45),
                child: TextFormField(
                  key: ValueKey('Password'),
                  validator: (value) {
                    if (value!.length < 6) {
                      return 'Invalid Password';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    setState(() {
                      password = value!;
                    });
                  },
                  obscureText: true,
                  // controller: confirmPasswordController,
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
                //color: Colors.black,
                margin: EdgeInsets.only(left: 45, right: 45),
      
                child: SizedBox(
                  width: 500,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        AuthService.signupUser(
                            phone, email, password, fullname, context);
                      }
                    },
                    child: Text(
                      "Sign Up",
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
                      "Already have an account?",
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
                              builder: (context) => ownerLogin(),
                            ));
                      },
                      child: Text(
                        "Log In",
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
      ),
    );
  }
}
