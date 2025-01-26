// Widget for Event Cards
import 'package:flutter/material.dart';

import '../models/events.dart';
import '../screens/event_detail_screen.dart';

class EventCard extends StatelessWidget {
  final String eventName;
  final DateTime eventDate;
  final String location;
  final String description;

  const EventCard({
    super.key,
    required this.eventName,
    required this.eventDate,
    required this.location,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: const Icon(Icons.event, color: Colors.blueAccent),
        title: Text(eventName,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('${eventDate.toLocal()}'.split(' ')[0]),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => EventDetailsScreen(
                event: Event(
                  id: '1', // Add appropriate id
                  name: eventName,
                  date: eventDate,
                  location: location,
                  description: 'Event description',
                  image: 'image_url',
                  time: 'Event time', 
                  createdBy: '',
                  category: Category.funeral
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
