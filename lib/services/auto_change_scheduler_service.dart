import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:quowally/services/background_task_handler.dart';
import 'package:workmanager/workmanager.dart';

class AutoChangeSchedulerService {
  static const String taskId = 'auto_change_task_id';
  static const int iD = 101;
  static const String taskName = 'auto_change_wallpaper_task';

  /// Call this to schedule the periodic wallpaper change
  static Future<void> scheduleAutoChangeTask(int intervalInMinutes) async {
    if (intervalInMinutes < 15) {
      print('⚠️ Minimum allowed interval is 15 minutes on Android.');
      return;
    }

    // // Schedule every intervalMinutes
    // await AndroidAlarmManager.periodic(
    //   Duration(minutes: intervalInMinutes),
    //   iD, // unique ID
    //   autoChangeWallpaperTask,
    //   wakeup: true,
    //   exact: true,
    //   rescheduleOnReboot: true,
    // );



    await Workmanager().registerPeriodicTask(
      taskId, // Unique task ID
      taskName, // Task name
      frequency: Duration(minutes: intervalInMinutes),
      initialDelay: const Duration(seconds: 10),
      existingWorkPolicy:
          ExistingWorkPolicy.replace, // Replace if already scheduled
      constraints: Constraints(
        networkType: NetworkType.not_required, // Optional
        requiresCharging: false,
        requiresDeviceIdle: false,
        requiresBatteryNotLow: true,
      ),
    );

    print(
        '✅ Auto wallpaper change task scheduled every $intervalInMinutes minutes.');
  }

  /// Call this to stop auto-change when toggle is disabled
  static Future<void> cancelAutoChangeTask() async {
    await Workmanager().cancelByUniqueName(taskId);
    print('❌ Auto wallpaper change task cancelled.');
  }
}
