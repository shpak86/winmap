import 'dart:convert';

import 'package:winmap/data/Account.dart';
import 'package:winmap/data/ConnectionData.dart';
import 'package:winmap/data/DeviceData.dart';
import 'package:winmap/data/NetworkData.dart';
import 'package:winmap/data/TestsData.dart';

class Report {
  Account account;
  DeviceData device;
  List<NetworkData> networks;
  ConnectionData connection;
  TestsData tests;
  String comment;

  Report({Account account, DeviceData device, List<NetworkData> networks, ConnectionData connection, TestsData tests, String comment}) {
    this.account = account;
    this.device = device;
    this.networks = networks;
    this.connection = connection;
    this.tests = tests;
    this.comment = comment;
  }

  Report.fromMap(Map<String, dynamic> map) {
    fromMap(map);
  }

  Report.fromJson(String json) {
    Map<String, dynamic> data = jsonDecode(json);
    try {
      fromMap(data);
    } catch (e) {
      print(e.toString());
    }
  }

  fromMap(Map<String, dynamic> data) {
    if (data.containsKey("account")) account = Account.fromMap(data["account"]);
    if (data.containsKey("device")) device = DeviceData.fromMap(data["device"]);
    if (data.containsKey("networks")) {
      networks = List<NetworkData>.from(data["networks"].map((network) => NetworkData.fromMap(network)).toList());
    }
    if (data.containsKey("connection")) connection = ConnectionData.fromMap(data["connection"]);
    if (data.containsKey("testsKit")) tests = TestsData.fromMap(data["testsKit"]);
    if (data.containsKey("tests")) tests = TestsData.fromMap(data["tests"]);
    if (data.containsKey("comment")) comment = data["comment"];
  }

  Map<String, dynamic> toJson() {
    return {
      "account": account,
      "device": device,
      "connection": connection,
      "networks": networks,
      "testKit": tests,
      "tests": tests,
      "comment": comment,
    };
  }
}
