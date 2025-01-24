import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_connect/models/events.dart';
import 'package:event_connect/services/send_mail.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class InviteesBottomSheet extends StatefulWidget {
  const InviteesBottomSheet({super.key, required this.event});

  final Event event;

  @override
  State<InviteesBottomSheet> createState() => _InviteesBottomSheetState();
}

class _InviteesBottomSheetState extends State<InviteesBottomSheet> {
  final TextEditingController inviteeController = TextEditingController();
  final List<String> invitees = []; // List to store invitees

  void addInvitee() async {
    if (inviteeController.text.isNotEmpty) {
      setState(() {
        invitees.add(inviteeController.text);
        inviteeController.clear();
      });

      // Fetch the user's FCM token from Firestore (Assuming each user has a token stored)
      String inviteeEmail = invitees.last; // Get last added invitee
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(inviteeEmail)
          .get();

      if (userDoc.exists && userDoc['fcmToken'] != null) {
        String fcmToken = userDoc['fcmToken'];

        // Send FCM notification
        await FirebaseMessaging.instance.sendMessage(
          to: fcmToken,
          data: {
            "title": "Event Invitation",
            "body": "You have been invited to an event!",
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        top: 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Add Invitees",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          // Input Field
          TextField(
            controller: inviteeController,
            decoration: InputDecoration(
              hintText: "Enter invitee's name or email",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              suffixIcon: IconButton(
                icon: const Icon(Icons.add),
                onPressed: addInvitee,
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Invitees List
          if (invitees.isNotEmpty)
            Column(
              children: invitees.map((invitee) {
                return ListTile(
                  title: Text(invitee),
                  trailing: IconButton(
                    icon: const Icon(Icons.remove_circle, color: Colors.red),
                    onPressed: () {
                      setState(() {
                        invitees.remove(invitee);
                      });
                    },
                  ),
                );
              }).toList(),
            ),

          const SizedBox(height: 16),

          // Done Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () {
                sendEmail(inviteeController.text, widget.event.name);
                Navigator.pop(context); // Close Bottom Sheet
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Added ${invitees.length} invitees!")),
                );
              },
              child: const Text("Done",
                  style: TextStyle(color: Colors.white, fontSize: 18)),
            ),
          ),
        ],
      ),
    );
  }
}
