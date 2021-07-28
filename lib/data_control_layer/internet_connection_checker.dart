import 'dart:async';

import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:pandemicncovidtracker/data_layer/connection_status_data.dart';

class InternetChecker {
  StreamController<InternetConnection> _streamController =
      StreamController<InternetConnection>.broadcast();
  StreamSink<InternetConnection> _sink;
//  InternetConnectionStatus _internetConnectionStatus;
  Stream<InternetConnection> _stream;

  InternetChecker() {
    _sink = _streamController.sink;
    _stream = _streamController.stream;
    _asyncOperation();
  }

  _asyncOperation() async {
    await _checkInternet();
  }

  _checkInternet() {
    DataConnectionChecker().onStatusChange.listen(
      (onData) {
        switch (onData) {
          case DataConnectionStatus.connected:
//            _internetConnectionStatus =
//                InternetConnectionStatus.applyStatus(true);
            _sink.add(InternetConnectionSuccess());
            break;
          case DataConnectionStatus.disconnected:
//            _internetConnectionStatus =
//                InternetConnectionStatus.applyStatus(false);
            _sink.addError(InternetConnectionError());
            break;
        }
      },
      onDone: () {
        _streamController.close();
        _sink.close();
      },
      cancelOnError: false,
    );
  }

  Stream<InternetConnection> get stream => _stream;
}
