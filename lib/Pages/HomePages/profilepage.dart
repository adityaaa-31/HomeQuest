import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:homequest/Pages/HomePages/listingDetails.dart';
import 'package:homequest/models/users.dart';

class profilepage extends StatefulWidget {
  @override
  State<profilepage> createState() => _profilepageState();
}

class _profilepageState extends State<profilepage> {
  // profilepage({super.key, required this.homeUser});
  HomeUser homeUser = HomeUser(
    email: "",
    fullName: "",
    phone: "",
    uid: "",
  );

  final user = FirebaseAuth.instance.currentUser;

  String currentUserId = FirebaseAuth.instance.currentUser!.uid;

  geUserData() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUserId)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        if (this.mounted) {
          setState(() {
            homeUser = HomeUser.fromSnapshot(documentSnapshot);
          });
        }

        print(homeUser.fullName);
      } else {
        print(documentSnapshot.data());
      }
    });
    // print(currentUserId);
  }

  @override
  Widget build(BuildContext context) {
    if (user != null) {
      // Name, email address, and profile photo URL
      geUserData();
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
                Text(homeUser.fullName.toString()),
                Text(homeUser.email.toString()),
                Text(homeUser.phone.toString()),
              ],
            ),
          ],
        ),
        Divider(),
        Flexible(
          child: Container(
            padding: EdgeInsets.all(5),
            // color: Colors.amber,
            margin: EdgeInsets.all(12),
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('house_listings')
                  .where('uid', isEqualTo: currentUserId)
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
                    final address = listing['address'];
                    final listing_id = listing['lid'];

                    final title =
                        '${bhk} BHK ${property} for ${type} in ${city}';

                    return Container(
                      padding: EdgeInsets.all(4),
                      child: GestureDetector(
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
                                address: address,
                                listing_id: listing_id,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              // color: Colors.black,
                              border: Border.all(),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 16,
                                  ),
                                  Text(
                                    title,
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                  Text('Rs ${price} | ${area} Sq.Ft.'),
                                  Text('${city}'),
                                ],
                              )
                            ],
                          ),
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
