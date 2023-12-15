// import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';

class ListingDetailScreen extends StatefulWidget {
  final String bhk;
  final String type;
  final String property;
  final String price;
  final String title;
  final String description;
  final String area;
  final String user;
  final String address;
  final String listing_id;
  final List<String> images;

  ListingDetailScreen({
    required this.title,
    required this.description,
    required this.images,
    required this.bhk,
    required this.price,
    required this.type,
    required this.property,
    required this.area,
    required this.user,
    required this.address,
    required this.listing_id,
  });

  @override
  State<ListingDetailScreen> createState() => _ListingDetailScreenState();
}

class _ListingDetailScreenState extends State<ListingDetailScreen> {
  late Map<String, dynamic> userinfo;

  String? username;

  String? useremail;

  String? userphone;

  @override
  void initState() {
    super.initState();
    getUserDetails();
  }

  void getUserDetails() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.user)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        setState(() {
          userinfo = documentSnapshot.data() as Map<String, dynamic>;

          username = userinfo['fullname'] as String;
          useremail = userinfo['email'] as String;
          userphone = userinfo['phone'] as String;
        });
        print(username);
      } else {
        print(username);
      }
    });
  }

  saveListing(String listing_id) async {
    // Save the listing for the current user
    await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.user)
        .collection('saved_listings')
        .doc(listing_id)
        .set({
      'listing_id': widget.listing_id,
      'timestamp': FieldValue.serverTimestamp(),
    });

    // Provide user feedback (you can use a SnackBar or any other method)
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Listing saved!'),
    ));
  }

  // Widget showUserInfo() {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "HomeQuest",
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 137, 236, 150),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 200,
            child: CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                height: 400,
                enableInfiniteScroll: false,
                viewportFraction: 1.0,
              ),
              items: widget.images.map((image) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                      ),
                      child: Hero(
                        tag: image, // Unique tag for each image
                        child: Image.network(
                          image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 4, bottom: 4),
            child: Text(
              widget.title,
              style: TextStyle(fontSize: 25, fontFamily: 'Poppins'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 10,
            ),
            child: Row(
              children: [
                Icon(Icons.location_on),
                Text(
                  '${widget.address}',
                  style: TextStyle(fontSize: 20, fontFamily: 'Poppins'),
                ),
              ],
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'About this property',
              style: TextStyle(
                  fontSize: 19,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, bottom: 16),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'BHK',
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      'Rent/Month',
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      'Property Type ',
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      'Area in SqFT',
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      'Description',
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                SizedBox(
                  width: 30,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.bhk,
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.normal),
                    ),
                    Text(
                      widget.price,
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.normal),
                    ),
                    Text(
                      widget.type,
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.normal),
                    ),
                    Text(
                      widget.area,
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.normal),
                    ),
                    Text(
                      widget.description,
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'About Seller',
              style: TextStyle(
                  fontSize: 19,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  username.toString(),
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.normal),
                ),
                Text(
                  useremail.toString(),
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.normal),
                ),
                Text(
                  userphone.toString(),
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 50, right: 40),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.greenAccent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () async {
                      Uri myUri =
                          Uri.parse("https://wa.me/${userphone}?text=Hello");

                      await launchUrl(myUri);
                    },
                    child: Text(
                      'Contact Seller',
                      style:
                          TextStyle(fontFamily: 'Poppins', color: Colors.black),
                    ),
                  ),
                ),
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.greenAccent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () {
                      saveListing(widget.listing_id);
                    },
                    child: Text(
                      'Save Listing',
                      style: TextStyle(
                          fontFamily: 'Popppins', color: Colors.black),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
