import 'dart:convert';

import 'package:winmap/data/SpeedMeasuremet.dart';

class TestsData {
  String downloadSpeed = "unknown";
  String uploadSpeed = "unknown";

  List<SpeedMeasurement> speed = [];

  List<int> ports = [];

  TestsData(this.speed, this.ports);

  TestsData.fromMap(Map<String, dynamic> map) {
    fromMap(map);
  }

  TestsData.fromJson(String json) {
    try {
      Map<String, dynamic> data = jsonDecode(json);
      fromMap(data);
    } catch (e) {
      print("Error: ${e.toString()}");
    }
  }

  fromMap(Map<String, dynamic> data) {
    downloadSpeed = data.containsKey("downloadSpeed") ? data["downloadSpeed"] : "unknown";
    uploadSpeed = data.containsKey("uploadSpeed") ? data["uploadSpeed"] : "unknown";
    speed = List<SpeedMeasurement>(); //data.containsKey("speed") ? data["speed"].map((item) => SpeedMeasurement(item.time, item.value, item.type)) : List<SpeedMeasurement>();
    ports = data.containsKey("ports") ? List<int>.from(data["ports"]) : List<int>();
  }

  Map<String, String> toMap() {
    return {
      "downloadSpeed": downloadSpeed,
      "uploadSpeed": uploadSpeed,
      "speed": "",
    };
  }

  Map<String, dynamic> toJson() {
    return {
      "downloadSpeed": downloadSpeed,
      "uploadSpeed": uploadSpeed,
      "speed": speed,
      "ports": ports,
    };
  }
}
