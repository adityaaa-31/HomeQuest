import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'listingDetails.dart';
// import 'package:homequest/Pages/HomePages/addListing.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int? expandedListingIndex;
  final currentUserId = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              labelText: 'Search',
            ),
          ),
        ),
        Flexible(
          child: Container(
            padding: EdgeInsets.all(12),
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('house_listings')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }

                final listings = snapshot.data!.docs;

                if (listings.isEmpty) {
                  return Center(child: Text('No Listings Available'));
                }

                return ListView.builder(
                  padding: EdgeInsets.all(2),
                  itemCount: listings.length,
                  itemBuilder: (context, index) {
                    // final isExpanded = index == expandedListingIndex;

                    final listing = listings[index];
                    final title = listing['title'];
                    final description = listing['description'];
                    final price = listing['price'];
                    final images = List<String>.from(listing['images']);

                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ListingDetailScreen(
                              title: title,
                              description: description,
                              images: images,
                            ),
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          Container(
                            height: 120,
                            padding: EdgeInsets.only(bottom: 8),
                            child: Hero(
                              tag: images[0],
                              child: Image.network(
                                images.first,
                                width: 100,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                title,
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(price),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
