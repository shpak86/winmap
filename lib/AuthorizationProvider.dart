import 'dart:convert';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

class AuthorizationProvider {
  static String _email;
  static String _password;
  static bool _authorized = false;

  static String get password => _password;

  static String get email => _email;

  static bool get authorized => _authorized;

  static Future<bool> _checkAuthentication(String email, String password) async {
    final url = Uri.parse("https://94.103.91.144/rest/auth");
    String result;
    HttpClient client = HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    HttpClientRequest request = await client.postUrl(url);
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(jsonEncode({
      "email": email,
      "password": password
    })));
    HttpClientResponse response = await request.close();
    result = await response.transform(utf8.decoder).join();
    client.close();
    return jsonDecode(result)["value"];
  }

  static Future<bool> check({String email, String password}) async {
    if (email == null || password == null) {
      var preferences = await SharedPreferences.getInstance();
      if (preferences.containsKey("email")) email = preferences.getString("email");
      if (preferences.containsKey("password")) password = preferences.getString("password");
    }
    if (email != null && email.isNotEmpty && password != null && password.isNotEmpty) {
      _authorized = await _checkAuthentication(email, password);
      if (_authorized) {
        _setAuthorizationData(email, password);
      }
    }
    return _authorized;
  }

  static exit() {
    _setAuthorizationData(null, null);
    _authorized = false;
  }

  static _setAuthorizationData(email, password) async {
    _email = email;
    _password = password;
    var preferences = await SharedPreferences.getInstance();
    preferences.setString("email", _email ?? "");
    preferences.setString("password", _password ?? "");
  }
}
