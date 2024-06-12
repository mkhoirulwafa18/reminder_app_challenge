import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminder_app_challenge/core/themes/app_colors.dart';
import 'package:reminder_app_challenge/core/themes/app_textstyles.dart';
import 'package:reminder_app_challenge/presentation/blocs/cubit/detail_reminder_cubit.dart';
import 'package:reminder_app_challenge/presentation/blocs/cubit/reminder_cubit.dart';
import 'package:reminder_app_challenge/presentation/widgets/reminder_list.dart';
import 'detail_reminder_page.dart';

class ReminderPage extends StatelessWidget {
  const ReminderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reminders'),
        backgroundColor: AppColors.black,
        foregroundColor: Colors.white,
        titleTextStyle: AppTextStyles.title.copyWith(fontSize: 20),
        centerTitle: true,
      ),
      backgroundColor: const Color(0xff1D2228),
      body: BlocBuilder<ReminderCubit, ReminderState>(
        builder: (context, state) {
          if (state is RemindersLoaded) {
            return ReminderList(
              reminders: state.reminders,
              onDeleteReminder: (item) => context.read<DetailReminderCubit>().deleteReminders(item.id),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const DetailReminderPage()),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
