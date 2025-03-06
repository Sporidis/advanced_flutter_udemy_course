import 'dart:io';

import 'package:advanced_course_udemy/domain/model/model.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/services.dart';

Future<DeviceInfo> getDeviceDetails() async {
  String name = "Unknown";
  String identifier = "Unknown";
  String version = "Unknown";

  DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  try {
    if (Platform.isAndroid) {
      //return android device details
    } else if (Platform.isIOS) {
      //return ios device details
    }
  } on PlatformException {
    // return default data here
    return DeviceInfo(name, identifier, version);
  }
  return DeviceInfo(name, identifier, version);
}
