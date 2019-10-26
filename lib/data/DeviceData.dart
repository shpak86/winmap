import 'dart:convert';

class DeviceData {
  String fileSeparator;
  String javaClassPath;
  String javaHome;
  String javaIoTmpdir;
  String javaLibraryPath;
  String javaVendor;
  String javaVendorUrl;
  String javaSpecificationVersion;
  String javaSpecificationVendor;
  String javaSpecificationName;
  String javaVmVersion;
  String javaVmVendor;
  String javaVmName;
  String javaVmSpecificationVersion;
  String javaVmSpecificationVendor;
  String javaVmSpecificationName;
  String javaBootClassPath;
  String lineSeparator;
  String osArch;
  String osName;
  String osVersion;
  String pathSeparator;
  String userDir;
  String userHome;
  String userName;
  String versionCodename;
  String versionIncremental;
  String versionPreviewSdkInt;
  String versionRelease;
  String versionSdkInt;
  String versionSecurityPatch;
  String board;
  String bootloader;
  String brand;
  String device;
  String display;
  String fingerprint;
  String hardware;
  String host;
  String id;
  String manufacturer;
  String model;
  String product;
  String supportedAbis32;
  String supportedAbis64;
  String supportedAbis;
  String tags;
  String time;
  String type;
  String user;

  DeviceData.fromMap(Map<String, dynamic> map) {
    fromMap(map);
  }

  DeviceData.fromJson(String json) {
    fromMap(jsonDecode(json));
  }

  fromMap(Map<String, dynamic> map) {
    fileSeparator = map.containsKey("file.separator") ? map["file.separator"] : map["fileSeparator"];
    javaClassPath = map.containsKey("java.class.path") ? map["java.class.path"] : map["javaClassPath"];
    javaHome = map.containsKey("java.home") ? map["java.home"] : map["javaHome"];
    javaIoTmpdir = map.containsKey("java.io.tmpdir") ? map["java.io.tmpdir"] : map["javaIoTmpdir"];
    javaLibraryPath = map.containsKey("java.library.path") ? map["java.library.path"] : map["javaLibraryPath"];
    javaVendor = map.containsKey("java.vendor") ? map["java.vendor"] : map["javaVendor"];
    javaVendorUrl = map.containsKey("java.vendor.url") ? map["java.vendor.url"] : map["javaVendorUrl"];
    javaSpecificationVersion = map.containsKey("java.specification.version") ? map["java.specification.version"] : map["javaSpecificationVersion"];
    javaSpecificationVendor = map.containsKey("java.specification.vendor") ? map["java.specification.vendor"] : map["javaSpecificationVendor"];
    javaSpecificationName = map.containsKey("java.specification.name") ? map["java.specification.name"] : map["javaSpecificationName"];
    javaVmVersion = map.containsKey("java.vm.version") ? map["java.vm.version"] : map["javaVmVersion"];
    javaVmVendor = map.containsKey("java.vm.vendor") ? map["java.vm.vendor"] : map["javaVmVendor"];
    javaVmName = map.containsKey("java.vm.name") ? map["java.vm.name"] : map["javaVmName"];
    javaVmSpecificationVersion = map.containsKey("java.vm.specification.version") ? map["java.vm.specification.version"] : map["javaVmSpecificationVersion"];
    javaVmSpecificationVendor = map.containsKey("java.vm.specification.vendor") ? map["java.vm.specification.vendor"] : map["javaVmSpecificationVendor"];
    javaVmSpecificationName = map.containsKey("java.vm.specification.name") ? map["java.vm.specification.name"] : map["javaVmSpecificationName"];
    javaBootClassPath = map.containsKey("java.boot.class.path") ? map["java.boot.class.path"] : map["javaBootClassPath"];
    lineSeparator = map.containsKey("line.separator") ? map["line.separator"] : map["lineSeparator"];
    osArch = map.containsKey("os.arch") ? map["os.arch"] : map["osArch"];
    osName = map.containsKey("os.name") ? map["os.name"] : map["osName"];
    osVersion = map.containsKey("os.version") ? map["os.version"] : map["osVersion"];
    pathSeparator = map.containsKey("path.separator") ? map["path.separator"] : map["pathSeparator"];
    userDir = map.containsKey("user.dir") ? map["user.dir"] : map["userDir"];
    userHome = map.containsKey("user.home") ? map["user.home"] : map["userHome"];
    userName = map.containsKey("user.name") ? map["user.name"] : map["userName"];
    versionCodename = map.containsKey("versionCodename") ? map["versionCodename"] : map["versionCodename"];
    versionIncremental = map.containsKey("versionIncremental") ? map["versionIncremental"] : map["versionIncremental"];
    versionPreviewSdkInt = map.containsKey("versionPreviewSdkInt") ? map["versionPreviewSdkInt"] : map["versionPreviewSdkInt"];
    versionRelease = map.containsKey("versionRelease") ? map["versionRelease"] : map["versionRelease"];
    versionSdkInt = map.containsKey("versionSdkInt") ? map["versionSdkInt"] : map["versionSdkInt"];
    versionSecurityPatch = map.containsKey("versionSecurityPatch") ? map["versionSecurityPatch"] : map["versionSecurityPatch"];
    board = map.containsKey("board") ? map["board"] : map["board"];
    bootloader = map.containsKey("bootloader") ? map["bootloader"] : map["bootloader"];
    brand = map.containsKey("brand") ? map["brand"] : map["brand"];
    device = map.containsKey("device") ? map["device"] : map["device"];
    display = map.containsKey("display") ? map["display"] : map["display"];
    fingerprint = map.containsKey("fingerprint") ? map["fingerprint"] : map["fingerprint"];
    hardware = map.containsKey("hardware") ? map["hardware"] : map["hardware"];
    host = map.containsKey("host") ? map["host"] : map["host"];
    id = map.containsKey("id") ? map["id"] : map["id"];
    manufacturer = map.containsKey("manufacturer") ? map["manufacturer"] : map["manufacturer"];
    model = map.containsKey("model") ? map["model"] : map["model"];
    product = map.containsKey("product") ? map["product"] : map["product"];
    supportedAbis32 = map.containsKey("supportedAbis32") ? map["supportedAbis32"] : map["supportedAbis32"];
    supportedAbis64 = map.containsKey("supportedAbis64") ? map["supportedAbis64"] : map["supportedAbis64"];
    supportedAbis = map.containsKey("supportedAbis") ? map["supportedAbis"] : map["supportedAbis"];
    tags = map.containsKey("tags") ? map["tags"] : map["tags"];
    time = map.containsKey("time") ? map["time"] : map["time"];
    type = map.containsKey("type") ? map["type"] : map["type"];
    user = map.containsKey("user") ? map["user"] : map["user"];
  }

