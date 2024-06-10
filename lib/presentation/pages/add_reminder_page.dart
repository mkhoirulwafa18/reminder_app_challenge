import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/reminder.dart';
import '../blocs/cubit/reminder_cubit.dart';

class AddReminderPage extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  AddReminderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Reminder'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            // TODO: Replace with DateTime Picker.
            TextField(
              controller: _timeController,
              decoration: const InputDecoration(labelText: 'Time (HH:MM)'),
              keyboardType: TextInputType.datetime,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final title = _titleController.text;
                final time = DateTime.parse(_timeController.text);
                final reminder = Reminder(id: DateTime.now().toString(), title: title, time: time);
                context.read<ReminderCubit>().addNewReminder(reminder);
                Navigator.pop(context);
              },
              child: const Text('Add Reminder'),
            ),
          ],
        ),
      ),
    );
  }
}
