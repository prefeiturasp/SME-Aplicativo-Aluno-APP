import 'dart:developer';

import 'package:background_fetch/background_fetch.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:sentry/sentry.dart';

import '../../repositories/responsible_repository.dart';

part 'background_fetch.controller.g.dart';

class BackgroundFetchController = BackgroundFetchControllerBase with _$BackgroundFetchController;

abstract class BackgroundFetchControllerBase with Store {
  final ResponsibleRepository _responsibleRepository = ResponsibleRepository();

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
      GetIt.I.get<SentryClient>().captureException(e);
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
      GetIt.I.get<SentryClient>().captureException('BackgroundFetchController $ex');
    }
  }

  @action
  Future<bool> checkIfResponsibleHasStudent(int userId) async {
    const int numeroTentativas = 5;
    responsibleHasStudent = await responsavelPorAlgumEstudante(userId);
    while (!responsibleHasStudent) {
      for (int index = 1; index <= numeroTentativas; index++) {
        responsibleHasStudent = await responsavelPorAlgumEstudante(userId);
        if (responsibleHasStudent) return responsibleHasStudent;
      }
      return responsibleHasStudent;
    }
    return responsibleHasStudent;
  }

  Future<bool> responsavelPorAlgumEstudante(int userId) async {
    return await _responsibleRepository.checkIfResponsibleHasStudent(userId);
  }
}
