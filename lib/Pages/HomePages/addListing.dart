import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
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
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
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

        // Create a Firestore document with the listing information
        await FirebaseFirestore.instance.collection('house_listings').add({
          'uid': uid,
          'title': titleController.text,
          'description': descriptionController.text,
          'images': imageUrls,
          'timestamp': FieldValue.serverTimestamp(),
        });

        // Clear the form and image list
        titleController.clear();
        descriptionController.clear();
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
      final Reference ref = storage
          .ref()
          .child('house_images/${uid}/${DateTime.now().millisecondsSinceEpoch}');
      final UploadTask uploadTask = ref.putFile(image);
      final TaskSnapshot taskSnapshot = await uploadTask;

      if (taskSnapshot.state == TaskState.success) {
        final String downloadUrl = await ref.getDownloadURL();
        imageUrls.add(downloadUrl);
      } else {
        // Handle image upload failure.
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
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15))),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: descriptionController,
                decoration: InputDecoration(
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
              ElevatedButton(
                onPressed: _pickImages,
                child: Text('Pick Images'),
              ),
              if (selectedImages.isNotEmpty)
                GridView.builder(
                  shrinkWrap: true,
                  itemCount: selectedImages.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemBuilder: (context, index) {
                    return Image.file(selectedImages[index]);
                  },
                ),
              ElevatedButton(
                onPressed: _submitListing,
                child: Text('Submit Listing'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
