import 'package:flutter/material.dart';
import '../models/events.dart';
import '../widgets/event_card.dart';
import 'add_event_screen.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  // List of events
  List<Event> events = [
    Event(
      id: "1",
      name: "Event 1",
      date: DateTime.parse("2022-12-12"),
      time: "10:00 AM",
      location: "Location 1",
      description: "Description 1",
      image: "image1.png", 
      createdBy: ''
    ),
    Event(
      id: "2",
      name: "Event 2",
      date: DateTime.parse("2022-12-12"),
      time: "11:00 AM",
      location: "Location 2",
      description: "Description 2",
      image: "image2.png", createdBy: ''
    ),
    Event(
      id: "3",
      name: "Event 3",
      date: DateTime.parse("2022-12-12"),
      time: "12:00 PM",
      location: "Location 3",
      description: "Description 3",
      image: "image3.png", 
      createdBy: ''
    ),
  ];

  // Function to add a new event
  void _addEvent(String name, String date, String location, String description) {
    setState(() {
      events.add(Event(
        id: DateTime.now().toString(),
        name: name,
        date: DateTime.parse(date),
        time: "00:00 AM",
        location: location,
        description: description,
        image: "default.png", 
        createdBy: ''
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Events"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search Bar
            TextField(
              decoration: InputDecoration(
                hintText: "Search for events...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Events List
            Expanded(
              child: ListView.builder(
                itemCount: events.length,
                itemBuilder: (context, index) {
                  final event = events[index];
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

      // Floating Action Button for Adding Events
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(68, 138, 255, 1),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true, // Allows full-screen height if needed
            builder: (context) {
              return AddEventWidget(onAddEvent: _addEvent);
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}