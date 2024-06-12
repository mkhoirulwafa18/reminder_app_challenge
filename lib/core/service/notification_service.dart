// ignore_for_file: depend_on_referenced_packages
import 'package:flutter_local_notifications/flutter_local_notifications.dart' hide RepeatInterval;
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:notification_permissions/notification_permissions.dart';
import 'package:reminder_app_challenge/data/models/reminder_model.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationService {
  NotificationService() {
    _initialize();
  }

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  /// Initializes the notification service.
  ///
  /// This includes requesting notification permissions, configuring the
  /// timezone, and initializing the notification settings for Android and iOS.
  Future<void> _initialize() async {
    final permissionStatus = await NotificationPermissions.getNotificationPermissionStatus();

    if (permissionStatus == PermissionStatus.unknown || permissionStatus == PermissionStatus.denied) {
      await NotificationPermissions.requestNotificationPermissions();
    }

    // Configure Timezone
    tz.initializeTimeZones();
    final timeZone = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZone));

    // Initialize Notification
    const initializationSettingsDarwin = DarwinInitializationSettings();
    const initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');

    const initializationSettings = InitializationSettings(
      iOS: initializationSettingsDarwin,
      android: initializationSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  /// Shows a simple notification immediately.
  ///
  /// This is primarily used for testing purposes.
  Future<void> showNotification() async {
    await flutterLocalNotificationsPlugin.show(
      123,
      'Test Notification!',
      'Sudah waktunya untuk notif',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'reminder_channel',
          'Reminders',
          channelDescription: 'Channel for reminder notifications',
          importance: Importance.max,
          priority: Priority.high,
          autoCancel: false,
          enableLights: true,
          visibility: NotificationVisibility.public,
        ),
        iOS: DarwinNotificationDetails(),
      ),
    );
  }

  /// Schedules a notification at a specific time with optional repeat interval.
  ///
  /// [id] is a unique identifier for the notification.
  /// [title] is the notification title.
  /// [desc] is the notification description.
  /// [time] is the DateTime when the notification should be shown.
  /// [repeatInterval] specifies the repeat interval for the notification (e.g., daily, weekly, etc.).
  Future<void> scheduleNotification({
    required String id,
    required String title,
    required String desc,
    required DateTime time,
    RepeatInterval repeatInterval = RepeatInterval.none,
  }) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id.hashCode,
      title,
      desc,
      tz.TZDateTime.from(time, tz.local),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'reminder_channel',
          'Reminders',
          channelDescription: 'Channel for reminder notifications',
          importance: Importance.max,
          priority: Priority.high,
          autoCancel: false,
          enableLights: true,
          visibility: NotificationVisibility.public,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      // ignore: deprecated_member_use
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: _getDateTimeComponents(repeatInterval),
    );
  }

  /// Determines the DateTimeComponents based on the repeat interval.
  ///
  /// This is used to specify how frequently the notification should repeat.
  /// [repeatInterval] specifies the repeat interval for the notification (e.g., daily, weekly, etc.).
  /// Returns the appropriate DateTimeComponents for the specified repeat interval.
  DateTimeComponents? _getDateTimeComponents(RepeatInterval repeatInterval) {
    switch (repeatInterval) {
      case RepeatInterval.daily:
        return DateTimeComponents.time;
      case RepeatInterval.weekly:
        return DateTimeComponents.dayOfWeekAndTime;
      case RepeatInterval.monthly:
        return DateTimeComponents.dayOfMonthAndTime;
      case RepeatInterval.none:
      default:
        return DateTimeComponents.dateAndTime;
    }
  }

  /// Cancels a scheduled notification.
  ///
  /// [id] is the unique identifier for the notification to be cancelled.
  Future<void> cancelNotification(String id) async {
    await flutterLocalNotificationsPlugin.cancel(id.hashCode);
  }
}
