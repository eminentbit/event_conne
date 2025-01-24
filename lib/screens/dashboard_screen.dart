import 'package:event_connect/widgets/event_card.dart';
import 'package:flutter/material.dart';

import '../models/events.dart';
// import 'qr_scanner_screen.dart';

// Define an Event model (optional but recommended)

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});

  // 🔹 Define a List of Events
  final List<Event> events = [
    Event(
      name: "Tech Conference 2025",
      date: DateTime.parse("2025-01-30"),
      location: "New York",
      description: "A conference on the latest tech trends.",
      id: '1',
      image: 'assets/images/tech_conference.jpg',
      time: '10:00 AM', 
      createdBy: '',
    ),
    Event(
      name: "Flutter Meetup",
      date: DateTime.parse("2025-02-10"),
      location: "San Francisco",
      description: "A meetup for Flutter developers.",
      id: '2',
      image: 'assets/images/flutter_meetup.jpg',
      time: '2:00 PM', 
      createdBy: '',
    ),
    Event(
      name: "AI Summit",
      date: DateTime.parse("2025-02-25"),
      location: "London",
      description: "Discussing the future of AI technology.",
      id: '3',
      image: 'assets/images/ai_summit.jpg',
      time: '9:00 AM', 
      createdBy: '',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "EventConnect",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blueAccent,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome Message
              const Text(
                "Welcome, User!",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 20),

              // QR Code Scanner Button
              // SizedBox(
              //   width: double.infinity,
              //   height: 50,
              //   child: ElevatedButton.icon(
              //     icon: const Icon(Icons.qr_code_scanner),
              //     label: const Text("Scan QR Code"),
              //     style: ElevatedButton.styleFrom(
              //       backgroundColor: Colors.green,
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(12),
              //       ),
              //     ),
              //     onPressed: () {
              //       Navigator.of(context).push(
              //         MaterialPageRoute(
              //           builder: (context) => const Text('QR code scanner'),
              //         ),
              //       );
              //     },
              //   ),
              // ),

              const SizedBox(height: 30),

              // Upcoming Events Section
              const Text(
                "Upcoming Events",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              // 🔹 Use ListView.builder for dynamic events
              Expanded(
                child: ListView.builder(
                  itemCount: events.length,
                  itemBuilder: (context, index) {
                    final event = events[index]; // Get event from the list
                    return EventCard(
                      eventName: event.name,
                      eventDate: event.date,
                      location: event.location,
                      description: event.description,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}