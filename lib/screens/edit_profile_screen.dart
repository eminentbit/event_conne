import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _nameController = TextEditingController();
  File? _image;
  final ImagePicker _picker = ImagePicker();
  final User? _user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() {
    if (_user != null) {
      _nameController.text = _user.displayName ?? "";
    }
  }

  Future<String> uploadImageToFirebase(File imageFile) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    Reference ref =
        FirebaseStorage.instance.ref().child("profile_pictures/$uid.jpg");

    UploadTask uploadTask = ref.putFile(imageFile);
    TaskSnapshot snapshot = await uploadTask;
    return await snapshot.ref.getDownloadURL();
  }

  Future<void> _updateProfile() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      try {
        await user.updateDisplayName(_nameController.text);

        if (_image != null) {
          String imageUrl = await uploadImageToFirebase(_image!);
          await user.updatePhotoURL(imageUrl);
        }

        await user.reload();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Profile updated successfully!")),
        );
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error updating profile: $e")),
        );
      }
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _deleteAccount() async {
    try {
      await _user!.delete();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Account deleted successfully")),
      );
      Navigator.of(context).popUntil((route) => route.isFirst);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error deleting account: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Profile")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: _image != null
                    ? FileImage(_image!)
                    : NetworkImage(_user?.photoURL ?? "") as ImageProvider,
                child: _image == null
                    ? const Icon(Icons.camera_alt, size: 30)
                    : null,
              ),
            ),
            const SizedBox(height: 20),

            // Display name field (Editable)
            Expanded(
              child: TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: "Full Name"),
              ),
            ),
            const SizedBox(height: 10),

            // Email (Not Editable)
            TextField(
              controller: TextEditingController(text: _user?.email ?? ""),
              decoration: const InputDecoration(labelText: "Email"),
              enabled: false,
            ),
            const SizedBox(height: 20),

            // Save Changes Button
            ElevatedButton(
              onPressed: _updateProfile,
              child: const Text("Save Changes"),
            ),
            const SizedBox(height: 20),

            // Delete Account Button
            TextButton(
              onPressed: _deleteAccount,
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text("Delete Account"),
            ),
          ],
        ),
      ),
    );
  }
}
