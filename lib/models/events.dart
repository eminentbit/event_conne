enum Category {
  marriage,
  birthday,
  funeral
}


class Event {
  final String id;
  final String name;
  final DateTime date;
  final String location;
  final String description;
  final String image;
  final String time;
  final Category category;
  final String createdBy;

  List<String> invitees;

  Event(
      {required this.id,
      required this.name,
      required this.date,
      required this.location,
      required this.description,
      required this.image,
      required this.createdBy,
      required this.category,
      required this.time,
      this.invitees = const []
      });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
        id: json['id'],
        name: json['name'],
        date: DateTime.parse(json['date']),
        location: json['location'],
        description: json['description'],
        image: json['image'],
        time: json['time'],
        createdBy: json['createdBy'], 
        category: json['category']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'date': date.toIso8601String(),
      'location': location,
      'description': description,
      'image': image,
      'time': time,
      'createdBy': createdBy
    };
  }
}
