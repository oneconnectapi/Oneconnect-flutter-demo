import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:one_vpn/core/utils/constant.dart';
import 'package:oneconnect_flutter/openvpn_flutter.dart';
import 'package:provider/provider.dart';
import '../../resources/environment.dart';

class IAPProvider with ChangeNotifier {

  Future initialize(BuildContext context) async {

    var key = "";

    if (Platform.isAndroid) {
      key = oneConnectKey;
    } else {
      key = oneConnectKey2;
    }

    AppConstants.openVPN.initializeOneConnect(context, key);

    await allTrueServers(context);
  }

  Future<void> allTrueServers(BuildContext mContext) async {
    AppConstants.vpnServerList.addAll(await AppConstants.openVPN.fetchOneConnect(OneConnect.free)); //Free
    AppConstants.vpnServerList.addAll(await AppConstants.openVPN.fetchOneConnect(OneConnect.pro)); //Pro
  }

  static IAPProvider read(BuildContext context) => context.read();
  static IAPProvider watch(BuildContext context) => context.read();
}


