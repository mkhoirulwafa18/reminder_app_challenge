import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:reminder_app_challenge/data/datasources/reminder_local_datasource.dart';
import 'package:reminder_app_challenge/domain/usecases/reminder_usecases.dart';
import 'package:reminder_app_challenge/core/service/notification_service.dart';
import 'package:reminder_app_challenge/presentation/blocs/cubit/detail_reminder_cubit.dart';
import '../../data/repositories/reminder_repository_impl.dart';
import '../../domain/repositories/reminder_repository.dart';
import '../../presentation/blocs/cubit/reminder_cubit.dart';
import '../../data/models/reminder_model.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // External
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocumentDir.path);
  Hive.registerAdapter(ReminderModelAdapter());
  Hive.registerAdapter(RepeatIntervalAdapter());
  final reminderBox = await Hive.openBox<ReminderModel>('reminders');

  // Notification Service
  final notificationService = NotificationService();
  sl.registerLazySingleton<NotificationService>(() => notificationService);

  // Data sources
  sl.registerLazySingleton<ReminderLocalDataSource>(() => ReminderLocalDataSourceImpl(reminderBox));

  // Repositories
  sl.registerLazySingleton<ReminderRepository>(() => ReminderRepositoryImpl(sl()));

  // Use cases
  sl.registerLazySingleton(() => AddReminderUseCase(sl()));
  sl.registerLazySingleton(() => GetRemindersUseCase(sl()));
  sl.registerLazySingleton(() => UpdateReminderUseCase(sl()));
  sl.registerLazySingleton(() => DeleteReminderUseCase(sl()));

  // Cubit
  sl.registerFactory(() => ReminderCubit(getRemindersUseCase: sl()));
  sl.registerFactory(() => DetailReminderCubit(
        addReminderUseCase: sl(),
        getReminderUseCase: sl(),
        updateReminderUseCase: sl(),
        deleteReminderUseCase: sl(),
      ));
}
