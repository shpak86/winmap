import 'dart:convert';

class ConnectionData {
  String mac;
  String ip;
  String speed;
  String frequency;
  String ssid;
  String level;
  String type;
  String gateway;
  String dns1;
  String dns2;
  String hidden;
  String bssid;

  ConnectionData(this.mac, this.ip, this.speed, this.frequency, this.ssid, this.level, this.type, this.gateway, this.dns1, this.dns2, this.hidden, this.bssid);

  ConnectionData.fromMap(Map<String, dynamic> data) {
    fromMap(data);
  }

  ConnectionData.fromJson(String json) {
    try {
      Map<String, dynamic> data = jsonDecode(json);
      fromMap(data);
    } catch (e) {
      print(e.toString());
    }
  }

  fromMap(Map<String, dynamic> data) {
    mac = data["mac"].split(":").map((item) => item.length == 1 ? "0$item" : item).join(":");
    ip = data["ip"];
    speed = data["speed"];
    frequency = data["frequency"];
    ssid = data["ssid"];
    level = data["level"];
    type = data["type"];
    gateway = data["gareway"];
    dns1 = data["dns1"];
    dns2 = data["dns2"];
    hidden = data["hidden"];
    bssid = data["bssid"];
  }

  Map<String, String> toMap() {
    return {
      "mac": mac,
      "ip": ip,
      "speed": speed,
      "frequency": frequency,
      "ssid": ssid,
      "level": level,
      "type": type,
      "gateway": gateway,
      "dns1": dns1,
      "dns2": dns2,
      "hidden": hidden,
      "bssid": bssid,
    };
  }

  Map<String, dynamic> toJson() {
    return toMap();
  }
}
