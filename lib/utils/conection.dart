import 'dart:async';
import 'package:connectivity/connectivity.dart';

enum ConnectivityStatus { WiFi, Celular, Offline }

class ConnectivityService {
  // Crie nosso controlador público
  StreamController<ConnectivityStatus> connectionStatusController =
      StreamController<ConnectivityStatus>();
  ConnectivityService() {
    // Assine a conectividade Steam alterado
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      // Use Connectivity () aqui para obter mais informações, se você precisar
      connectionStatusController.add(_getStatusFromResult(result));
    });
  }
  // Converter da terceira parte enum para a nossa própria enum
  ConnectivityStatus _getStatusFromResult(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.mobile:
        return ConnectivityStatus.Celular;
      case ConnectivityResult.wifi:
        return ConnectivityStatus.WiFi;
      case ConnectivityResult.none:
        return ConnectivityStatus.Offline;
      default:
        return ConnectivityStatus.Offline;
    }
  }
}
