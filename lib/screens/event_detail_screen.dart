import 'package:event_connect/models/events.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/invitees_bottom_sheet.dart';

class EventDetailsScreen extends StatefulWidget {
  final Event event;

  const EventDetailsScreen({
    super.key,
    required this.event,
  });

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  final String? currentUserId = FirebaseAuth.instance.currentUser?.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Event Details"),
          backgroundColor: Colors.blueAccent),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Event Image
            // SizedBox(
            //   height: 250,
            //   width: double.infinity,
            //   child: Image.asset(event.image, fit: BoxFit.cover),
            // ),

            const SizedBox(height: 20),

            // Event Name
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                widget.event.name,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 10),

            // Event Details (Date, Time, Location)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  const Icon(Icons.calendar_today, color: Colors.blueAccent),
                  const SizedBox(width: 8),
                  Text(widget.event.date.toString(),
                      style: const TextStyle(fontSize: 16)),
                ],
              ),
            ),

            const SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  const Icon(Icons.access_time, color: Colors.blueAccent),
                  const SizedBox(width: 8),
                  Text(widget.event.time, style: const TextStyle(fontSize: 16)),
                ],
              ),
            ),

            const SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  const Icon(Icons.location_on, color: Colors.blueAccent),
                  const SizedBox(width: 8),
                  Text(widget.event.location,
                      style: const TextStyle(fontSize: 16)),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Event Description
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "About this Event",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                widget.event.description,
                style: const TextStyle(fontSize: 16, color: Colors.black87),
              ),
            ),

            const SizedBox(height: 30),

            if (currentUserId == widget.event.createdBy) ...[
              const Text("Invitees:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              // List of invitees
              Expanded(
                child: ListView.builder(
                  itemCount: widget.event.invitees
                      .length, // Assuming your Event model has a list of invitees
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(widget.event.invitees[index]),
                      trailing: IconButton(
                        icon:
                            const Icon(Icons.remove_circle, color: Colors.red),
                        onPressed: () {
                          // Remove invitee logic (update Firestore if needed)
                        },
                      ),
                    );
                  },
                ),
              ),
            ],

            // Add Invitees Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.person_add), // Invitees Icon
                  label: const Text("Add Invitees",
                      style: TextStyle(color: Colors.white, fontSize: 18)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) => InviteesBottomSheet(
                        event: widget.event,
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
