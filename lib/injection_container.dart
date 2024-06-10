import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:reminder_app_challenge/data/datasources/reminder_local_datasource.dart';
import 'data/repositories/reminder_repository_impl.dart';
import 'domain/repositories/reminder_repository.dart';
import 'domain/usecases/add_reminder.dart';
import 'domain/usecases/get_reminders.dart';
import 'presentation/blocs/cubit/reminder_cubit.dart';
import 'data/models/reminder_model.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // External
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocumentDir.path);
  Hive.registerAdapter(ReminderModelAdapter());
  final reminderBox = await Hive.openBox<ReminderModel>('reminders');

  // Data sources
  sl.registerLazySingleton<ReminderLocalDataSource>(() => ReminderLocalDataSourceImpl(reminderBox));

  // Repositories
  sl.registerLazySingleton<ReminderRepository>(() => ReminderRepositoryImpl(sl()));

  // Use cases
  sl.registerLazySingleton(() => AddReminder(sl()));
  sl.registerLazySingleton(() => GetReminders(sl()));

  // Cubit
  sl.registerFactory(() => ReminderCubit(
        addReminder: sl(),
        getReminders: sl(),
      ));
}
