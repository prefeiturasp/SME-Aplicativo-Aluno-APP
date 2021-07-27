import 'package:background_fetch/background_fetch.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:sentry/sentry.dart';
import 'package:sme_app_aluno/repositories/responsible_repository.dart';

part 'background_fetch.controller.g.dart';

class BackgroundFetchController = _BackgroundFetchControllerBase
    with _$BackgroundFetchController;

abstract class _BackgroundFetchControllerBase with Store {
  ResponsibleRepository _responsibleRepository;

  _BackgroundFetchControllerBase() {
    _responsibleRepository = ResponsibleRepository();
  }

  @observable
  bool responsibleHasStudent;

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
            onBackgroundFetch)
        .then((int status) {
      print('[BackgroundFetch] configure success: $status');
    }).catchError((e) {
      print('[BackgroundFetch] configure ERROR: $e');
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
      ).catchError(print);
    } catch (ex) {
      GetIt.I.get<SentryClient>().captureException(exception: ex);
      print(ex.toString());
    }
  }

  @action
  Future<bool> checkIfResponsibleHasStudent(int userId) async {
    responsibleHasStudent =
        await _responsibleRepository.checkIfResponsibleHasStudent(userId);
    return responsibleHasStudent;
  }
}
