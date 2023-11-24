import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ListingDetailScreen extends StatelessWidget {
  final String title;
  final String description;
  final List<String> images;

  ListingDetailScreen({
    required this.title,
    required this.description,
    required this.images,
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
                    return Hero(
                      tag: image, // Unique tag for each image
                      child: Image.network(
                        image,
                        fit: BoxFit.cover,
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
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'About this property',
              style: TextStyle(fontSize: 25, fontFamily: 'Poppins'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'BHK',
                  style: TextStyle(fontSize: 16, fontFamily: 'Poppins'),
                ),
                Text(
                  'Rent/Month',
                  style: TextStyle(fontSize: 16, fontFamily: 'Poppins'),
                ),
                Text(
                  'Property Type',
                  style: TextStyle(fontSize: 16, fontFamily: 'Poppins'),
                ),
                Text(
                  'Area in SqFT',
                  style: TextStyle(fontSize: 16, fontFamily: 'Poppins'),
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
