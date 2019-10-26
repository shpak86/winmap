import 'package:tcp_scanner/tcp_scanner.dart';

class Scanner {
  static String _host;
  static int _startPort;
  static int _endPort;
  static TCPScanner _tcpScanner;

  static scan(String host, String startPort, String endPort) {
    bool result = false;
    if (_tcpScanner == null || _tcpScanner.scanResult.status != ScanStatuses.scanning) {
      _host = host;
      _startPort = int.parse(startPort);
      _endPort = int.parse(endPort);
      _tcpScanner = TCPScanner.range(_host, _startPort, _endPort, timeout: 5000);
      _tcpScanner.scan();
      result = true;
    }
    return result;
  }

  static TCPScanner get tcpScanner => _tcpScanner;

  static int get endPort => _endPort;

  static int get startPort => _startPort;

  static String get host => _host;

  static ScanStatuses get status => _tcpScanner == null ? ScanStatuses.unknown : _tcpScanner.scanResult.status;

  static double get percent {
    if (_tcpScanner == null) {
      return 0;
    } else {
      return (_tcpScanner.scanResult.scanned.length / _tcpScanner.scanResult.ports.length) * 100.0;
    }
  }

  static ScanResult get result => _tcpScanner == null ? ScanResult() : _tcpScanner.scanResult;

  static clear() {
    _tcpScanner = null;
  }
}
