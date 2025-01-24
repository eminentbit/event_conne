import 'package:flutter/material.dart';

class AddEventWidget extends StatefulWidget {
  const AddEventWidget({super.key, required this.onAddEvent});

  final void Function(String name, String date, String location, String description) onAddEvent;

  @override
  State<AddEventWidget> createState() => _AddEventWidgetState();
}

class _AddEventWidgetState extends State<AddEventWidget> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for text fields
  final TextEditingController _eventNameController = TextEditingController();
  final TextEditingController _eventDateController = TextEditingController();
  final TextEditingController _eventLocationController =
      TextEditingController();
  final TextEditingController _eventDescriptionController =
      TextEditingController();
  final TextEditingController _eventTimeController = TextEditingController();

  @override
  void dispose() {
    _eventNameController.dispose();
    _eventDateController.dispose();
    _eventLocationController.dispose();
    _eventDescriptionController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      widget.onAddEvent(
        _eventNameController.text,
        _eventDateController.text,
        _eventLocationController.text,
        _eventDescriptionController.text,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Event added successfully!')),
      );
      Navigator.pop(
          context); // Close the bottom sheet/dialog after adding event
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      height: MediaQuery.of(context).size.height * 0.75,
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min, // Prevents full screen height
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Add Event",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _eventNameController,
              decoration: const InputDecoration(labelText: "Event Name"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter an event name";
                }
                return null;
              },
            ),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _eventDateController,
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          _eventDateController.text =
                              pickedDate.toString().split(' ')[0];
                        });
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter an event date";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: "Event Date",
                      icon: Icon(
                        Icons.calendar_today,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: TextFormField(
                    controller: _eventTimeController,
                    readOnly: true,
                    onTap: () async {
                      TimeOfDay? pickedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (pickedTime != null) {
                        setState(() {
                          _eventTimeController.text =
                              pickedTime.format(context);
                        });
                      }
                    },
                    decoration: const InputDecoration(
                      labelText: "Event Time",
                      icon: Icon(Icons.access_time),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter an event time";
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
            const SizedBox(height: 25),
            TextFormField(
              controller: _eventLocationController,
              decoration: const InputDecoration(labelText: "Location"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter the event location";
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _eventDescriptionController,
              decoration: const InputDecoration(labelText: "Description"),
              maxLines: 3,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter an event description";
                }
                return null;
              },
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _submitForm,
                  child: const Text("Add Event"),
                ),
                // const SizedBox(width: 10),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
