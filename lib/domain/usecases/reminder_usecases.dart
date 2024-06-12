import 'dart:developer';

import 'package:reminder_app_challenge/domain/entities/reminder.dart';
import 'package:reminder_app_challenge/domain/repositories/reminder_repository.dart';

class AddReminderUseCase {
  final ReminderRepository _repository;

  AddReminderUseCase(this._repository);

  Future<void> execute(Reminder reminder) async {
    try {
      await _repository.addReminder(reminder);
    } catch (e) {
      log('Error adding reminder: $e');
      rethrow;
    }
  }
}

class GetRemindersUseCase {
  final ReminderRepository _repository;

  GetRemindersUseCase(this._repository);

  Future<List<Reminder>> execute() async {
    try {
      return await _repository.getReminders();
    } catch (e) {
      log('Error getting reminders: $e');
      rethrow;
    }
  }
}

class UpdateReminderUseCase {
  final ReminderRepository _repository;

  UpdateReminderUseCase(this._repository);

  Future<void> execute(Reminder reminder) async {
    try {
      await _repository.updateReminder(reminder);
    } catch (e) {
      log('Error updating reminder: $e');
      rethrow;
    }
  }
}

class DeleteReminderUseCase {
  final ReminderRepository _repository;

  DeleteReminderUseCase(this._repository);

  Future<void> execute(String id) async {
    try {
      await _repository.deleteReminder(id);
    } catch (e) {
      log('Error deleting reminder: $e');
      rethrow;
    }
  }
}
