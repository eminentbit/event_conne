import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AccountSettingsScreen extends StatefulWidget {
  const AccountSettingsScreen({super.key});

  @override
  State<AccountSettingsScreen> createState() => _AccountSettingsScreenState();
}

class _AccountSettingsScreenState extends State<AccountSettingsScreen> {
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Account Settings"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Profile Information
          _buildSectionTitle("Profile Information"),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text("Display Name"),
            subtitle: Text(user?.displayName ?? "Not Set"),
            trailing: const Icon(Icons.edit),
            onTap: () {
              // Function to update display name
            },
          ),
          ListTile(
            leading: const Icon(Icons.email),
            title: const Text("Email"),
            subtitle: Text(user?.email ?? "Not Set"),
            trailing: const Icon(Icons.lock), // Email is non-editable
          ),
          ListTile(
            leading: const Icon(Icons.phone),
            title: const Text("Phone Number"),
            subtitle: Text(user?.phoneNumber ?? "Not Set"),
            trailing: const Icon(Icons.edit),
            onTap: () {
              // Function to update phone number
            },
          ),

          const Divider(),

          // Security & Privacy
          _buildSectionTitle("Security & Privacy"),
          ListTile(
            leading: const Icon(Icons.lock),
            title: const Text("Change Password"),
            onTap: () {
              // Navigate to password change screen
            },
          ),
          ListTile(
            leading: const Icon(Icons.security),
            title: const Text("Enable 2FA"),
            onTap: () {
              // Enable Two-Factor Authentication
            },
          ),

          const Divider(),

          // Subscription & Payments
          _buildSectionTitle("Subscription & Payments"),
          ListTile(
            leading: const Icon(Icons.credit_card),
            title: const Text("Payment Methods"),
            onTap: () {
              // Navigate to manage payments
            },
          ),
          ListTile(
            leading: const Icon(Icons.receipt),
            title: const Text("Billing History"),
            onTap: () {
              // Navigate to billing history
            },
          ),

          const Divider(),

          // Account Actions
          _buildSectionTitle("Account Actions"),
          ListTile(
            leading: const Icon(Icons.delete, color: Colors.red),
            title: const Text("Delete Account", style: TextStyle(color: Colors.red)),
            onTap: _deleteAccount,
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text("Log Out"),
            onTap: _logout,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacementNamed('/login'); // Redirect to login
  }

  Future<void> _deleteAccount() async {
    try {
      await FirebaseAuth.instance.currentUser?.delete();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Account deleted.")));
      Navigator.of(context).pushReplacementNamed('/login');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }
}