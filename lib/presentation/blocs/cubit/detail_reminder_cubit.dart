import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminder_app_challenge/domain/entities/reminder.dart';
import 'package:reminder_app_challenge/domain/usecases/reminder_usecases.dart';
import 'package:reminder_app_challenge/core/dependency_injection/injection_container.dart';
import 'package:reminder_app_challenge/core/service/notification_service.dart';

class DetailReminderCubit extends Cubit<Reminder> {
  final AddReminderUseCase addReminderUseCase;
  final GetRemindersUseCase getReminderUseCase;
  final UpdateReminderUseCase updateReminderUseCase;
  final DeleteReminderUseCase deleteReminderUseCase;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  DetailReminderCubit({
    required this.addReminderUseCase,
    required this.getReminderUseCase,
    required this.updateReminderUseCase,
    required this.deleteReminderUseCase,
  }) : super(Reminder(id: '', title: '', description: '', time: DateTime.now()));

  void loadReminder(Reminder reminder) async {
    emit(reminder);
    titleController.text = reminder.title;
    descriptionController.text = reminder.description;
  }

  void updateReminderForm(Reminder updatedReminder) {
    emit(state.copyWith(
        description: updatedReminder.description,
        id: updatedReminder.id,
        repeatInterval: updatedReminder.repeatInterval,
        time: updatedReminder.time,
        title: updatedReminder.title));
  }

  Future<void> updateReminder() async {
    emit(state);
    titleController.text = state.title;
    descriptionController.text = state.description;

    final reminders = await getReminderUseCase.execute();
    final isExist = reminders.indexWhere((element) => element.id == state.id);
    if (isExist != -1) {
      await updateReminderUseCase.execute(state);
    } else {
      await addReminderUseCase.execute(state);
    }
    await sl<NotificationService>().scheduleNotification(
      id: state.id,
      title: state.title,
      desc: state.description,
      time: state.time,
      repeatInterval: state.repeatInterval,
    );
  }

  void deleteReminders(String id) async {
    await deleteReminderUseCase.execute(id);
    await sl<NotificationService>().cancelNotification(id);
  }
}
