import 'package:reminder_app_challenge/domain/entities/reminder.dart';
import 'package:reminder_app_challenge/domain/repositories/reminder_repository.dart';

class AddReminder {
  final ReminderRepository repository;

  AddReminder(this.repository);

  Future<void> call(Reminder reminder) async {
    return repository.addReminder(reminder);
  }
  // TODO: Set Local Notif at time picked by user using flutter_local_notifications
}
