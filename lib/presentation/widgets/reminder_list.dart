import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:reminder_app_challenge/core/themes/app_colors.dart';
import 'package:reminder_app_challenge/core/themes/app_textstyles.dart';
import 'package:reminder_app_challenge/domain/entities/reminder.dart';
import 'package:reminder_app_challenge/core/service/notification_service.dart';
import 'package:reminder_app_challenge/presentation/pages/detail_reminder_page.dart';

class ReminderList extends StatelessWidget {
  final List<Reminder> reminders;
  final void Function(Reminder) onDeleteReminder;
  const ReminderList({super.key, required this.reminders, required this.onDeleteReminder});

  @override
  Widget build(BuildContext context) {
    if (reminders.isNotEmpty) {
      return ListView.builder(
        itemCount: reminders.length,
        itemBuilder: (context, index) {
          final reminder = reminders[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Slidable(
                key: UniqueKey(),
                endActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  dismissible: DismissiblePane(onDismissed: () => onDeleteReminder(reminder)),
                  children: [
                    SlidableAction(
                      onPressed: (context) => onDeleteReminder(reminder),
                      backgroundColor: const Color(0xFFFE4A49),
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: 'Delete',
                    ),
                  ],
                ),
                child: ListTile(
                  title: Text(
                    reminder.title,
                    style: AppTextStyles.bodyMd.copyWith(color: AppColors.black),
                  ),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DetailReminderPage(existingReminder: reminder)),
                  ),
                  tileColor: AppColors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  subtitle: Text(
                    '${reminder.time.hour}:${reminder.time.minute.toString().length == 1 ? "0${reminder.time.minute}" : "${reminder.time.minute}"}',
                    style: AppTextStyles.body,
                  ),
                  trailing: IconButton.outlined(
                      onPressed: () async {
                        await NotificationService().showNotification();
                      },
                      icon: const Icon(Icons.notifications)),
                )),
          );
        },
      );
    } else {
      return Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset(
            'assets/empty.png',
            width: MediaQuery.of(context).size.width * 0.5,
          ),
          const SizedBox(height: 12),
          Text(
            'There is no reminder yet\nTry add new reminder',
            style: AppTextStyles.bodyMd,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
              onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const DetailReminderPage()),
                  ),
              icon: const Icon(Icons.add),
              label: const Text('Add Reminder'))
        ]),
      );
    }
  }
}
