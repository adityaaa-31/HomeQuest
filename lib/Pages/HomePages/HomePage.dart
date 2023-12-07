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
                    final bhk = listing['bhk'];
                    final city = listing['city'];
                    final type = listing['type'];
                    final property = listing['property'];
                    final description = listing['description'];
                    final price = listing['price'];
                    final images = List<String>.from(listing['images']);
                    final area = listing['area'];
                    final user = listing['uid'];

                    final title =
                        '${bhk} BHK ${property} for ${type} in ${city}';

                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ListingDetailScreen(
                              title: title,
                              description: description,
                              images: images,
                              bhk: bhk,
                              price: price,
                              type: type,
                              property: property,
                              area: area,
                              user: user,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        child: Row(
                          children: [
                            Container(
                              height: 120,
                              padding: EdgeInsets.all(4),
                              child: Hero(
                                tag: images[0],
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    images.first,
                                    width: 100,
                                    height: 200,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
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
