import 'dart:convert';
import 'dart:io';

class Speedometer {
  String payload =
      "12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678";
  var body;

  Speedometer() {
    // Create 1 MB string
    for (int i = 0; i < 13; i++) payload = payload + payload;
    body = utf8.encode(jsonEncode(payload));
  }

  Future<Map<String, double>> getDownloadSpeed(String url) async {
    HttpClient client = HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    var start = DateTime.now().millisecondsSinceEpoch;
    HttpClientRequest request = await client.getUrl(Uri.parse(url));
    var msDuration = DateTime.now().millisecondsSinceEpoch - start;
    request.close();
    client.close();
    var sDuration = msDuration * 1000;
    var mByteSec = 1024 * 1024 / sDuration;
    var mBitSec = mByteSec * 8;
    return {"mbit-sec": mBitSec, "mbyte-sec": mByteSec, "load-duration": msDuration.toDouble()};
  }

  Future<Map<String, double>> getUploadSpeed(String url) async {
    HttpClient client = HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    var start = DateTime.now().millisecondsSinceEpoch;
    HttpClientRequest request = await client.putUrl(Uri.parse(url));
    request.add(body);
    var msDuration = DateTime.now().millisecondsSinceEpoch - start;
    request.close();
    client.close();
    var sDuration = msDuration * 1000;
    var mByteSec = 1024 * 1024 / sDuration;
    var mBitSec = mByteSec * 8;
    return {"mbit-sec": mBitSec, "mbyte-sec": mByteSec, "load-duration": msDuration.toDouble()};
  }
}
