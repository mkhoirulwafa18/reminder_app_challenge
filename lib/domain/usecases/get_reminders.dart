import 'package:reminder_app_challenge/domain/entities/reminder.dart';
import 'package:reminder_app_challenge/domain/repositories/reminder_repository.dart';

class GetReminders {
  final ReminderRepository repository;

  GetReminders(this.repository);

  Future<List<Reminder>> call() async {
    return repository.getReminders();
  }
}
