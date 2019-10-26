import 'dart:convert';
import 'dart:io';

import 'package:winmap/data/Report.dart';

class ReportProvider {
  String _url = "https://94.103.91.144";

  ReportProvider({String url}) {
    if (url != null) _url = url;
  }

  Future<String> send({Report report, String url}) async {
    String result;
    HttpClient client = HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    HttpClientRequest request = await client.putUrl(Uri.parse(url ?? _url));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(jsonEncode(report)));
    HttpClientResponse response = await request.close();
    result = await response.transform(utf8.decoder).join();
    client.close();
    return result;
  }

  Future<Report> load({String id, String url}) async {
    Report report;
    if (id != null) {
      HttpClient client = HttpClient();
      client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
      HttpClientRequest request = await client.getUrl(Uri.parse((url ?? _url) + id.toString()));
      request.headers.set('content-type', 'application/json');
      HttpClientResponse response = await request.close();
      var jsonString = await response.transform(utf8.decoder).join();
      var value = jsonDecode(jsonString)["value"];
      report = Report.fromMap(value);
      client.close();
    }
    return report;
  }
}
