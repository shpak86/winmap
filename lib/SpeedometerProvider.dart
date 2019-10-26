import 'dart:async';

import 'package:winmap/data/SpeedMeasuremet.dart';
import 'package:intl/intl.dart';

import 'Speedometer.dart';

class SpeedometerProvider {
  static Timer _timer;
  static List<SpeedMeasurement> _barList = [];
  static String uploadURL = "https://94.103.91.144/rest/1mb/";
  static String downloadURL = "https://94.103.91.144/rest/1mb/";
  static bool _downloadComplete = true;
  static bool _uploadComplete = true;

  static _download() async {
    _downloadComplete = false;
    Speedometer speedometer = Speedometer();
    speedometer.getDownloadSpeed(downloadURL).then((value) {
      _barList.insert(0, SpeedMeasurement(DateFormat("HH:mm:ss").format(DateTime.now()), value["mbit-sec"].toStringAsFixed(1), "download"));
      if (_barList.length > 50) _barList.removeLast();
      _downloadComplete = true;
    });
  }

  static _upload() async {
    _uploadComplete = false;
    Speedometer speedometer = Speedometer();
    speedometer.getUploadSpeed(uploadURL).then((value) {
      _barList.insert(0, SpeedMeasurement(DateFormat("HH:mm:ss").format(DateTime.now()), value["mbit-sec"].toStringAsFixed(1), "upload"));
      if (_barList.length > 50) _barList.removeLast();
      _uploadComplete = true;
    });
  }

  static start({int seconds = 2, int count = 5}) {
    if (_timer == null || !_timer.isActive) {
      _barList.clear();
      int counter = 0;
      _timer = Timer.periodic(Duration(seconds: seconds), (timer) {
        if (_downloadComplete) _download();
        if (_uploadComplete) _upload();
        if (counter++ == count) stop();
      });
    }
  }

  static stop() {
    _timer.cancel();
    _timer = null;
  }

  static List<SpeedMeasurement> get barList => List.from(_barList);

  static bool get isActive => _timer != null;
}
