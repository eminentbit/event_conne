import 'package:flutter/material.dart';

enum EventCategory { graduation, marriage, birthday, funeral }

class Event {
  final String title;
  final String date;
  final EventCategory category;

  Event({required this.title, required this.date, required this.category});
}

class EventCategoriesScreen extends StatelessWidget {
  const EventCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Event> events = [
      Event(
          title: "Cérémonie de Lucas",
          date: "10 Juin 2024",
          category: EventCategory.graduation),
      Event(
          title: "Mariage de Sophie & Max",
          date: "25 Juillet 2024",
          category: EventCategory.marriage),
      Event(
          title: "Anniversaire de Léo",
          date: "5 Août 2024",
          category: EventCategory.birthday),
      Event(
          title: "Funérailles de M. Dupont",
          date: "15 Septembre 2024",
          category: EventCategory.funeral),
      Event(
          title: "Graduation de Marie",
          date: "30 Juin 2024",
          category: EventCategory.graduation),
      Event(
          title: "Mariage de Laura & Pierre",
          date: "12 Octobre 2024",
          category: EventCategory.marriage),
    ];

    // Trier les événements par catégorie
    Map<EventCategory, List<Event>> groupedEvents = {};
    for (var event in events) {
      groupedEvents.putIfAbsent(event.category, () => []).add(event);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Catégories d'Événements"),
      ),
      body: ListView(
        children: groupedEvents.entries.map((entry) {
          return ExpansionTile(
            title: Text(
              getCategoryLabel(entry.key),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            leading: Icon(getCategoryIcon(entry.key), color: Colors.blue),
            children: entry.value.map((event) {
              return ListTile(
                title: Text(event.title),
                subtitle: Text(event.date),
                leading: const Icon(Icons.event),
              );
            }).toList(),
          );
        }).toList(),
      ),
    );
  }

  // Méthode pour obtenir un label personnalisé pour chaque catégorie
  String getCategoryLabel(EventCategory category) {
    switch (category) {
      case EventCategory.graduation:
        return "🎓 Graduation";
      case EventCategory.marriage:
        return "💍 Mariage";
      case EventCategory.birthday:
        return "🎂 Anniversaire";
      case EventCategory.funeral:
        return "🕊️ Funérailles";
    }
  }

  // Méthode pour associer une icône à chaque catégorie
  IconData getCategoryIcon(EventCategory category) {
    switch (category) {
      case EventCategory.graduation:
        return Icons.school;
      case EventCategory.marriage:
        return Icons.favorite;
      case EventCategory.birthday:
        return Icons.cake;
      case EventCategory.funeral:
        return Icons.local_florist;
    }
  }
}
