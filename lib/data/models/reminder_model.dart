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
  final String description;

  @HiveField(3)
  final DateTime time;

  @HiveField(4)
  final RepeatInterval repeatInterval;

  const ReminderModel({
    required this.id,
    required this.title,
    required this.description,
    required this.time,
    this.repeatInterval = RepeatInterval.none,
  });

  factory ReminderModel.fromEntity(Reminder reminder) {
    return ReminderModel(
      id: reminder.id,
      title: reminder.title,
      description: reminder.description,
      time: reminder.time,
      repeatInterval: reminder.repeatInterval,
    );
  }

  Reminder toEntity() {
    return Reminder(
      id: id,
      title: title,
      description: description,
      time: time,
      repeatInterval: repeatInterval,
    );
  }

  @override
  List<Object> get props => [id, title, description, time, repeatInterval];
}

@HiveType(typeId: 1)
enum RepeatInterval {
  @HiveField(0)
  none,

  @HiveField(1)
  daily,

  @HiveField(2)
  weekly,

  @HiveField(3)
  monthly
}
