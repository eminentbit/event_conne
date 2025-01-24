import 'package:flutter/material.dart';

class SettingsOption extends StatefulWidget {
  final IconData icon;
  final String title;
  final bool isSwitch;
  final void Function()? onClick; // Nullable function

  const SettingsOption({
    super.key,
    required this.icon,
    required this.title,
    this.onClick,
    this.isSwitch = false,
  });

  @override
  State<SettingsOption> createState() => _SettingsOptionState();
}

class _SettingsOptionState extends State<SettingsOption> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(widget.icon, color: Colors.blueAccent),
        title: Text(widget.title, style: const TextStyle(fontSize: 16)),
        trailing: widget.isSwitch
            ? Switch(
                value: isDarkMode,
                onChanged: (value) {
                  setState(() {
                    isDarkMode = value;
                  });
                  print("Dark mode: $isDarkMode");
                },
              )
            : const Icon(Icons.arrow_forward_ios),
        onTap: widget.isSwitch ? null : widget.onClick, // ✅ Corrected behavior
      ),
    );
  }
}