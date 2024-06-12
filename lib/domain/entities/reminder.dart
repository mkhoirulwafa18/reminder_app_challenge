import 'package:equatable/equatable.dart';
import 'package:reminder_app_challenge/data/models/reminder_model.dart';

class Reminder extends Equatable {
  final String id;
  final String title;
  final String description;
  final DateTime time;
  final RepeatInterval repeatInterval;

  const Reminder({
    required this.id,
    required this.title,
    required this.description,
    required this.time,
    this.repeatInterval = RepeatInterval.none,
  });

  @override
  List<Object> get props => [id, title, description, time, repeatInterval];

  Reminder copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? time,
    RepeatInterval? repeatInterval,
  }) {
    return Reminder(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      time: time ?? this.time,
      repeatInterval: repeatInterval ?? this.repeatInterval,
    );
  }
}