  Map<String, String> toMap() {
    return {
      "fileSeparator": fileSeparator,
      "javaClassPath": javaClassPath,
      "javaHome": javaHome,
      "javaIoTmpdir": javaIoTmpdir,
      "javaLibraryPath": javaLibraryPath,
      "javaVendor": javaVendor,
      "javaVendorUrl": javaVendorUrl,
      "javaSpecificationVersion": javaSpecificationVersion,
      "javaSpecificationVendor": javaSpecificationVendor,
      "javaSpecificationName": javaSpecificationName,
      "javaVmVersion": javaVmVersion,
      "javaVmVendor": javaVmVendor,
      "javaVmName": javaVmName,
      "javaVmSpecificationVersion": javaVmSpecificationVersion,
      "javaVmSpecificationVendor": javaVmSpecificationVendor,
      "javaVmSpecificationName": javaVmSpecificationName,
      "javaBootClassPath": javaBootClassPath,
      "lineSeparator": lineSeparator,
      "osArch": osArch,
      "osName": osName,
      "osVersion": osVersion,
      "pathSeparator": pathSeparator,
      "userDir": userDir,
      "userHome": userHome,
      "userName": userName,
      "versionCodename": versionCodename,
      "versionIncremental": versionIncremental,
      "versionPreviewSdkInt": versionPreviewSdkInt,
      "versionRelease": versionRelease,
      "versionSdkInt": versionSdkInt,
      "versionSecurityPatch": versionSecurityPatch,
      "board": board,
      "bootloader": bootloader,
      "brand": brand,
      "device": device,
      "display": display,
      "fingerprint": fingerprint,
      "hardware": hardware,
      "host": host,
      "id": id,
      "manufacturer": manufacturer,
      "model": model,
      "product": product,
      "supportedAbis32": supportedAbis32,
      "supportedAbis64": supportedAbis64,
      "supportedAbis": supportedAbis,
      "tags": tags,
      "time": time,
      "type": type,
      "user": user,
    };
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> result;
    try {
      result = toMap();
    } catch (e) {
      print(e.toString());
    }
    return result;
  }
}
