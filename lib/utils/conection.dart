import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

enum ConnectivityStatus { wiFi, celular, offline }

class ConnectivityService {
  // Crie nosso controlador público
  StreamController<ConnectivityStatus> connectionStatusController = StreamController<ConnectivityStatus>();
  ConnectivityService() {
    // Assine a conectividade Steam alterado
    Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> result) {
      // Use Connectivity () aqui para obter mais informações, se você precisar
      connectionStatusController.add(_getStatusFromResult(result));
    });
  }
  // Converter da terceira parte enum para a nossa própria enum
  ConnectivityStatus _getStatusFromResult(List<ConnectivityResult> result) {
    switch (result.first) {
      case ConnectivityResult.mobile:
        return ConnectivityStatus.celular;
      case ConnectivityResult.wifi:
        return ConnectivityStatus.wiFi;
      case ConnectivityResult.none:
        return ConnectivityStatus.offline;
      default:
        return ConnectivityStatus.offline;
    }
  }
}
