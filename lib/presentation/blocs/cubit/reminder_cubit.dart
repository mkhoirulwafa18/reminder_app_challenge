import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:reminder_app_challenge/domain/entities/reminder.dart';
import 'package:reminder_app_challenge/domain/usecases/reminder_usecases.dart';

part '../state/reminder_state.dart';

class ReminderCubit extends Cubit<ReminderState> {
  final GetRemindersUseCase getRemindersUseCase;

  ReminderCubit({required this.getRemindersUseCase}) : super(ReminderInitial());

  void loadReminders() async {
    final reminders = await getRemindersUseCase.execute();
    emit(RemindersLoaded(reminders));
  }
}
