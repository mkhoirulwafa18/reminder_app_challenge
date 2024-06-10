import 'package:flutter/material.dart';
import 'package:reminder_app_challenge/domain/entities/reminder.dart';

class ReminderList extends StatelessWidget {
  final List<Reminder> reminders;

  const ReminderList({super.key, required this.reminders});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: reminders.length,
      itemBuilder: (context, index) {
        final reminder = reminders[index];
        return ListTile(
          title: Text(reminder.title),
          subtitle: Text(reminder.time.toString()),
          trailing: const Icon(Icons.notifications),
        );
      },
    );
  }
}
