import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminder_app_challenge/presentation/blocs/cubit/reminder_cubit.dart';
import 'package:reminder_app_challenge/presentation/widgets/reminder_list.dart';
import 'add_reminder_page.dart';

class ReminderPage extends StatelessWidget {
  const ReminderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reminders'),
      ),
      body: BlocBuilder<ReminderCubit, ReminderState>(
        builder: (context, state) {
          if (state is RemindersLoaded) {
            return ReminderList(reminders: state.reminders);
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddReminderPage()),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
