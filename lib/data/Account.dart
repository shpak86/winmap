import 'dart:convert';

class Account {
  String email;

  String password;

  Account(this.email, this.password);

  Account.fromMap(Map<String, dynamic> map) {
    fromMap(map);
  }

  Account.fromJson(String json) {
    try {
      Map<String, dynamic> data = jsonDecode(json);
      fromMap(data);
    } catch (e) {
      print(e.toString());
    }
  }

  fromMap(Map<String, dynamic> data) {
    this.email = data["email"];
    this.password = data["password"];
  }

  Map<String, String> toMap() {
    return {
      "email": email,
      "password": password
    };
  }

  Map<String, dynamic> toJson() {
    return toMap();
  }
}
