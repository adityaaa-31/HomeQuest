import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:homequest/Pages/HomePages/listingDetails.dart';

class profilepage extends StatefulWidget {
  const profilepage({super.key});

  @override
  State<profilepage> createState() => _profilepageState();
}

class _profilepageState extends State<profilepage> {
  int? expandedListingIndex;
  String? username;
  String? useremail;

  final user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final currentUserId = FirebaseAuth.instance.currentUser!.uid;

    if (user != null) {
      // Name, email address, and profile photo URL
      username = user?.displayName;
      useremail = user?.email;
      final photoUrl = user?.photoURL;
    }
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 16, bottom: 8),
              child: CircleAvatar(
                  child: Icon(Icons.person, color: Colors.grey),
                  backgroundColor: Colors.grey[200],
                  maxRadius: 45),
            ),
            SizedBox(
              width: 16,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(username.toString()),
                Text(useremail.toString()),
              ],
            ),
          ],
        ),
        Divider(),
        Flexible(
          child: Container(
            margin: EdgeInsets.all(12),
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('house_listings')
                  .where('uid', isEqualTo: currentUserId) // Filter by user ID
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }

                final listings = snapshot.data!.docs;

                if (listings.isEmpty) {
                  return Center(child: Text('No listings available.'));
                }

                return ListView.builder(
                  itemCount: listings.length,
                  itemBuilder: (context, index) {
                    final listing = listings[index];
                    final bhk = listing['bhk'];
                    final title = listing['title'];
                    final description = listing['description'];
                    final price = listing['price'];
                    final type = listing['type'];
                    final property = listing['property'];
                    final area = listing['area'];
                    final images = List<String>.from(listing['images']);
                    final user = listing['uid'];

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
