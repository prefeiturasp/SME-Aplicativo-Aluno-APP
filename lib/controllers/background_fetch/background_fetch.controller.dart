import 'dart:developer';

import 'package:background_fetch/background_fetch.dart';
import 'package:mobx/mobx.dart';

import '../../repositories/responsible_repository.dart';

part 'background_fetch.controller.g.dart';

class BackgroundFetchController = BackgroundFetchControllerBase with _$BackgroundFetchController;

abstract class BackgroundFetchControllerBase with Store {
  late ResponsibleRepository _responsibleRepository;

  BackgroundFetchControllerBase() {
    _responsibleRepository = ResponsibleRepository();
  }

  @observable
  bool responsibleHasStudent = false;

  @action
  Future<void> initPlatformState(
    Function onBackgroundFetch,
    String taskId,
    int delay,
  ) async {
    BackgroundFetch.configure(
      BackgroundFetchConfig(
        minimumFetchInterval: 2,
        forceAlarmManager: false,
        stopOnTerminate: false,
        startOnBoot: true,
        enableHeadless: true,
        requiresBatteryNotLow: false,
        requiresCharging: false,
        requiresStorageNotLow: false,
        requiresDeviceIdle: false,
        requiredNetworkType: NetworkType.NONE,
      ),
      onBackgroundFetch,
    ).then((int status) {
      log('[BackgroundFetch] configure success: $status');
    }).catchError((e) {
      log('[BackgroundFetch] configure ERROR: $e');
    });

    try {
      BackgroundFetch.scheduleTask(
        TaskConfig(
          taskId: taskId,
          delay: delay,
          periodic: true,
          forceAlarmManager: true,
          stopOnTerminate: false,
          enableHeadless: true,
        ),
      );
    } catch (ex) {
      log(ex.toString());
      throw Exception(ex);
    }
  }

  @action
  Future<bool> checkIfResponsibleHasStudent(int userId) async {
    responsibleHasStudent = await _responsibleRepository.checkIfResponsibleHasStudent(userId);
    return responsibleHasStudent;
  }
}
