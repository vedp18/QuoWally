import 'package:workmanager/workmanager.dart';

class AutoChangeSchedulerService {
  static const String taskId = '108';
  static const String taskName = 'auto_change_quowally';

  /// Call this to schedule the periodic wallpaper change
  static scheduleAutoChangeTask(
    int intervalInMinutes, {
    required double physicalHt,
    required double physicalWd,
  }) {
    ///? this was for testing purpose
    // Workmanager().registerOneOffTask(taskId, taskName,
    //     existingWorkPolicy: ExistingWorkPolicy.replace,
    //     inputData: {
    //       "physicalHt": physicalHt,
    //       "physicalWd": physicalWd,
    //     });

    // task to periodically call bg task
    Workmanager().registerPeriodicTask(
      taskId, // Unique task ID
      taskName, // Task name
      frequency: Duration(minutes: intervalInMinutes),
      // initialDelay: const Duration(seconds: 10),
      existingWorkPolicy:
          ExistingWorkPolicy.replace, // Replace if already scheduled
      inputData: {
        "physicalHt": physicalHt,
        "physicalWd": physicalWd,
      },
      // initialDelay: Duration(minutes: intervalInMinutes),
      // constraints: Constraints(
      //   networkType: NetworkType.not_required, // Optional
      //   requiresCharging: false,
      //   requiresDeviceIdle: false,
      //   requiresBatteryNotLow: true,
      // ),
    );

    Workmanager().registerOneOffTask(
      taskId,
      taskName,
      existingWorkPolicy: ExistingWorkPolicy.replace,
      inputData: {
        "physicalHt": physicalHt,
        "physicalWd": physicalWd,
      },
    );

    print(
        '✅ Auto wallpaper change task scheduled every $intervalInMinutes minutes.');
  }

  /// Call this to stop auto-change when toggle is disabled
  static cancelAutoChangeTask() {
    Workmanager().cancelByUniqueName(taskId);
    print('❌ Auto wallpaper change task cancelled.');
  }
}
