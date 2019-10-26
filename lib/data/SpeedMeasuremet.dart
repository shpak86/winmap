import 'dart:convert';

class SpeedMeasurement {
  String time;
  String value;
  String type;

  SpeedMeasurement(this.time, this.value, this.type);

  SpeedMeasurement.fromJson(String json) {
    try {
      Map<String, dynamic> data = jsonDecode(json);
      fromMap(data);
    } catch (e) {
      print(e.toString());
    }
  }

  fromMap(Map<String, dynamic> data) {
    time = data["time"];
    value = data["value"];
    type = data["type"];
  }

  Map<String, String> toMap() {
    return {
      "time": time,
      "value": value,
      "type": type,
    };
  }

  Map<String, dynamic> toJson() {
    return toMap();
  }
}
