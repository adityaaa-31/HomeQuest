import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:homequest/Pages/AuthPages/customerLogin.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

class addlistingspage extends StatefulWidget {
  const addlistingspage({super.key});

  @override
  State<addlistingspage> createState() => _addlistingspageState();
}

class _addlistingspageState extends State<addlistingspage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController floorController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  List<String> propertyTypes = ['Apartment', 'Bunglow', 'PG/Hostel', 'Other'];
  List<String> listingTypes = ['Sale', 'Rent'];
  List<String> bhkTypes = ['1', '2', '3', '4'];
  List<String> cities = [
    'Mumbai',
    'Delhi',
    'Bangalore',
    'Hyderabad',
    'Chennai',
    'Kolkata',
    'Ahmedabad',
    'Pune',
    'Surat',
    'Jaipur',
    'Lucknow',
    'Kanpur',
    'Nagpur',
    'Indore',
    'Thane',
    'Bhopal',
    'Visakhapatnam',
    'Pimpri-Chinchwad',
    'Patna',
    'Vadodara',
  ];

  // Define variables to store the selected values
  String selectedPropertyType = 'Apartment';
  String selectedListingType = 'Sale';
  String selectedBHKType = '1';
  String selectedCity = '';

  List<File> selectedImages = [];
  final uid = FirebaseAuth.instance.currentUser!.uid;
  Future<void> _pickImages() async {
    final imagePicker = ImagePicker();
    final pickedImages = await imagePicker.pickMultiImage();

    if (pickedImages != null) {
      setState(() {
        selectedImages = pickedImages.map((image) => File(image.path)).toList();
      });
    }
  }

  void _submitListing() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Store the images in Firebase Storage
        List<String> imageUrls = await uploadImages(selectedImages);

        showDialog(
          context: context,
          builder: (context) {
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        );
        // Create a Firestore document with the listing information
        await FirebaseFirestore.instance.collection('house_listings').add({
          'uid': uid,
          'description': descriptionController.text,
          'price': priceController.text,
          'type': selectedListingType,
          'property': selectedPropertyType,
          'bhk': selectedBHKType,
          'images': imageUrls,
          'timestamp': FieldValue.serverTimestamp(),
        });

        Navigator.pop(context);

        Fluttertoast.showToast(
            msg: "Listing Added",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.white,
            textColor: Colors.black,
            fontSize: 16.0);

        // Clear the form and image list

        descriptionController.clear();

        priceController.clear();
        setState(() {
          selectedImages.clear();
        });

        // Display a success message or navigate to a different screen.
      } catch (e) {
        print('Error submitting listing: $e');
        // Handle error and provide user feedback.
      }
    }
  }

  Future<List<String>> uploadImages(List<File> images) async {
    List<String> imageUrls = [];
    final storage = FirebaseStorage.instance;

    for (File image in images) {
      final Reference ref = storage.ref().child(
          'house_images/${uid}/${DateTime.now().millisecondsSinceEpoch}');
      final UploadTask uploadTask = ref.putFile(image);
      final TaskSnapshot taskSnapshot = await uploadTask;

      if (taskSnapshot.state == TaskState.success) {
        final String downloadUrl = await ref.getDownloadURL();
        imageUrls.add(downloadUrl);
      } else {
        // Handle image upload failure.
        // Navigator.pop(context);

        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Something went wrong')));
      }
    }

    return imageUrls;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 15,
              ),
              DropdownButtonFormField<String>(
                value: selectedListingType,
                items: listingTypes.map((String type) {
                  return DropdownMenuItem<String>(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedListingType = newValue!;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Listing Type',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              DropdownButtonFormField<String>(
                value: selectedPropertyType,
                items: propertyTypes.map((String type) {
                  return DropdownMenuItem<String>(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedPropertyType = newValue!;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Property Type',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              DropdownButtonFormField<String>(
                value: selectedBHKType,
                items: bhkTypes.map((String type) {
                  return DropdownMenuItem<String>(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedPropertyType = newValue!;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'BHK',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              DropdownButtonFormField<String>(
                value: selectedCity,
                items: cities.map((String type) {
                  return DropdownMenuItem<String>(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedCity = newValue!;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'BHK',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: 'Price',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15))),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a price';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: descriptionController,
                maxLines: 3,
                decoration: InputDecoration(
                    hintMaxLines: 3,
                    labelText: 'Description',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15))),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 15,
              ),
              if (selectedImages.isNotEmpty)
                Container(
                  child: GridView.builder(
                    shrinkWrap: true,
                    itemCount: selectedImages.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemBuilder: (context, index) {
                      return Card(
                          color: Colors.white70,
                          elevation: 10,
                          child: Image.file(
                            selectedImages[index],
                            fit: BoxFit.fill,
                          ));
                    },
                  ),
                ),
              SizedBox(
                height: 15,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 40, right: 20),
                    child: ElevatedButton(
                      onPressed: _pickImages,
                      child: Text(
                        'Pick Images',
                        style: TextStyle(
                            fontFamily: 'Poppins', color: Colors.black),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    child: ElevatedButton(
                      onPressed: _submitListing,
                      child: Text(
                        'Submit Listing',
                        style: TextStyle(
                            fontFamily: 'Popppins', color: Colors.black),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
