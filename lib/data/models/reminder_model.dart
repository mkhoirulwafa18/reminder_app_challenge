import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:reminder_app_challenge/domain/entities/reminder.dart';

part 'reminder_model.g.dart';

@HiveType(typeId: 0)
class ReminderModel extends Equatable {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final DateTime time;

  const ReminderModel({required this.id, required this.title, required this.time});

  factory ReminderModel.fromEntity(Reminder reminder) {
    return ReminderModel(
      id: reminder.id,
      title: reminder.title,
      time: reminder.time,
    );
  }

  Reminder toEntity() {
    return Reminder(
      id: id,
      title: title,
      time: time,
    );
  }

  @override
  List<Object> get props => [id, title, time];
}
