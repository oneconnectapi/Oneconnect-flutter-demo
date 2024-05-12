import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:oneconnect_flutter/openvpn_flutter.dart';

class AppConstants {
  static const int serviceConnectionTimeOut = 60;
  static String apiKey = 'dev';
  static int randomSalt = getRandomSalt();
  static String sign = mD5(apiKey + randomSalt.toString());
  static String packageName = 'com.oneconnect_flutter.android_demo';

  static List<VpnServer> vpnServerList = [];

  static int getRandomSalt() {
    Random random = Random();
    return random.nextInt(900);
  }
  static OpenVPN openVPN = OpenVPN();

  static String mD5(String input) {
    var bytes = utf8.encode(input);
    var digest = md5.convert(bytes);
    return digest.toString();
  }
}
