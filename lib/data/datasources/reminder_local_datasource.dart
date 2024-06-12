import 'package:hive/hive.dart';
import 'package:reminder_app_challenge/data/models/reminder_model.dart';

/// An abstract class defining the local data source for reminders.
abstract class ReminderLocalDataSource {
  /// Adds a reminder to the local data source.
  ///
  /// [reminder] is the reminder model to be added.
  Future<void> addReminder(ReminderModel reminder);

  /// Retrieves all reminders from the local data source.
  ///
  /// Returns a list of all reminder models.
  Future<List<ReminderModel>> getReminders();

  /// Updates a reminder in the local data source.
  ///
  /// [reminder] is the reminder model to be updated.
  Future<void> updateReminder(ReminderModel reminder);

  /// Deletes a reminder from the local data source by its ID.
  ///
  /// [id] is the unique identifier of the reminder to be deleted.
  Future<void> deleteReminder(String id);
}

/// Implementation of the local data source for reminders using Hive.
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

  @override
  Future<void> updateReminder(ReminderModel reminder) async {
    await reminderBox.put(reminder.id, reminder);
  }

  @override
  Future<void> deleteReminder(String id) async {
    await reminderBox.delete(id);
  }
}
