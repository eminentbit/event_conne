import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_connect/event_connect.dart';
import 'package:event_connect/screens/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> login() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // Fetch username from Firestore
      DocumentSnapshot userDoc = await _firestore
          .collection("users")
          .doc(userCredential.user!.uid)
          .get();
      String username = userDoc["username"];

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Welcome, $username!")));
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => const MainScreen(),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: $e"),
        ),
      );
    }
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Trigger the Google Sign-In flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // If the user cancels sign-in, return null
      if (googleUser == null) {
        return Future.error("Google sign-in canceled");
      }

      // Obtain the authentication details from the Google sign-in
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a credential for Firebase authentication
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google credential
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      // Check if the user already exists in Firestore
      final DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection("users")
          .doc(userCredential.user!.uid)
          .get();

      if (!userDoc.exists) {
        // If the user does not exist in Firestore, add them
        await FirebaseFirestore.instance
            .collection("users")
            .doc(userCredential.user!.uid)
            .set({
          "username": googleUser.displayName ?? "User",
          "email": googleUser.email,
          "profilePic": googleUser.photoUrl ?? "",
          "createdAt": FieldValue.serverTimestamp(),
        });
      }

      return userCredential;
    } catch (e) {
      print("🔥 Google Sign-In Error: $e");
      return Future.error("Failed to sign in with Google");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // App Logo
              Image.asset('assets/icons/logo.jpeg', height: 100),

              const SizedBox(height: 20),
              // Email Field
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                  prefixIcon: const Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Password Field
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                  prefixIcon: const Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Login Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => const MainScreen(),
                      ),
                    );
                  },
                  child: Text("Login",
                      style: GoogleFonts.poppins(
                          fontSize: 18, color: Colors.white)),
                ),
              ),

              const SizedBox(height: 16),

              // Google Sign-In Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton.icon(
                  icon: Image.asset('assets/icons/google.png',
                      height: 20), // TODO: Add Google icon image
                  label: const Text("Continue with Google"),
                  onPressed: () async {
                    try {
                      UserCredential? user = await signInWithGoogle();
                      print(user);
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (ctx) => const MainScreen()),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(e.toString()),
                        ),
                      );
                    }
                  },
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // Sign Up Option
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => const SignupScreen(),
                    ),
                  );
                },
                child: const Text("Don't have an account? Sign Up"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
