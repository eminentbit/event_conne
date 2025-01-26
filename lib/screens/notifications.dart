import 'package:flutter/material.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Notifications', style: TextStyle(fontFamily: 'Open Sans')),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: NotificationsList(),
    );
  }
}

class NotificationsList extends StatelessWidget {
  final List<Map<String, String>> notifications = [
    {
      'type': 'Invitation',
      'title': 'Event Invitation',
      'content': 'You are invited to the annual gala.',
      'timestamp': '10:00 AM',
      'eventName': 'Annual Gala',
      'eventDateTime': '25th Jan, 6:00 PM',
      'eventLocation': 'City Hall',
      'eventDescription': 'A formal event with dinner and entertainment.'
    },
    // {
    //   'type': 'Event Update',
    //   'title': 'Event Time Changed',
    //   'content': 'The meeting time has been updated.',
    //   'timestamp': '9:30 AM'
    // },
    // {
    //   'type': 'Event Reminder',
    //   'title': 'Reminder: Team Meeting',
    //   'content': 'Don\'t forget the team meeting today.',
    //   'timestamp': '8:00 AM'
    // },
  ];

  NotificationsList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        final notification = notifications[index];
        return ListTile(
          title: Text(notification['title']!, style: const TextStyle(fontFamily: 'Open Sans')),
          subtitle: Text(notification['content']!, style: const TextStyle(fontFamily: 'Open Sans')),
          trailing: Text(notification['timestamp']!, style: const TextStyle(fontFamily: 'Open Sans')),
          onTap: () {
            if (notification['type'] == 'Invitation') {
              showDialog(
                context: context,
                builder: (context) {
                  return InvitationPopup(notification: notification);
                },
              );
            }
          },
        );
      },
    );
  }
}

class InvitationPopup extends StatelessWidget {
  final Map<String, String> notification;

  const InvitationPopup({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(notification['eventName']!, style: const TextStyle(fontFamily: 'Open Sans')),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Date & Time: ${notification['eventDateTime']}', style: const TextStyle(fontFamily: 'Open Sans')),
          const SizedBox(height: 8),
          Text('Location: ${notification['eventLocation']}', style: const TextStyle(fontFamily: 'Open Sans')),
          const SizedBox(height: 8),
          if (notification['eventDescription'] != null)
            Text('Description: ${notification['eventDescription']}', style: const TextStyle(fontFamily: 'Open Sans')),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Decline', style: TextStyle(fontFamily: 'Open Sans')),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Accept', style: TextStyle(fontFamily: 'Open Sans')),
        ),
      ],
    );
  }
}
