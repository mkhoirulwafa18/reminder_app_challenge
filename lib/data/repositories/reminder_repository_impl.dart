// lib/data/repositories/reminder_repository_impl.dart

import 'package:reminder_app_challenge/data/datasources/reminder_local_datasource.dart';

import '../../domain/entities/reminder.dart';
import '../../domain/repositories/reminder_repository.dart';
import '../models/reminder_model.dart';

class ReminderRepositoryImpl implements ReminderRepository {
  final ReminderLocalDataSource localDataSource;

  ReminderRepositoryImpl(this.localDataSource);

  @override
  Future<void> addReminder(Reminder reminder) async {
    final reminderModel = ReminderModel.fromEntity(reminder);
    await localDataSource.addReminder(reminderModel);
  }

  @override
  Future<List<Reminder>> getReminders() async {
    final reminderModels = await localDataSource.getReminders();
    return reminderModels.map((model) => model.toEntity()).toList();
  }
}
