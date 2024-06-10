import 'package:reminder_app_challenge/domain/entities/reminder.dart';

abstract class ReminderRepository {
  Future<void> addReminder(Reminder reminder);
  Future<List<Reminder>> getReminders();
}
