import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:reminder_app_challenge/domain/entities/reminder.dart';
import 'package:reminder_app_challenge/domain/usecases/add_reminder.dart';
import 'package:reminder_app_challenge/domain/usecases/get_reminders.dart';

part '../state/reminder_state.dart';

class ReminderCubit extends Cubit<ReminderState> {
  final AddReminder addReminder;
  final GetReminders getReminders;

  ReminderCubit({required this.addReminder, required this.getReminders}) : super(ReminderInitial());

  void loadReminders() async {
    final reminders = await getReminders();
    emit(RemindersLoaded(reminders));
  }

  void addNewReminder(Reminder reminder) async {
    await addReminder(reminder);
    loadReminders();
  }
}
