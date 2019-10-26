import 'package:winmap/data/NetworkData.dart';

enum NetworkFrequency { mhz2400, mhz5000, all }
enum NetworksSortOrder { ssidAsc, ssidDesc, bssidAsc, bssidDesc, signalAsc, signalDesc, none }

class NetworksDisplaySettings {
  static String _ssid = "";
  static String _bssid = "";
  static NetworkFrequency _frequency = NetworkFrequency.all;
  static NetworksSortOrder _order = NetworksSortOrder.none;

  static List<NetworkData> filter(List<NetworkData> networks) {
    List<NetworkData> result = [];
    if (networks != null) {
      result = List.from(networks);
      if (_ssid.isNotEmpty) {
        result.removeWhere((network) => !network.ssid.toLowerCase().contains(_ssid.toLowerCase()));
      }
      if (_bssid.isNotEmpty) {
        result.removeWhere((network) {
          return !network.bssid.toLowerCase().contains(_bssid.toLowerCase());
        });
      }
      if (_frequency == NetworkFrequency.mhz2400) {
        result.removeWhere((network) => network.frequency.startsWith("5"));
      } else if (_frequency == NetworkFrequency.mhz5000) {
        result.removeWhere((network) => network.frequency.startsWith("2"));
      }

      if (_order == NetworksSortOrder.bssidAsc) {
        result.sort((n1, n2) => n1.bssid.compareTo(n2.bssid));
      } else if (_order == NetworksSortOrder.bssidDesc) {
        result.sort((n1, n2) => n2.bssid.compareTo(n1.bssid));
      } else if (_order == NetworksSortOrder.ssidAsc) {
        result.sort((n1, n2) => n1.ssid.compareTo(n2.ssid));
      } else if (_order == NetworksSortOrder.ssidDesc) {
        result.sort((n1, n2) => n2.ssid.compareTo(n1.ssid));
      } else if (_order == NetworksSortOrder.signalAsc) {
        result.sort((n1, n2) => n2.level.compareTo(n1.level));
      } else if (_order == NetworksSortOrder.ssidDesc) {
        result.sort((n1, n2) => n1.level.compareTo(n2.level));
      }
    }
    return result;
  }

  static update({String ssid, String bssid, NetworkFrequency frequency, NetworksSortOrder order}) {
    if (ssid != null) _ssid = ssid;
    if (bssid != null) _bssid = bssid;
    if (frequency != null) _frequency = frequency;
    if (order != null) _order = order;
  }

  static NetworksSortOrder get order => _order;

  static NetworkFrequency get frequency => _frequency;

  static String get bssid => _bssid;

  static String get ssid => _ssid;

  static bool isDefault() {
    return _ssid.isEmpty && _bssid.isEmpty && _frequency == NetworkFrequency.all && _order == NetworksSortOrder.none;
  }

  static setDefault() {
    _ssid = "";
    _bssid = "";
    _frequency = NetworkFrequency.all;
    _order = NetworksSortOrder.none;
  }
}
