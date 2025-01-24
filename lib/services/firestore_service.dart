import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
// import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../models/user.dart';

class FirestoreService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<UserModel?> getUserProfile() async {
    String uid = _auth.currentUser!.uid;
    DocumentSnapshot doc = await _firestore.collection("users").doc(uid).get();

    if (doc.exists) {
      return UserModel.fromJson(doc.data() as Map<String, dynamic>);
    }
    return null;
  }

  Future<void> updateUserProfile(String name, File? imageFile) async {
    String uid = _auth.currentUser!.uid;
    String imageUrl = '';

    if (imageFile != null) {
      Reference storageRef = _storage.ref().child("profile_images/$uid.jpg");
      UploadTask uploadTask = storageRef.putFile(imageFile);
      TaskSnapshot snapshot = await uploadTask;
      imageUrl = await snapshot.ref.getDownloadURL();
    }

    await _firestore.collection("users").doc(uid).update({
      'name': name,
      if (imageUrl.isNotEmpty) 'profileImage': imageUrl,
    });
  }
}