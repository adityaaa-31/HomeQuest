import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:homequest/Pages/HomePages/listingDetails.dart';

// class SavedListingsPage extends StatelessWidget {
//   // final String currentUserId;
//   String currentUserId = FirebaseAuth.instance.currentUser!.uid;
// // Pass the current user ID to this widget

//   // SavedListingsPage({});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Saved Listings'),
//       ),
//       body: SavedListingsStream(),
//     );
//   }
// }

class SavedListingsPage extends StatelessWidget {
  String currentUserId = FirebaseAuth.instance.currentUser!.uid;
  // SavedListingsStream({required this.currentUserId});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(currentUserId)
          .collection('saved_listings')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        final savedListingData = snapshot.data;

        if (savedListingData!.docs.isEmpty) {
          return Center(child: Text('No saved listings available.'));
        }

        return ListView.builder(
          itemCount: savedListingData.docs.length,
          itemBuilder: (context, index) {
            final savedListing = savedListingData.docs[index];
            final houseListingId = savedListing['listing_id'];

            return SavedListingItem(savedListingId: houseListingId);
          },
        );
      },
    );
  }
}

class SavedListingItem extends StatelessWidget {
  final String savedListingId;
  final user = FirebaseAuth.instance.currentUser;

  SavedListingItem({required this.savedListingId});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('house_listings')
          .doc(savedListingId)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        final listingData = snapshot.data;

        if (!listingData!.exists) {
          return Container(); // Handle the case where the house listing doesn't exist
        }

        final bhk = listingData['bhk'];
        final city = listingData['city'];
        final type = listingData['type'];
        final property = listingData['property'];
        final description = listingData['description'];
        final price = listingData['price'];
        final images = List<String>.from(listingData['images']);
        final area = listingData['area'];
        final user = listingData['uid'];
        final address = listingData['address'];
        final listing_id = listingData['lid'];

        final title = '${bhk} BHK ${property} for ${type} in ${city}';

// Replace with the actual field name

        return Container(
          padding: EdgeInsets.all(12),
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
                  borderRadius: BorderRadius.all(Radius.circular(15))),
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
  }
}
