import 'dart:convert';

class NetworkData {
  String ssid;
  String bssid;
  String capabilities;
  String centerFreq0;
  String centerFreq1;
  String channelWidth;
  String frequency;
  String level;

  NetworkData(this.ssid, this.bssid, this.capabilities, this.centerFreq0, this.centerFreq1, this.channelWidth, this.frequency, this.level);

  NetworkData.fromMap(Map<String, dynamic> map) {
    fromMap(map);
  }

  NetworkData.fromJson(String json) {
    try {
      Map<String, dynamic> data = jsonDecode(json);
      fromMap(data);
    } catch (e) {
      print("Error: ${e.toString()}");
    }
  }

  fromMap(Map<String, dynamic> data) {
    ssid = data.containsKey("ssid") ? data["ssid"] : "unknown";
    bssid = data.containsKey("bssid") ? data["bssid"] : "unknown";
    capabilities = data.containsKey("capabilities") ? data["capabilities"] : "unknown";
    centerFreq0 = data.containsKey("centerFreq0") ? data["centerFreq0"] : "unknown";
    centerFreq1 = data.containsKey("centerFreq1") ? data["centerFreq1"] : "unknown";
    channelWidth = data.containsKey("channelWidth") ? data["channelWidth"] : "unknown";
    frequency = data.containsKey("frequency") ? data["frequency"] : "unknown";
    level = data.containsKey("level") ? data["level"] : "unknown";
  }

  Map<String, String> toMap() {
    return {
      "ssid": ssid,
      "bssid": bssid,
      "capabilities": capabilities,
      "centerFreq0": centerFreq0,
      "centerFreq1": centerFreq1,
      "channelWidth": channelWidth,
      "frequency": frequency,
      "level": level,
    };
  }

  Map<String, dynamic> toJson() {
    return {
      "ssid": ssid,
      "bssid": bssid,
      "capabilities": capabilities,
      "centerFreq0": centerFreq0,
      "centerFreq1": centerFreq1,
      "channelWidth": channelWidth,
      "frequency": frequency,
      "level": level,
    };
  }
}
