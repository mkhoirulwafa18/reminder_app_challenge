part of '../cubit/reminder_cubit.dart';

abstract class ReminderState extends Equatable {
  const ReminderState();

  @override
  List<Object> get props => [];
}

class ReminderInitial extends ReminderState {}

class RemindersLoaded extends ReminderState {
  final List<Reminder> reminders;

  const RemindersLoaded(this.reminders);

  @override
  List<Object> get props => [reminders];
}
