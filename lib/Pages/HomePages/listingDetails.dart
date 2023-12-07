import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ListingDetailScreen extends StatelessWidget {
  final String bhk;
  final String type;
  final String property;
  final String price;
  final String title;
  final String description;
  final String area;
  final String user;
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
  });

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
                height: 400,
                enableInfiniteScroll: false,
                viewportFraction: 1.0,
              ),
              items: images.map((image) {
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
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              title,
              style: TextStyle(fontSize: 25, fontFamily: 'Poppins'),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'About this property',
              style: TextStyle(
                  fontSize: 19,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, bottom: 10),
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
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Rent/Month',
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Property Type ',
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Area in SqFT',
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold),
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
                      bhk,
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.normal),
                    ),
                    Text(
                      price,
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.normal),
                    ),
                    Text(
                      type,
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.normal),
                    ),
                    Text(
                      area,
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(left: 70, right: 40),
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    'Contact',
                    style:
                        TextStyle(fontFamily: 'Poppins', color: Colors.black),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(border: Border.symmetric()),
                margin: EdgeInsets.only(left: 20, right: 20),
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    'Save Listing',
                    style:
                        TextStyle(fontFamily: 'Popppins', color: Colors.black),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
