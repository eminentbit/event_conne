import 'package:event_connect/screens/edit_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:event_connect/screens/login_screen.dart';
import 'package:event_connect/screens/notifications.dart';
import 'package:event_connect/widgets/settings_option.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Settings"), backgroundColor: Colors.blueAccent),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            elevation: 3,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: const CircleAvatar(
                backgroundImage: AssetImage("assets/profile.jpg"),
                radius: 30,
              ),
              title: const Text("John Doe",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: const Text("johndoe@example.com"),
              trailing: const Icon(Icons.edit),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (ctx) => const EditProfileScreen()),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          SettingsOption(
            icon: Icons.notifications,
            title: "Notifications",
            onClick: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => const NotificationsPage()));
            },
          ),
          SettingsOption(
            icon: Icons.lock,
            title: "Privacy & Security",
            onClick: () {
              // Navigate to Privacy & Security Page
            },
          ),
          SettingsOption(
            icon: Icons.person,
            title: "Account Settings",
            onClick: () {
              // Navigate to Account Settings Page
            },
          ),
          // const SettingsOption(
          //   icon: Icons.dark_mode,
          //   title: "Dark Mode",
          //   isSwitch: true, // No `onClick` needed since it's a switch
          // ),
          const SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (ctx) => const LoginScreen()),
                );
              },
              child: const Text("Logout",
                  style: TextStyle(color: Colors.white, fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }
}
