import 'package:hive/hive.dart';
import 'package:reminder_app_challenge/data/models/reminder_model.dart';

abstract class ReminderLocalDataSource {
  Future<void> addReminder(ReminderModel reminder);
  Future<List<ReminderModel>> getReminders();
}

class ReminderLocalDataSourceImpl implements ReminderLocalDataSource {
  final Box<ReminderModel> reminderBox;

  ReminderLocalDataSourceImpl(this.reminderBox);

  @override
  Future<void> addReminder(ReminderModel reminder) async {
    await reminderBox.put(reminder.id, reminder);
  }

  @override
  Future<List<ReminderModel>> getReminders() async {
    return reminderBox.values.toList();
  }
}
