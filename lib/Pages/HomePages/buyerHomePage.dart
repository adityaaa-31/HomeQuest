import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:homequest/Pages/HomePages/HomePage.dart';
import 'package:homequest/Pages/HomePages/addListing.dart';
import 'package:homequest/Pages/HomePages/profilepage.dart';
import 'package:homequest/Pages/HomePages/savedListing.dart';

class buyerHome extends StatefulWidget {
  const buyerHome({super.key});

  @override
  State<buyerHome> createState() => _buyerHomeState();
}

class _buyerHomeState extends State<buyerHome> {
  SnackBar _snackBar = new SnackBar(content: Text('Successfully Logged Out'));

  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const savedlisting(),
    const addlistingspage(),
    const profilepage(),
  ];
  
  signout() {
    FirebaseAuth.instance.signOut();
    ScaffoldMessenger.of(context).showSnackBar(_snackBar);
  }

  // final _dbref = FirebaseDatabase.instance.ref();
  @override
  Widget build(BuildContext context) {
    // final _userRef = _dbref.child('users');

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _pages[_selectedIndex],
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "HomeQuest",
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: GestureDetector(
          child: Icon(Icons.home_outlined),
          onTap: signout,
        ),
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 137, 236, 150),
      ),
      bottomNavigationBar: GNav(
        tabBorderRadius: 25,
        backgroundColor: Color.fromARGB(255, 137, 236, 150),
        activeColor: Colors.green[700],
        color: Colors.green[700],
        tabActiveBorder:
            Border.all(color: const Color.fromRGBO(56, 142, 60, 1), width: 0.5),
        tabBackgroundColor: const Color.fromRGBO(232, 245, 233, 1),
        duration: const Duration(milliseconds: 300),
        haptic: true,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        tabMargin: const EdgeInsets.symmetric(vertical: 5),
        gap: 5,
        tabs: const [
          GButton(
            icon: Icons.home,
            text: 'Home',
          ),
          GButton(
            icon: Icons.favorite_border_rounded,
            text: 'Likes',
          ),
          GButton(
            icon: Icons.add,
            text: 'Add',
          ),
          GButton(
            icon: Icons.person,
            text: 'Profile',
          ),
        ],
        selectedIndex: _selectedIndex,
        onTabChange: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
